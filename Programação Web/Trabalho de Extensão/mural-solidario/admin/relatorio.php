<?php
require '../config/conexao.php';
require '../includes/funcoes.php';
exigirLogin();

// Ano escolhido no filtro (padrão: ano atual)
$ano = isset($_GET['ano']) ? (int) $_GET['ano'] : (int) date('Y');

$nomesMeses = [1 => 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
               'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];

// Doações recebidas por mês no ano escolhido
$sql = "SELECT MONTH(recebido_em) AS mes,
               COUNT(*) AS total_doacoes,
               COUNT(DISTINCT nome_doador) AS total_doadores
        FROM doacoes
        WHERE status = 'recebida' AND YEAR(recebido_em) = ?
        GROUP BY MONTH(recebido_em)
        ORDER BY mes";
$stmt = $pdo->prepare($sql);
$stmt->execute([$ano]);
$porMes = $stmt->fetchAll();

// Quantidade recebida por categoria no ano escolhido
$sql = "SELECT c.nome AS categoria,
               COUNT(d.id) AS total_doacoes,
               SUM(d.quantidade) AS total_itens
        FROM doacoes d
        INNER JOIN necessidades n ON n.id = d.necessidade_id
        INNER JOIN categorias c ON c.id = n.categoria_id
        WHERE d.status = 'recebida' AND YEAR(d.recebido_em) = ?
        GROUP BY c.id
        ORDER BY total_itens DESC";
$stmt = $pdo->prepare($sql);
$stmt->execute([$ano]);
$porCategoria = $stmt->fetchAll();

$titulo = 'Relatório';
$base = '../';
require '../includes/cabecalho.php';
?>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="h3 mb-0"><i class="bi bi-bar-chart-fill text-success"></i> Relatório de doações recebidas</h1>
    <form method="get" class="d-flex gap-2">
        <input type="number" name="ano" class="form-control" style="width: 110px" value="<?= $ano ?>">
        <button class="btn btn-outline-secondary">Filtrar</button>
    </form>
</div>

<div class="row">
    <div class="col-md-6 mb-4">
        <h2 class="h5">Por mês (<?= $ano ?>)</h2>
        <table class="table table-striped bg-white">
            <thead>
                <tr><th>Mês</th><th>Doações</th><th>Doadores</th></tr>
            </thead>
            <tbody>
                <?php if (count($porMes) === 0): ?>
                    <tr><td colspan="3" class="text-muted">Nenhuma doação recebida neste ano.</td></tr>
                <?php endif; ?>
                <?php foreach ($porMes as $linha): ?>
                    <tr>
                        <td><?= $nomesMeses[$linha['mes']] ?></td>
                        <td><?= $linha['total_doacoes'] ?></td>
                        <td><?= $linha['total_doadores'] ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>

    <div class="col-md-6 mb-4">
        <h2 class="h5">Por categoria (<?= $ano ?>)</h2>
        <table class="table table-striped bg-white">
            <thead>
                <tr><th>Categoria</th><th>Doações</th><th>Itens recebidos</th></tr>
            </thead>
            <tbody>
                <?php if (count($porCategoria) === 0): ?>
                    <tr><td colspan="3" class="text-muted">Nenhuma doação recebida neste ano.</td></tr>
                <?php endif; ?>
                <?php foreach ($porCategoria as $linha): ?>
                    <tr>
                        <td><?= e($linha['categoria']) ?></td>
                        <td><?= $linha['total_doacoes'] ?></td>
                        <td><?= $linha['total_itens'] ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>

<button onclick="window.print()" class="btn btn-outline-secondary"><i class="bi bi-printer-fill"></i> Imprimir relatório</button>

<?php require '../includes/rodape.php'; ?>
