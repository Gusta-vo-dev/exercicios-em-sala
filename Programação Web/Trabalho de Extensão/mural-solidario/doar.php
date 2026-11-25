<?php
require 'config/conexao.php';
require 'includes/funcoes.php';

// Busca a necessidade pelo id da URL, junto com a categoria e os totais
$id = isset($_GET['id']) ? (int) $_GET['id'] : 0;
$sql = "SELECT n.*, c.nome AS categoria, c.icone, c.cor,
               COALESCE(SUM(CASE WHEN d.status = 'recebida'  THEN d.quantidade END), 0) AS recebido,
               COALESCE(SUM(CASE WHEN d.status = 'prometida' THEN d.quantidade END), 0) AS prometido
        FROM necessidades n
        INNER JOIN categorias c ON c.id = n.categoria_id
        LEFT JOIN doacoes d ON d.necessidade_id = n.id
        WHERE n.id = ? AND n.status = 'aberta'
        GROUP BY n.id";
$stmt = $pdo->prepare($sql);
$stmt->execute([$id]);
$necessidade = $stmt->fetch();

// Se não achou (ou está encerrada), volta para a página inicial
if (!$necessidade) {
    mensagem('Essa necessidade não existe ou já foi encerrada.', 'warning');
    header('Location: index.php');
    exit;
}

$falta = max(0, $necessidade['meta'] - $necessidade['recebido'] - $necessidade['prometido']);
$pctRecebido = porcentagem($necessidade['recebido'], $necessidade['meta']);
$pctPrometido = min(porcentagem($necessidade['prometido'], $necessidade['meta']), 100 - $pctRecebido);

$erros = [];
// Valores dos campos (para não perder o que a pessoa digitou se der erro)
$nome = '';
$telefone = '';
$quantidade = 1;
$dataPrevista = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nome = trim($_POST['nome'] ?? '');
    $telefone = trim($_POST['telefone'] ?? '');
    $quantidade = (int) ($_POST['quantidade'] ?? 0);
    $dataPrevista = $_POST['data_prevista'] ?? '';

    // Validações
    if (strlen($nome) < 3) {
        $erros[] = 'Informe seu nome (mínimo 3 letras).';
    }
    // Telefone: valida só os números (ignora parênteses, espaço e traço da máscara)
    // Precisa ter exatamente 11 dígitos: DDD (2) + celular (9)
    $telefoneNumeros = preg_replace('/\D/', '', $telefone);
    if (strlen($telefoneNumeros) !== 11) {
        $erros[] = 'O telefone deve ter o DDD + 9 números (ex.: 47996785392).';
    }
    if ($quantidade <= 0) {
        $erros[] = 'A quantidade precisa ser maior que zero.';
    }
    if (empty($dataPrevista) || $dataPrevista < date('Y-m-d')) {
        $erros[] = 'Escolha uma data de entrega a partir de hoje.';
    }

    // Se não teve erro, salva a doação como "prometida"
    if (count($erros) === 0) {
        $sql = 'INSERT INTO doacoes (necessidade_id, nome_doador, telefone, quantidade, data_prevista)
                VALUES (?, ?, ?, ?, ?)';
        // Salva no banco já no formato (47) 99678-5392
        $pdo->prepare($sql)->execute([$id, $nome, formatarTelefone($telefoneNumeros), $quantidade, $dataPrevista]);

        // Guarda o resumo na sessão para mostrar na página de agradecimento
        $_SESSION['ultima_doacao'] = [
            'nome'       => $nome,
            'item'       => $necessidade['titulo'],
            'imagem'     => $necessidade['imagem'],
            'quantidade' => $quantidade,
            'unidade'    => $necessidade['unidade'],
            'data'       => $dataPrevista,
        ];
        header('Location: obrigado.php');
        exit;
    }
}

$titulo = 'Quero doar';
require 'includes/cabecalho.php';
?>

