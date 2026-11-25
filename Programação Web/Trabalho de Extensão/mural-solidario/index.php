<?php
require 'config/conexao.php';
require 'includes/funcoes.php';

// Busca as necessidades abertas junto com a categoria e:
//  - o total já recebido (só doações com status "recebida")
//  - o total prometido (doações que ainda não chegaram)
// Urgentes aparecem primeiro.
$sql = "SELECT n.*, c.nome AS categoria, c.icone, c.cor,
               COALESCE(SUM(CASE WHEN d.status = 'recebida'  THEN d.quantidade END), 0) AS recebido,
               COALESCE(SUM(CASE WHEN d.status = 'prometida' THEN d.quantidade END), 0) AS prometido
        FROM necessidades n
        INNER JOIN categorias c ON c.id = n.categoria_id
        LEFT JOIN doacoes d ON d.necessidade_id = n.id
        WHERE n.status = 'aberta'
        GROUP BY n.id
        ORDER BY n.urgente DESC, n.id";
$necessidades = $pdo->query($sql)->fetchAll();

// Categorias para os botões de filtro, com a quantidade de itens abertos em cada uma
$sql = "SELECT c.*, COUNT(n.id) AS total
        FROM categorias c
        LEFT JOIN necessidades n ON n.categoria_id = c.id AND n.status = 'aberta'
        GROUP BY c.id
        HAVING total > 0
        ORDER BY c.nome";
$categorias = $pdo->query($sql)->fetchAll();

// Números que aparecem no topo da página
$totalItensRecebidos = $pdo->query("SELECT COALESCE(SUM(quantidade), 0) FROM doacoes WHERE status = 'recebida'")->fetchColumn();
$totalDoadores = $pdo->query("SELECT COUNT(DISTINCT telefone) FROM doacoes WHERE status <> 'cancelada'")->fetchColumn();
$totalUrgentes = 0;
foreach ($necessidades as $n) {
    if ($n['urgente']) {
        $totalUrgentes++;
    }
}

$titulo = 'Necessidades';
require 'includes/cabecalho.php';
?>

<!-- ===================== TOPO ===================== -->
<section class="hero">
    <div class="container">
        <div class="row align-items-center g-4">
            <div class="col-lg-7">
                <span class="hero-tag"><i class="bi bi-geo-alt-fill"></i> <?= e(ENTIDADE_NOME) ?> &middot; Rio do Sul</span>
                <h1 class="hero-titulo">Doe o que <span>realmente</span> faz falta.</h1>
                <p class="hero-texto">
                    Aqui você vê exatamente o que a entidade está precisando e quanto já foi arrecadado.
                    Escolha um item, diga quanto pode doar e leve até lá. Simples assim!
                </p>
                <div class="d-flex flex-wrap gap-2 mb-4">
                    <a href="#itens" class="btn btn-light btn-lg fw-bold text-success">
                        <i class="bi bi-heart-fill me-1"></i> Quero ajudar
                    </a>
                    <a href="#como-funciona" class="btn btn-outline-light btn-lg">Como funciona?</a>
                </div>

                <div class="row g-3 numeros-topo">
                    <div class="col-4">
                        <div class="numero" data-contador="<?= count($necessidades) ?>">0</div>
                        <div class="legenda-numero">itens precisando</div>
                    </div>
                    <div class="col-4">
                        <div class="numero" data-contador="<?= $totalItensRecebidos ?>">0</div>
                        <div class="legenda-numero">itens já recebidos</div>
                    </div>
                    <div class="col-4">
                        <div class="numero" data-contador="<?= $totalDoadores ?>">0</div>
                        <div class="legenda-numero">pessoas ajudando</div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5 text-center d-none d-lg-block">
                <img src="img/hero.svg" alt="Caixa de doações com alimentos e produtos de higiene" class="img-fluid hero-imagem">
            </div>
        </div>
    </div>
</section>

