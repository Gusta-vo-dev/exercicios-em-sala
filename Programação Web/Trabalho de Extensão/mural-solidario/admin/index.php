<?php
require '../config/conexao.php';
require '../includes/funcoes.php';
exigirLogin();

// Números do painel
$totalAbertas = $pdo->query("SELECT COUNT(*) FROM necessidades WHERE status = 'aberta'")->fetchColumn();
$totalUrgentes = $pdo->query("SELECT COUNT(*) FROM necessidades WHERE status = 'aberta' AND urgente = 1")->fetchColumn();
$totalPrometidas = $pdo->query("SELECT COUNT(*) FROM doacoes WHERE status = 'prometida'")->fetchColumn();
$recebidasMes = $pdo->query("SELECT COUNT(*) FROM doacoes
                             WHERE status = 'recebida'
                               AND MONTH(recebido_em) = MONTH(CURDATE())
                               AND YEAR(recebido_em) = YEAR(CURDATE())")->fetchColumn();

// Próximas entregas (doações prometidas, da data mais próxima para a mais distante)
$sql = "SELECT d.*, n.titulo, n.unidade
        FROM doacoes d
        INNER JOIN necessidades n ON n.id = d.necessidade_id
        WHERE d.status = 'prometida'
        ORDER BY d.data_prevista
        LIMIT 10";
$proximas = $pdo->query($sql)->fetchAll();

// Cards do topo: [número, texto, ícone, cor]
$cards = [
    [$totalAbertas, 'necessidades abertas', 'list-check', '#2e7d5b'],
    [$totalUrgentes, 'itens urgentes', 'lightning-fill', '#e5484d'],
    [$totalPrometidas, 'doações a caminho', 'truck', '#4a8fd9'],
    [$recebidasMes, 'recebidas este mês', 'check-circle-fill', '#e8913a'],
];

$titulo = 'Painel';
$base = '../';
require '../includes/cabecalho.php';
?>

<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <h1 class="h3 mb-0">Olá, <?= e($_SESSION['usuario_nome']) ?>! 👋</h1>
    <a href="necessidade_form.php" class="btn btn-verde"><i class="bi bi-plus-lg"></i> Nova necessidade</a>
</div>

<div class="row g-3 mb-4">
    <?php foreach ($cards as $card): ?>
        <div class="col-6 col-lg-3">
            <div class="card card-painel h-100">
                <div class="card-body d-flex align-items-center gap-3">
                    <div class="icone-painel" style="background-color: <?= $card[3] ?>1f; color: <?= $card[3] ?>">
                        <i class="bi bi-<?= $card[2] ?>"></i>
                    </div>
                    <div>
                        <div class="h3 fw-bold mb-0"><?= $card[0] ?></div>
                        <div class="small text-muted"><?= $card[1] ?></div>
                    </div>
                </div>
            </div>
        </div>
    <?php endforeach; ?>
</div>

<div class="card card-painel">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="h5 fw-bold mb-0"><i class="bi bi-calendar-event text-success"></i> Próximas entregas</h2>
            <a href="doacoes.php" class="btn btn-sm btn-outline-success">Gerenciar doações</a>
        </div>

        <?php if (count($proximas) === 0): ?>
            <p class="text-muted mb-0">Nenhuma doação prometida no momento.</p>
        <?php else: ?>
            <div class="table-responsive">
                <table class="table align-middle mb-2">
                    <thead>
                        <tr>
                            <th>Data</th>
                            <th>Doador</th>
                            <th>Telefone</th>
                            <th>Item</th>
                            <th>Qtd.</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($proximas as $d): ?>
                            <?php $atrasada = $d['data_prevista'] < date('Y-m-d'); ?>
                            <tr class="<?= $atrasada ? 'table-warning' : '' ?>">
                                <td>
                                    <?= dataBR($d['data_prevista']) ?>
                                    <?php if ($atrasada): ?><span class="badge bg-warning text-dark">atrasada</span><?php endif; ?>
                                    <?php if ($d['data_prevista'] === date('Y-m-d')): ?><span class="badge bg-success">hoje</span><?php endif; ?>
                                </td>
                                <td><?= e($d['nome_doador']) ?></td>
                                <td><?= e($d['telefone']) ?></td>
                                <td><?= e($d['titulo']) ?></td>
                                <td><?= $d['quantidade'] ?> <?= e($d['unidade']) ?></td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        <?php endif; ?>
    </div>
</div>

<?php require '../includes/rodape.php'; ?>
