<?php
require 'config/conexao.php';
require 'includes/funcoes.php';

// Esta página só faz sentido logo depois de uma doação
if (!isset($_SESSION['ultima_doacao'])) {
    header('Location: index.php');
    exit;
}
$doacao = $_SESSION['ultima_doacao'];

// Link do Google Maps com o endereço da entidade
$linkMapa = 'https://www.google.com/maps/search/?api=1&query=' . urlencode(ENTIDADE_ENDERECO);

// Endereço do site, para compartilhar no WhatsApp
$protocolo = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$enderecoSite = $protocolo . '://' . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . '/index.php';
$textoWhatsapp = 'Acabei de doar ' . $doacao['quantidade'] . ' ' . $doacao['unidade'] . ' de "' . $doacao['item'] . '" para o '
    . ENTIDADE_NOME . '! Veja o que eles ainda precisam e ajude também: ' . $enderecoSite;
$linkWhatsapp = 'https://wa.me/?text=' . urlencode($textoWhatsapp);

$titulo = 'Obrigado!';
require 'includes/cabecalho.php';
?>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7 text-center">
            <div class="icone-sucesso"><i class="bi bi-check-lg"></i></div>
            <h1 class="fw-bold mt-3">Obrigado, <?= e($doacao['nome']) ?>!</h1>
            <p class="lead text-muted">Sua doação foi registrada. Agora é só levar até a entidade no dia combinado.</p>

            <div class="card card-form text-start mt-4">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <?php if (!empty($doacao['imagem'])): ?>
                            <img src="<?= e($doacao['imagem']) ?>" alt="" class="miniatura">
                        <?php endif; ?>
                        <div>
                            <div class="text-muted small">Você vai doar</div>
                            <div class="h5 fw-bold mb-0"><?= $doacao['quantidade'] ?> <?= e($doacao['unidade']) ?> de <?= e($doacao['item']) ?></div>
                        </div>
                    </div>

                    <ul class="list-unstyled lista-resumo mb-0">
                        <li><i class="bi bi-calendar-event"></i> <strong>Data da entrega:</strong> <?= dataBR($doacao['data']) ?></li>
                        <li><i class="bi bi-clock-fill"></i> <strong>Horário:</strong> <?= e(ENTIDADE_HORARIO) ?></li>
                        <li>
                            <i class="bi bi-geo-alt-fill"></i> <strong>Endereço:</strong>
                            <span id="endereco"><?= e(ENTIDADE_ENDERECO) ?></span>
                            <button type="button" class="btn btn-sm btn-link p-0 ms-1" data-copiar="endereco">
                                <i class="bi bi-copy"></i> copiar
                            </button>
                        </li>
                    </ul>

                    <div class="d-flex flex-wrap gap-2 mt-4">
                        <a href="<?= e($linkMapa) ?>" target="_blank" class="btn btn-outline-success">
                            <i class="bi bi-map-fill me-1"></i> Ver no mapa
                        </a>
                        <a href="<?= e($linkWhatsapp) ?>" target="_blank" class="btn btn-whatsapp">
                            <i class="bi bi-whatsapp me-1"></i> Compartilhar no WhatsApp
                        </a>
                    </div>
                </div>
            </div>

            <a href="index.php#itens" class="btn btn-verde btn-lg mt-4">
                <i class="bi bi-heart-fill me-1"></i> Doar outro item
            </a>
        </div>
    </div>
</div>

<?php require 'includes/rodape.php'; ?>