<!-- ===================== COMO FUNCIONA ===================== -->
<section id="como-funciona" class="container py-5">
    <h2 class="titulo-secao text-center">Como funciona</h2>
    <p class="text-center text-muted mb-4">Em três passos você ajuda quem precisa</p>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="passo">
                <div class="passo-icone"><i class="bi bi-search-heart"></i></div>
                <span class="passo-numero">1</span>
                <h5>Escolha um item</h5>
                <p>Veja a lista abaixo. Os itens marcados como <strong>urgentes</strong> são os que mais estão faltando.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="passo">
                <div class="passo-icone"><i class="bi bi-pencil-square"></i></div>
                <span class="passo-numero">2</span>
                <h5>Registre sua doação</h5>
                <p>Informe a quantidade e o dia que vai entregar. Leva menos de um minuto.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="passo">
                <div class="passo-icone"><i class="bi bi-truck"></i></div>
                <span class="passo-numero">3</span>
                <h5>Leve até a entidade</h5>
                <p>Quando sua doação chegar, a entidade confirma e a barra do item avança.</p>
            </div>
        </div>
    </div>
</section>

<!-- ===================== LISTA DE ITENS ===================== -->
<section id="itens" class="container pb-4">
    <div class="d-flex flex-wrap justify-content-between align-items-end gap-2 mb-3">
        <div>
            <h2 class="titulo-secao mb-1">Do que estamos precisando</h2>
            <p class="text-muted mb-0">
                <?php if ($totalUrgentes > 0): ?>
                    <i class="bi bi-lightning-fill text-danger"></i> <?= $totalUrgentes ?> itens urgentes no momento
                <?php endif; ?>
            </p>
        </div>
        <span class="text-muted small" id="contador-itens"></span>
    </div>

    <!-- Barra de busca, filtros e ordenação (funcionam com JavaScript, sem recarregar a página) -->
    <div class="barra-filtros">
        <div class="row g-2 align-items-center">
            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                    <input type="text" id="busca" class="form-control" placeholder="Buscar item (ex.: fralda, leite...)">
                </div>
            </div>
            <div class="col-6 col-md-4">
                <select id="ordem" class="form-select">
                    <option value="urgentes">Urgentes primeiro</option>
                    <option value="falta">Mais longe da meta</option>
                    <option value="quase">Mais perto da meta</option>
                    <option value="az">Ordem alfabética</option>
                </select>
            </div>
            <div class="col-6 col-md-3">
                <div class="form-check form-switch mb-0">
                    <input class="form-check-input" type="checkbox" id="so-urgentes">
                    <label class="form-check-label" for="so-urgentes">Só urgentes</label>
                </div>
            </div>
        </div>

        <div class="filtro-categorias mt-3">
            <button type="button" class="chip-categoria ativo" data-categoria="todas" style="--cor: #2e7d5b">
                <i class="bi bi-grid-fill"></i> Todas <span class="qtd"><?= count($necessidades) ?></span>
            </button>
            <?php foreach ($categorias as $c): ?>
                <button type="button" class="chip-categoria" data-categoria="<?= $c['id'] ?>" style="--cor: <?= e($c['cor']) ?>">
                    <i class="bi bi-<?= e($c['icone']) ?>"></i> <?= e($c['nome']) ?> <span class="qtd"><?= $c['total'] ?></span>
                </button>
            <?php endforeach; ?>
        </div>
    </div>

    <!-- Legenda das cores da barra -->
    <p class="small text-muted my-3">
        <span class="legenda legenda-recebido"></span> Recebido pela entidade
        <span class="legenda legenda-prometido ms-3"></span> Prometido (aguardando entrega)
    </p>

    <div class="row g-4" id="lista-itens">
        <?php foreach ($necessidades as $i => $n): ?>
            <?php
            // Parte escura da barra: o que a entidade já confirmou que recebeu
            $pctRecebido = porcentagem($n['recebido'], $n['meta']);
            // Parte clara: o que foi prometido e ainda não chegou (a barra nunca passa de 100%)
            $pctPrometido = min(porcentagem($n['prometido'], $n['meta']), 100 - $pctRecebido);
            // Quanto ainda falta, contando o que já foi prometido
            $falta = max(0, $n['meta'] - $n['recebido'] - $n['prometido']);

            $metaAtingida = $n['recebido'] >= $n['meta'];
            $quaseLa = !$metaAtingida && ($pctRecebido + $pctPrometido) >= 75;
            ?>
            <div class="col-sm-6 col-lg-4 col-xl-3 item-card"
                 data-categoria="<?= $n['categoria_id'] ?>"
                 data-titulo="<?= e(mb_strtolower($n['titulo'] . ' ' . $n['categoria'])) ?>"
                 data-urgente="<?= $n['urgente'] ?>"
                 data-progresso="<?= $pctRecebido + $pctPrometido ?>"
                 data-ordem="<?= $i ?>">
                <div class="card card-item h-100 <?= $metaAtingida ? 'atingida' : '' ?>" style="--cor: <?= e($n['cor']) ?>">
                    <div class="card-item-imagem">
                        <?php if (!empty($n['imagem'])): ?>
                            <img src="<?= e($n['imagem']) ?>" alt="<?= e($n['titulo']) ?>" loading="lazy">
                        <?php else: ?>
                            <div class="sem-imagem"><i class="bi bi-<?= e($n['icone']) ?>"></i></div>
                        <?php endif; ?>

                        <div class="selos">
                            <?php if ($metaAtingida): ?>
                                <span class="selo selo-ok"><i class="bi bi-check-circle-fill"></i> Meta atingida</span>
                            <?php elseif ($n['urgente']): ?>
                                <span class="selo selo-urgente"><i class="bi bi-lightning-fill"></i> Urgente</span>
                            <?php endif; ?>
                            <?php if ($quaseLa): ?>
                                <span class="selo selo-quase"><i class="bi bi-stars"></i> Quase lá!</span>
                            <?php endif; ?>
                        </div>
                    </div>

                    <div class="card-body d-flex flex-column">
                        <span class="categoria-item"><i class="bi bi-<?= e($n['icone']) ?>"></i> <?= e($n['categoria']) ?></span>
                        <h5 class="card-title mt-1"><?= e($n['titulo']) ?></h5>
                        <p class="card-text text-muted small"><?= e($n['descricao']) ?></p>

                        <div class="mt-auto">
                            <!-- Barra com duas partes (Bootstrap "progress-stacked") -->
                            <div class="progress-stacked mb-2">
                                <div class="progress" style="width: <?= $pctRecebido ?>%" title="Recebido">
                                    <div class="progress-bar"></div>
                                </div>
                                <div class="progress" style="width: <?= $pctPrometido ?>%" title="Prometido">
                                    <div class="progress-bar barra-prometido"></div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between small mb-1">
                                <span>Recebido: <strong><?= $n['recebido'] ?></strong> de <?= $n['meta'] ?> <?= e($n['unidade']) ?></span>
                                <strong><?= $pctRecebido ?>%</strong>
                            </div>
                            <?php if ($n['prometido'] > 0): ?>
                                <p class="small texto-prometido mb-1">
                                    <i class="bi bi-truck"></i> + <?= $n['prometido'] ?> prometidos, aguardando entrega
                                </p>
                            <?php endif; ?>

                            <?php if ($metaAtingida): ?>
                                <p class="small text-success fw-bold mb-2">Obrigado a todos que ajudaram!</p>
                                <button class="btn btn-secondary w-100" disabled>Meta atingida</button>
                            <?php else: ?>
                                <p class="small falta mb-2">
                                    <?php if ($falta > 0): ?>
                                        Ainda faltam <strong><?= $falta ?> <?= e($n['unidade']) ?></strong>
                                    <?php else: ?>
                                        Tudo prometido! Mas doações extras são bem-vindas.
                                    <?php endif; ?>
                                </p>
                                <a href="doar.php?id=<?= $n['id'] ?>" class="btn btn-verde w-100">
                                    <i class="bi bi-heart-fill me-1"></i> Quero doar
                                </a>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>

    <!-- Aparece quando a busca/filtro não encontra nada -->
    <div id="nada-encontrado" class="text-center py-5 d-none">
        <i class="bi bi-emoji-frown display-4 text-muted"></i>
        <p class="mt-2 mb-1 fw-bold">Nenhum item encontrado</p>
        <p class="text-muted small">Tente buscar outro nome ou escolha outra categoria.</p>
    </div>

    <?php if (count($necessidades) === 0): ?>
        <div class="alert alert-info">No momento a entidade não está precisando de nada. Volte em breve!</div>
    <?php endif; ?>
</section>

<!-- ===================== CHAMADA FINAL ===================== -->
<section class="container">
    <div class="chamada-final">
        <div>
            <h4 class="fw-bold mb-1">Quer ajudar de outro jeito?</h4>
            <p class="mb-0">Doações de itens fora da lista e visitas voluntárias também são bem-vindas. Fale com a gente!</p>
        </div>
        <a href="sobre.php" class="btn btn-light fw-bold text-success"><i class="bi bi-telephone-fill me-1"></i> Entrar em contato</a>
    </div>
</section>

<?php require 'includes/rodape.php'; ?>
