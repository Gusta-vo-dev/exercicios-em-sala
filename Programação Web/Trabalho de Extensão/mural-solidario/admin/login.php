<?php
require '../config/conexao.php';
require '../includes/funcoes.php';

// Se já está logado, vai direto para o painel
if (isset($_SESSION['usuario_id'])) {
    header('Location: index.php');
    exit;
}

$erro = '';
$email = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $senha = $_POST['senha'] ?? '';

    $stmt = $pdo->prepare('SELECT * FROM usuarios WHERE email = ?');
    $stmt->execute([$email]);
    $usuario = $stmt->fetch();

    // password_verify compara a senha digitada com o hash salvo no banco
    if ($usuario && password_verify($senha, $usuario['senha'])) {
        session_regenerate_id(true);
        $_SESSION['usuario_id'] = $usuario['id'];
        $_SESSION['usuario_nome'] = $usuario['nome'];
        header('Location: index.php');
        exit;
    }

    $erro = 'E-mail ou senha incorretos.';
}

$titulo = 'Login';
$base = '../';
require '../includes/cabecalho.php';
?>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-4 py-4">
        <div class="text-center mb-3">
            <span class="logo logo-grande"><i class="bi bi-box2-heart-fill"></i></span>
            <h1 class="h4 fw-bold mt-2 mb-0">Área da entidade</h1>
            <p class="text-muted small">Acesso restrito para quem cuida das doações</p>
        </div>

        <?php if ($erro): ?>
            <div class="alert alert-danger"><?= e($erro) ?></div>
        <?php endif; ?>

        <form method="post" class="card card-painel card-body p-4">
            <div class="mb-3">
                <label class="form-label">E-mail</label>
                <input type="email" name="email" class="form-control" value="<?= e($email) ?>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Senha</label>
                <input type="password" name="senha" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-verde w-100"><i class="bi bi-box-arrow-in-right"></i> Entrar</button>
        </form>
    </div>
</div>

<?php require '../includes/rodape.php'; ?>
