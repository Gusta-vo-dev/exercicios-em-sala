<?php
require '../config/conexao.php';
require '../includes/funcoes.php';
exigirLogin();

// Ações rápidas da tabela (vêm de formulários POST)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = (int) ($_POST['id'] ?? 0);
    $acao = $_POST['acao'] ?? '';

    if ($acao === 'encerrar') {
        $pdo->prepare("UPDATE necessidades SET status = 'encerrada' WHERE id = ?")->execute([$id]);
        mensagem('Necessidade encerrada. Ela não aparece mais no mural.');
    } elseif ($acao === 'reabrir') {
        $pdo->prepare("UPDATE necessidades SET status = 'aberta' WHERE id = ?")->execute([$id]);
        mensagem('Necessidade reaberta.');
    } elseif ($acao === 'urgente') {
        // Inverte: se era urgente vira normal, se era normal vira urgente
        $pdo->prepare('UPDATE necessidades SET urgente = 1 - urgente WHERE id = ?')->execute([$id]);
        mensagem('Prioridade do item atualizada.');
    }

    header('Location: necessidades.php');
    exit;
}

// Lista todas as necessidades com o total recebido
$sql = "SELECT n.*, c.nome AS categoria, c.icone, c.cor,
               COALESCE(SUM(CASE WHEN d.status = 'recebida' THEN d.quantidade END), 0) AS recebido
        FROM necessidades n
        INNER JOIN categorias c ON c.id = n.categoria_id
        LEFT JOIN doacoes d ON d.necessidade_id = n.id
        GROUP BY n.id
        ORDER BY n.status, n.urgente DESC, c.nome, n.titulo";
$necessidades = $pdo->query($sql)->fetchAll();

$titulo = 'Necessidades';
$base = '../';
require '../includes/cabecalho.php';
?>

<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
    <h1 class="h3 mb-0"><i class="bi bi-list-check text-success"></i> Necessidades</h1>
    <a href="necessidade_form.php" class="btn btn-verde"><i class="bi bi-plus-lg"></i> Nova necessidade</a>
</div>

<div class="table-responsive">
    <table class="table bg-white align-middle">
        <thead>
            <tr>
                <th>Item</th>
                <th>Categoria</th>
                <th style="min-width: 160px">Progresso</th>
                <th>Status</th>
                <th class="text-end">Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($necessidades as $n): ?>
                <?php $pct = porcentagem($n['recebido'], $n['meta']); ?>
                <tr class="<?= $n['status'] === 'encerrada' ? 'text-muted' : '' ?>">
                    <td>
                        <div class="d-flex align-items-center gap-2">
                            <?php if (!empty($n['imagem'])): ?>
                                <img src="../<?= e($n['imagem']) ?>" alt="" class="thumb-admin">
                            <?php endif; ?>
                            <div>
                                <?= e($n['titulo']) ?>
                                <?php if ($n['urgente']): ?>
                                    <span class="badge bg-danger"><i class="bi bi-lightning-fill"></i> Urgente</span>
                                <?php endif; ?>
                            </div>
                        </div>
                    </td>
                    <td style="color: <?= e($n['cor']) ?>"><i class="bi bi-<?= e($n['icone']) ?>"></i> <?= e($n['categoria']) ?></td>
                    <td>
                        <div class="progress mb-1" style="height: 8px">
                            <div class="progress-bar" style="width: <?= $pct ?>%"></div>
                        </div>
                        <small><?= $n['recebido'] ?> / <?= $n['meta'] ?> <?= e($n['unidade']) ?> (<?= $pct ?>%)</small>
                    </td>
                    <td>
                        <?php if ($n['status'] === 'aberta'): ?>
                            <span class="badge bg-success">Aberta</span>
                        <?php else: ?>
                            <span class="badge bg-secondary">Encerrada</span>
                        <?php endif; ?>
                    </td>
                    <td class="text-end text-nowrap">
                        <a href="necessidade_form.php?id=<?= $n['id'] ?>" class="btn btn-sm btn-outline-primary" title="Editar">
                            <i class="bi bi-pencil-fill"></i>
                        </a>
                        <form method="post" class="d-inline">
                            <input type="hidden" name="id" value="<?= $n['id'] ?>">
                            <button name="acao" value="urgente" class="btn btn-sm <?= $n['urgente'] ? 'btn-danger' : 'btn-outline-danger' ?>"
                                    title="<?= $n['urgente'] ? 'Tirar urgência' : 'Marcar como urgente' ?>">
                                <i class="bi bi-lightning-fill"></i>
                            </button>
                            <?php if ($n['status'] === 'aberta'): ?>
                                <button name="acao" value="encerrar" class="btn btn-sm btn-outline-secondary" title="Encerrar"
                                        onclick="return confirm('Encerrar esta necessidade? Ela sai do mural.')">
                                    <i class="bi bi-archive-fill"></i>
                                </button>
                            <?php else: ?>
                                <button name="acao" value="reabrir" class="btn btn-sm btn-outline-success" title="Reabrir">
                                    <i class="bi bi-arrow-counterclockwise"></i>
                                </button>
                            <?php endif; ?>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php require '../includes/rodape.php'; ?>