<div class="container py-4">
    <a href="index.php#itens" class="link-voltar"><i class="bi bi-arrow-left"></i> Voltar para a lista</a>

    <div class="row g-4 mt-1">
        <!-- Resumo do item escolhido -->
        <div class="col-lg-5">
            <div class="card card-item resumo-item" style="--cor: <?= e($necessidade['cor']) ?>">
                <div class="card-item-imagem">
                    <?php if (!empty($necessidade['imagem'])): ?>
                        <img src="<?= e($necessidade['imagem']) ?>" alt="<?= e($necessidade['titulo']) ?>">
                    <?php else: ?>
                        <div class="sem-imagem"><i class="bi bi-<?= e($necessidade['icone']) ?>"></i></div>
                    <?php endif; ?>
                    <?php if ($necessidade['urgente']): ?>
                        <div class="selos"><span class="selo selo-urgente"><i class="bi bi-lightning-fill"></i> Urgente</span></div>
                    <?php endif; ?>
                </div>
                <div class="card-body">
                    <span class="categoria-item"><i class="bi bi-<?= e($necessidade['icone']) ?>"></i> <?= e($necessidade['categoria']) ?></span>
                    <h1 class="h4 mt-1"><?= e($necessidade['titulo']) ?></h1>
                    <p class="text-muted"><?= e($necessidade['descricao']) ?></p>

                    <div class="progress-stacked mb-2">
                        <div class="progress" style="width: <?= $pctRecebido ?>%"><div class="progress-bar"></div></div>
                        <div class="progress" style="width: <?= $pctPrometido ?>%"><div class="progress-bar barra-prometido"></div></div>
                    </div>
                    <div class="row text-center g-2 mini-numeros">
                        <div class="col-4"><strong><?= $necessidade['recebido'] ?></strong><span>recebidos</span></div>
                        <div class="col-4"><strong><?= $necessidade['prometido'] ?></strong><span>prometidos</span></div>
                        <div class="col-4"><strong><?= $necessidade['meta'] ?></strong><span>meta</span></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Formulário -->
        <div class="col-lg-7">
            <div class="card card-form">
                <div class="card-body p-4">
                    <h2 class="h4 fw-bold mb-1">Registrar minha doação</h2>
                    <p class="text-muted mb-4">
                        <?php if ($falta > 0): ?>
                            Ainda faltam <strong><?= $falta ?> <?= e($necessidade['unidade']) ?></strong> para completar a meta.
                        <?php else: ?>
                            A meta já foi toda prometida, mas doações extras são muito bem-vindas!
                        <?php endif; ?>
                    </p>

                    <?php if (count($erros) > 0): ?>
                        <div class="alert alert-danger">
                            <ul class="mb-0">
                                <?php foreach ($erros as $erro): ?>
                                    <li><?= e($erro) ?></li>
                                <?php endforeach; ?>
                            </ul>
                        </div>
                    <?php endif; ?>

                    <form method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Seu nome</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                                    <input type="text" name="nome" class="form-control" value="<?= e($nome) ?>" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Telefone / WhatsApp</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-whatsapp"></i></span>
                                    <input type="text" name="telefone" id="telefone" class="form-control" inputmode="numeric"
                                           placeholder="47996785392" value="<?= e($telefone) ?>" required>
                                </div>
                                <div class="form-text">Digite só os números, com DDD.</div>
                            </div>

                            <div class="col-12">
                                <label class="form-label">Quantidade (<?= e($necessidade['unidade']) ?>)</label>
                                <div class="d-flex flex-wrap align-items-center gap-2">
                                    <!-- Botões de - e + para a quantidade -->
                                    <div class="input-group seletor-qtd">
                                        <button type="button" class="btn btn-outline-secondary" data-passo="-1"><i class="bi bi-dash-lg"></i></button>
                                        <input type="number" name="quantidade" id="quantidade" min="1" class="form-control text-center" value="<?= e($quantidade) ?>" required>
                                        <button type="button" class="btn btn-outline-secondary" data-passo="1"><i class="bi bi-plus-lg"></i></button>
                                    </div>
                                    <!-- Atalhos de quantidade -->
                                    <?php foreach ([1, 5, 10] as $q): ?>
                                        <button type="button" class="btn btn-sm btn-atalho" data-qtd="<?= $q ?>"><?= $q ?></button>
                                    <?php endforeach; ?>
                                    <?php if ($falta > 0): ?>
                                        <button type="button" class="btn btn-sm btn-atalho" data-qtd="<?= $falta ?>">
                                            Tudo que falta (<?= $falta ?>)
                                        </button>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <div class="col-12">
                                <label class="form-label">Quando vai entregar?</label>
                                <div class="d-flex flex-wrap align-items-center gap-2">
                                    <input type="date" name="data_prevista" id="data_prevista" min="<?= date('Y-m-d') ?>"
                                           class="form-control campo-data" value="<?= e($dataPrevista) ?>" required>
                                    <!-- Atalhos de data (o JavaScript calcula a data) -->
                                    <button type="button" class="btn btn-sm btn-atalho" data-dias="0">Hoje</button>
                                    <button type="button" class="btn btn-sm btn-atalho" data-dias="1">Amanhã</button>
                                    <button type="button" class="btn btn-sm btn-atalho" data-dias="7">Daqui 1 semana</button>
                                </div>
                            </div>
                        </div>

                        <div class="info-entrega mt-4">
                            <i class="bi bi-geo-alt-fill"></i>
                            <div>
                                <strong>Entrega em:</strong> <?= e(ENTIDADE_ENDERECO) ?><br>
                                <span class="text-muted small"><?= e(ENTIDADE_HORARIO) ?></span>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-verde btn-lg w-100 mt-4">
                            <i class="bi bi-check-circle-fill me-1"></i> Confirmar doação
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require 'includes/rodape.php'; ?>
