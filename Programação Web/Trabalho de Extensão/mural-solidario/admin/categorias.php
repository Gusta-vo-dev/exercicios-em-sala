<?php
require '../config/conexao.php';
require '../includes/funcoes.php';
exigirLogin();

$icones = iconesDisponiveis();

// Tudo que altera dados vem por POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $acao = $_POST['acao'] ?? '';
    $id = (int) ($_POST['id'] ?? 0);
    $nome = trim($_POST['nome'] ?? '');
    $icone = $_POST['icone'] ?? 'box-seam-fill';
    $cor = $_POST['cor'] ?? '#2e7d5b';

    // Só aceita ícones da lista e cores no formato #000000
    if (!isset($icones[$icone])) {
        $icone = 'box-seam-fill';
    }
    if (!preg_match('/^#[0-9a-fA-F]{6}$/', $cor)) {
        $cor = '#2e7d5b';
    }

    if ($acao === 'salvar') {
        if ($nome === '') {
            mensagem('Informe o nome da categoria.', 'danger');
        } elseif ($id > 0) {
            $pdo->prepare('UPDATE categorias SET nome = ?, icone = ?, cor = ? WHERE id = ?')->execute([$nome, $icone, $cor, $id]);
            mensagem('Categoria "' . $nome . '" atualizada.');
        } else {
            $pdo->prepare('INSERT INTO categorias (nome, icone, cor) VALUES (?, ?, ?)')->execute([$nome, $icone, $cor]);
            mensagem('Categoria "' . $nome . '" cadastrada.');
        }
    } elseif ($acao === 'excluir') {
        // Não deixa excluir categoria que já tem necessidade ligada a ela
        $stmt = $pdo->prepare('SELECT COUNT(*) FROM necessidades WHERE categoria_id = ?');
        $stmt->execute([$id]);
        if ($stmt->fetchColumn() > 0) {
            mensagem('Não é possível excluir: existem necessidades nesta categoria.', 'danger');
        } else {
            $pdo->prepare('DELETE FROM categorias WHERE id = ?')->execute([$id]);
            mensagem('Categoria excluída.');
        }
    }

    header('Location: categorias.php');
    exit;
}

// Se clicou em "Editar", carrega a categoria no formulário
$editando = ['id' => 0, 'nome' => '', 'icone' => 'box-seam-fill', 'cor' => '#2e7d5b'];
if (isset($_GET['editar'])) {
    $stmt = $pdo->prepare('SELECT * FROM categorias WHERE id = ?');
    $stmt->execute([(int) $_GET['editar']]);
    $categoria = $stmt->fetch();

    if ($categoria) {
        $editando = $categoria;
    } else {
        mensagem('Categoria não encontrada.', 'warning');
        header('Location: categorias.php');
        exit;
    }
}
$estaEditando = $editando['id'] > 0;

// Lista as categorias com a quantidade de necessidades em cada uma
$sql = 'SELECT c.*, COUNT(n.id) AS total
        FROM categorias c
        LEFT JOIN necessidades n ON n.categoria_id = c.id
        GROUP BY c.id
        ORDER BY c.nome';
$categorias = $pdo->query($sql)->fetchAll();

$titulo = 'Categorias';
$base = '../';
require '../includes/cabecalho.php';
?>

<h1 class="h3 mb-3"><i class="bi bi-tags-fill text-success"></i> Categorias</h1>

<div class="row g-4">
    <div class="col-lg-5">
        <form method="post" class="card card-painel <?= $estaEditando ? 'form-editando' : '' ?>">
            <div class="card-body p-4">
                <?php if ($estaEditando): ?>
                    <span class="badge bg-warning text-dark mb-2"><i class="bi bi-pencil-fill"></i> Modo de edição</span>
                    <h2 class="h5 fw-bold">Editando "<?= e($editando['nome']) ?>"</h2>
                <?php else: ?>
                    <h2 class="h5 fw-bold"><i class="bi bi-plus-circle-fill text-success"></i> Nova categoria</h2>
                <?php endif; ?>

                <input type="hidden" name="id" value="<?= $editando['id'] ?>">

                <div class="mb-3">
                    <label class="form-label" for="cat-nome">Nome</label>
                    <input type="text" name="nome" id="cat-nome" class="form-control" maxlength="50"
                           placeholder="Ex.: Medicamentos" value="<?= e($editando['nome']) ?>" required
                           <?= $estaEditando ? 'autofocus' : '' ?>>
                </div>
                <div class="row g-3 mb-3">
                    <div class="col-8">
                        <label class="form-label" for="cat-icone">Ícone</label>
                        <select name="icone" id="cat-icone" class="form-select">
                            <?php foreach ($icones as $valor => $nomeIcone): ?>
                                <option value="<?= $valor ?>" <?= $editando['icone'] === $valor ? 'selected' : '' ?>><?= $nomeIcone ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="col-4">
                        <label class="form-label" for="cat-cor">Cor</label>
                        <input type="color" name="cor" id="cat-cor" class="form-control form-control-color w-100" value="<?= e($editando['cor']) ?>">
                    </div>
                </div>

                <div class="mb-3">
                    <span class="form-label d-block small text-muted">Prévia de como aparece no site:</span>
                    <span class="chip-categoria ativo previa-chip d-inline-block" id="previa-categoria"></span>
                </div>

                <div class="d-flex gap-2">
                    <button name="acao" value="salvar" class="btn btn-verde">
                        <i class="bi bi-check-lg"></i> <?= $estaEditando ? 'Salvar alterações' : 'Cadastrar' ?>
                    </button>
                    <?php if ($estaEditando): ?>
                        <a href="categorias.php" class="btn btn-outline-secondary">Cancelar edição</a>
                    <?php endif; ?>
                </div>
            </div>
        </form>
    </div>

    <div class="col-lg-7">
        <div class="table-responsive">
            <table class="table bg-white align-middle">
                <thead>
                    <tr>
                        <th>Categoria</th>
                        <th>Necessidades</th>
                        <th class="text-end">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($categorias as $c): ?>
                        <tr class="<?= (int) $c['id'] === (int) $editando['id'] ? 'linha-editando' : '' ?>">
                            <td>
                                <span class="chip-categoria ativo previa-chip" style="--cor: <?= e($c['cor']) ?>">
                                    <i class="bi bi-<?= e($c['icone']) ?>"></i> <?= e($c['nome']) ?>
                                </span>
                            </td>
                            <td><?= $c['total'] ?></td>
                            <td class="text-end text-nowrap">
                                <a href="categorias.php?editar=<?= $c['id'] ?>" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil-fill"></i> Editar
                                </a>
                                <form method="post" class="d-inline">
                                    <input type="hidden" name="id" value="<?= $c['id'] ?>">
                                    <button name="acao" value="excluir" class="btn btn-sm btn-outline-danger"
                                            onclick="return confirm('Excluir esta categoria?')">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php require '../includes/rodape.php'; ?>
