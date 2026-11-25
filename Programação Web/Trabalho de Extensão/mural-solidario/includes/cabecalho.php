<?php
// Cabeçalho usado em todas as páginas
// Antes de incluir, a página pode definir:
//   $titulo -> título da aba
//   $base   -> caminho até a raiz do projeto ('' na área pública, '../' no admin)
$titulo = $titulo ?? 'Mural Solidário';
$base = $base ?? '';
$emAdmin = ($base === '../');

// Nome do arquivo atual (ex.: index.php), usado para destacar o link do menu
$paginaAtual = basename($_SERVER['PHP_SELF']);

// Monta um link do menu já com a classe "active" quando for a página atual
function linkMenu($href, $icone, $texto, $paginaAtual)
{
    $ativo = (basename($href) === $paginaAtual) ? 'active' : '';
    echo '<li class="nav-item"><a class="nav-link ' . $ativo . '" href="' . $href . '">'
        . '<i class="bi bi-' . $icone . ' me-1"></i>' . $texto . '</a></li>';
}
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= e($titulo) ?> | Mural Solidário</title>
    <!-- Fonte Nunito (Google Fonts) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap e Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<?= $base ?>css/estilo.css" rel="stylesheet">
</head>
<body class="<?= $emAdmin ? 'area-admin' : 'area-publica' ?>">

<nav class="navbar navbar-expand-lg navbar-dark bg-verde sticky-top shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="<?= $base ?>index.php">
            <span class="logo"><i class="bi bi-box2-heart-fill"></i></span>
            Mural Solidário
            <?php if ($emAdmin && isset($_SESSION['usuario_id'])): ?>
                <span class="badge bg-light text-success ms-1">Admin</span>
            <?php endif; ?>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto">
                <?php if ($emAdmin && isset($_SESSION['usuario_id'])): ?>
                    <?php
                    linkMenu('index.php', 'speedometer2', 'Painel', $paginaAtual);
                    linkMenu('necessidades.php', 'list-check', 'Necessidades', $paginaAtual);
                    linkMenu('doacoes.php', 'truck', 'Doações', $paginaAtual);
                    linkMenu('categorias.php', 'tags-fill', 'Categorias', $paginaAtual);
                    linkMenu('relatorio.php', 'bar-chart-fill', 'Relatório', $paginaAtual);
                    ?>
                    <li class="nav-item">
                        <a class="nav-link" href="../index.php" target="_blank"><i class="bi bi-eye me-1"></i>Ver site</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.php"><i class="bi bi-box-arrow-right me-1"></i>Sair</a>
                    </li>
                <?php else: ?>
                    <?php
                    linkMenu($base . 'index.php', 'grid-fill', 'Necessidades', $paginaAtual);
                    linkMenu($base . 'sobre.php', 'info-circle-fill', 'Sobre a entidade', $paginaAtual);
                    ?>
                    <li class="nav-item ms-lg-2">
                        <a class="nav-link btn-entidade" href="<?= $base ?>admin/login.php"><i class="bi bi-lock-fill me-1"></i>Área da entidade</a>
                    </li>
                <?php endif; ?>
            </ul>
        </div>
    </div>
</nav>

<?php if ($emAdmin): ?>
<main class="container py-4">
<?php else: ?>
<main>
<?php endif; ?>

<?php if (isset($_SESSION['mensagem'])): ?>
    <div class="<?= $emAdmin ? '' : 'container pt-3' ?>">
        <?php mostrarMensagem(); ?>
    </div>
<?php endif; ?>
