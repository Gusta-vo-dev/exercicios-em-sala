<?php
require '../config/conexao.php';
require '../includes/funcoes.php';
exigirLogin();

// Se veio um id na URL, é edição. Se não, é cadastro novo.
$id = isset($_GET['id']) ? (int) $_GET['id'] : 0;

// Valores padrão do formulário
$necessidade = [
    'titulo' => '',
    'descricao' => '',
    'categoria_id' => '',
    'unidade' => '',
    'meta' => '',
    'urgente' => 0,
    'imagem' => null,
];

if ($id > 0) {
    $stmt = $pdo->prepare('SELECT * FROM necessidades WHERE id = ?');
    $stmt->execute([$id]);
    $necessidade = $stmt->fetch();

    if (!$necessidade) {
        mensagem('Necessidade não encontrada.', 'warning');
        header('Location: necessidades.php');
        exit;
    }
}

$categorias = $pdo->query('SELECT * FROM categorias ORDER BY nome')->fetchAll();
$erros = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Pega os dados digitados
    $necessidade['titulo'] = trim($_POST['titulo'] ?? '');
    $necessidade['descricao'] = trim($_POST['descricao'] ?? '');
    $necessidade['categoria_id'] = (int) ($_POST['categoria_id'] ?? 0);
    $necessidade['unidade'] = trim($_POST['unidade'] ?? '');
    $necessidade['meta'] = (int) ($_POST['meta'] ?? 0);
    $necessidade['urgente'] = isset($_POST['urgente']) ? 1 : 0;

    // Validações
    if ($necessidade['titulo'] === '') {
        $erros[] = 'Informe o nome do item.';
    }
    if ($necessidade['categoria_id'] <= 0) {
        $erros[] = 'Escolha uma categoria.';
    }
    if ($necessidade['unidade'] === '') {
        $erros[] = 'Informe a unidade (pacotes, kg, litros...).';
    }
    if ($necessidade['meta'] <= 0) {
        $erros[] = 'A meta precisa ser maior que zero.';
    }

    // Só tenta salvar a imagem se o resto do formulário estiver certo
    $novaImagem = null;
    if (count($erros) === 0) {
        $novaImagem = salvarImagem($_FILES['imagem'] ?? null, $erros);
    }

    if (count($erros) === 0) {
        $imagemAntiga = $necessidade['imagem'];

        if ($novaImagem) {
            // Enviou foto nova: troca e apaga a antiga da pasta
            $necessidade['imagem'] = $novaImagem;
            apagarImagem($imagemAntiga);
        } elseif (!empty($_POST['remover_imagem'])) {
            // Marcou "remover foto"
            $necessidade['imagem'] = null;
            apagarImagem($imagemAntiga);
        }

        $dados = [
            $necessidade['titulo'],
            $necessidade['descricao'],
            $necessidade['categoria_id'],
            $necessidade['unidade'],
            $necessidade['meta'],
            $necessidade['urgente'],
            $necessidade['imagem'],
        ];

        if ($id > 0) {
            $dados[] = $id;
            $sql = 'UPDATE necessidades SET titulo = ?, descricao = ?, categoria_id = ?, unidade = ?, meta = ?, urgente = ?, imagem = ?
                    WHERE id = ?';
            $pdo->prepare($sql)->execute($dados);
            mensagem('Necessidade atualizada.');
        } else {
            $sql = 'INSERT INTO necessidades (titulo, descricao, categoria_id, unidade, meta, urgente, imagem)
                    VALUES (?, ?, ?, ?, ?, ?, ?)';
            $pdo->prepare($sql)->execute($dados);
            mensagem('Necessidade cadastrada! Ela já aparece no mural.');
        }

        header('Location: necessidades.php');
        exit;
    }
}

$titulo = $id > 0 ? 'Editar necessidade' : 'Nova necessidade';
$base = '../';
require '../includes/cabecalho.php';
?>

<div class="row justify-content-center">
    <div class="col-lg-9">
        <a href="necessidades.php" class="link-voltar"><i class="bi bi-arrow-left"></i> Voltar para a lista</a>
        <h1 class="h3 my-3">
            <i class="bi <?= $id > 0 ? 'bi-pencil-square' : 'bi-plus-circle-fill' ?> text-success"></i> <?= e($titulo) ?>
        </h1>

        <?php if (count($erros) > 0): ?>
            <div class="alert alert-danger">
                <ul class="mb-0">
                    <?php foreach ($erros as $erro): ?>
                        <li><?= e($erro) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <!-- enctype multipart é obrigatório para enviar arquivos -->
        <form method="post" enctype="multipart/form-data" class="card card-painel card-body p-4">
            <div class="mb-3">
                <label class="form-label">Item</label>
                <input type="text" name="titulo" class="form-control" maxlength="100"
                       placeholder="Ex.: Fralda geriátrica tamanho G" value="<?= e($necessidade['titulo']) ?>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Descrição (opcional)</label>
                <textarea name="descricao" class="form-control" rows="3"><?= e($necessidade['descricao']) ?></textarea>
            </div>
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label class="form-label">Categoria</label>
                    <select name="categoria_id" class="form-select" required>
                        <option value="">Selecione...</option>
                        <?php foreach ($categorias as $c): ?>
                            <option value="<?= $c['id'] ?>" <?= (int) $necessidade['categoria_id'] === (int) $c['id'] ? 'selected' : '' ?>>
                                <?= e($c['nome']) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">Unidade</label>
                    <input type="text" name="unidade" class="form-control" maxlength="30"
                           placeholder="pacotes, kg, litros..." value="<?= e($necessidade['unidade']) ?>" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">Meta (quantidade)</label>
                    <input type="number" name="meta" min="1" class="form-control" value="<?= e($necessidade['meta']) ?>" required>
                </div>
            </div>
            <div class="form-check form-switch mb-3">
                <input type="checkbox" name="urgente" value="1" id="urgente" class="form-check-input"
                       <?= $necessidade['urgente'] ? 'checked' : '' ?>>
                <label for="urgente" class="form-check-label">
                    <i class="bi bi-lightning-fill text-danger"></i> <strong>Urgente</strong>
                    <span class="text-muted">(aparece primeiro no mural, com destaque)</span>
                </label>
            </div>
            <div class="mb-3">
                <label class="form-label">Foto do item (opcional - JPG, PNG ou WEBP até 2 MB)</label>
                <input type="file" name="imagem" id="campo-foto" class="form-control" accept="image/jpeg,image/png,image/webp">
                <div class="mt-2 d-flex align-items-center gap-3">
                    <!-- Prévia da foto nova (o JavaScript mostra quando um arquivo é escolhido) -->
                    <img id="previa-foto" src="" alt="Prévia da nova foto" class="img-thumbnail d-none" style="max-height: 110px">
                    <?php if (!empty($necessidade['imagem'])): ?>
                        <img src="../<?= e($necessidade['imagem']) ?>" alt="Foto atual" class="img-thumbnail" style="max-height: 110px">
                        <div class="form-check">
                            <input type="checkbox" name="remover_imagem" value="1" id="remover" class="form-check-input">
                            <label for="remover" class="form-check-label">Remover foto atual</label>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-verde"><i class="bi bi-check-lg"></i> Salvar</button>
                <a href="necessidades.php" class="btn btn-outline-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</div>

<?php require '../includes/rodape.php'; ?>
