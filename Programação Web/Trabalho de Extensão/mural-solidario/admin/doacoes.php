<?php
require '../config/conexao.php';
require '../includes/funcoes.php';
exigirLogin();

// Marcar uma doação como recebida ou cancelada
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = (int) ($_POST['id'] ?? 0);
    $acao = $_POST['acao'] ?? '';

    // Só dá para mudar o status de doações que ainda estão "prometida"
    if ($acao === 'receber') {
        $sql = "UPDATE doacoes SET status = 'recebida', recebido_em = NOW() WHERE id = ? AND status = 'prometida'";
        $pdo->prepare($sql)->execute([$id]);
        mensagem('Doação confirmada como recebida!');
    } elseif ($acao === 'cancelar') {
        $sql = "UPDATE doacoes SET status = 'cancelada' WHERE id = ? AND status = 'prometida'";
        $pdo->prepare($sql)->execute([$id]);
        mensagem('Doação cancelada.', 'warning');
    }

    header('Location: doacoes.php?status=' . urlencode($_GET['status'] ?? 'prometida'));
    exit;
}

// Filtro por status (padrão: mostrar as prometidas, que são as que precisam de ação)
$statusValidos = ['prometida', 'recebida', 'cancelada', 'todas'];
$status = $_GET['status'] ?? 'prometida';
if (!in_array($status, $statusValidos)) {
    $status = 'prometida';
}

$sql = "SELECT d.*, n.titulo, n.unidade
        FROM doacoes d
        INNER JOIN necessidades n ON n.id = d.necessidade_id";
$parametros = [];
if ($status !== 'todas') {
    $sql .= ' WHERE d.status = ?';
    $parametros[] = $status;
}
$sql .= ' ORDER BY d.data_prevista DESC';

$stmt = $pdo->prepare($sql);
$stmt->execute($parametros);
$doacoes = $stmt->fetchAll();

$titulo = 'Doações';
$base = '../';
require '../includes/cabecalho.php';
?>

<h1 class="h3 mb-3"><i class="bi bi-truck text-success"></i> Doações</h1>

<ul class="nav nav-pills mb-3">
    <?php foreach ($statusValidos as $s): ?>
        <li class="nav-item">
            <a class="nav-link <?= $status === $s ? 'active bg-verde' : '' ?>" href="doacoes.php?status=<?= $s ?>">
                <?= ucfirst($s === 'todas' ? $s : $s . 's') ?>
            </a>
        </li>
    <?php endforeach; ?>
</ul>

<?php if (count($doacoes) === 0): ?>
    <p class="text-muted">Nenhuma doação encontrada.</p>
<?php else: ?>
    <div class="table-responsive">
        <table class="table bg-white align-middle">
            <thead>
                <tr>
                    <th>Entrega</th>
                    <th>Doador</th>
                    <th>Telefone</th>
                    <th>Item</th>
                    <th>Qtd.</th>
                    <th>Status</th>
                    <th class="text-end">Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($doacoes as $d): ?>
                    <tr>
                        <td><?= dataBR($d['data_prevista']) ?></td>
                        <td><?= e($d['nome_doador']) ?></td>
                        <td><?= e($d['telefone']) ?></td>
                        <td><?= e($d['titulo']) ?></td>
                        <td><?= $d['quantidade'] ?> <?= e($d['unidade']) ?></td>
                        <td>
                            <?php if ($d['status'] === 'prometida'): ?>
                                <span class="badge bg-warning text-dark">Prometida</span>
                            <?php elseif ($d['status'] === 'recebida'): ?>
                                <span class="badge bg-success">Recebida em <?= dataBR($d['recebido_em']) ?></span>
                            <?php else: ?>
                                <span class="badge bg-secondary">Cancelada</span>
                            <?php endif; ?>
                        </td>
                        <td class="text-end">
                            <?php if ($d['status'] === 'prometida'): ?>
                                <form method="post" action="doacoes.php?status=<?= $status ?>" class="d-inline">
                                    <input type="hidden" name="id" value="<?= $d['id'] ?>">
                                    <button name="acao" value="receber" class="btn btn-sm btn-success"><i class="bi bi-check-lg"></i> Recebi</button>
                                    <button name="acao" value="cancelar" class="btn btn-sm btn-outline-danger"
                                            onclick="return confirm('Cancelar esta doação?')">Cancelar</button>
                                </form>
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
<?php endif; ?>

<?php require '../includes/rodape.php'; ?>
