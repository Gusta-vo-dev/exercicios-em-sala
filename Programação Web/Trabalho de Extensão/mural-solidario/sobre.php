<?php
require 'config/conexao.php';
require 'includes/funcoes.php';

// Alguns números para mostrar na página
$totalDoacoes = $pdo->query("SELECT COUNT(*) FROM doacoes WHERE status = 'recebida'")->fetchColumn();
$totalItens = $pdo->query("SELECT COALESCE(SUM(quantidade), 0) FROM doacoes WHERE status = 'recebida'")->fetchColumn();

$linkMapa = 'https://www.google.com/maps/search/?api=1&query=' . urlencode(ENTIDADE_ENDERECO);

$titulo = 'Sobre a entidade';
require 'includes/cabecalho.php';
?>

<section class="hero hero-pequeno">
    <div class="container">
        <span class="hero-tag"><i class="bi bi-info-circle-fill"></i> Sobre a entidade</span>
        <h1 class="hero-titulo"><?= e(ENTIDADE_NOME) ?></h1>
        <p class="hero-texto mb-0">Cuidando de quem cuidou da gente, com a ajuda de toda a comunidade.</p>
    </div>
</section>

<div class="container py-5">
    <div class="row g-4">
        <div class="col-lg-7">
            <h2 class="titulo-secao">Quem somos</h2>
            <p>
                Somos uma instituição sem fins lucrativos que acolhe idosos da região do Alto Vale do Itajaí.
                Oferecemos moradia, alimentação, cuidados de higiene e muito carinho. Nos mantemos com a ajuda
                da comunidade, e cada doação faz diferença no nosso dia a dia.
            </p>

            <div class="row g-3 my-3">
                <div class="col-6">
                    <div class="card-numero">
                        <div class="numero" data-contador="<?= $totalDoacoes ?>">0</div>
                        <div>doações recebidas pelo mural</div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="card-numero">
                        <div class="numero" data-contador="<?= $totalItens ?>">0</div>
                        <div>itens arrecadados</div>
                    </div>
                </div>
            </div>

            <h2 class="titulo-secao mt-4">Por que o Mural Solidário?</h2>
            <p>
                Antes, os pedidos de ajuda eram feitos em grupos de WhatsApp e redes sociais. Muita gente doava
                o que tinha sobrando em casa, e não o que realmente faltava. Com o mural, todo mundo vê na hora
                o que precisamos e quanto já foi arrecadado.
            </p>
            <p class="text-muted small">
                <i class="bi bi-mortarboard-fill"></i>
                Este sistema foi desenvolvido por acadêmicos do curso de Sistemas de Informação da UNIDAVI
                como projeto de extensão da disciplina de Programação Web I (programa Universidade Solidária).
            </p>
            <a href="index.php#itens" class="btn btn-verde btn-lg mt-2"><i class="bi bi-heart-fill me-1"></i> Ver o que precisamos</a>
        </div>

        <div class="col-lg-5">
            <div class="card card-form">
                <div class="card-body p-4">
                    <h3 class="h5 fw-bold mb-3"><i class="bi bi-box-seam-fill text-success me-1"></i> Onde entregar</h3>
                    <ul class="list-unstyled lista-resumo">
                        <li>
                            <i class="bi bi-geo-alt-fill"></i>
                            <span id="endereco"><?= e(ENTIDADE_ENDERECO) ?></span>
                            <button type="button" class="btn btn-sm btn-link p-0 ms-1" data-copiar="endereco"><i class="bi bi-copy"></i> copiar</button>
                        </li>
                        <li><i class="bi bi-clock-fill"></i> <?= e(ENTIDADE_HORARIO) ?></li>
                        <li><i class="bi bi-telephone-fill"></i> <?= e(ENTIDADE_TELEFONE) ?></li>
                    </ul>
                    <!-- Mapa do Google (não precisa de chave de API) -->
                    <div class="mapa">
                        <iframe src="https://maps.google.com/maps?q=<?= urlencode(ENTIDADE_ENDERECO) ?>&z=16&output=embed"
                                loading="lazy" title="Mapa com o endereço da entidade"></iframe>
                    </div>
                    <a href="<?= e($linkMapa) ?>" target="_blank" class="btn btn-outline-success w-100 mt-3">
                        <i class="bi bi-signpost-split-fill me-1"></i> Como chegar
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require 'includes/rodape.php'; ?>
