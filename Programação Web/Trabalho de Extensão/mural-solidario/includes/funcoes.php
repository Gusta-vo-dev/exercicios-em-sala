<?php
// Funções usadas em várias páginas do sistema

// Inicia a sessão só se ainda não foi iniciada
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Escapa o texto antes de mostrar no HTML (evita XSS)
function e($texto)
{
    return htmlspecialchars((string) $texto, ENT_QUOTES, 'UTF-8');
}

// Bloqueia a página se o usuário não estiver logado
function exigirLogin()
{
    if (!isset($_SESSION['usuario_id'])) {
        header('Location: login.php');
        exit;
    }
}

// Guarda uma mensagem para mostrar na próxima página
function mensagem($texto, $tipo = 'success')
{
    $_SESSION['mensagem'] = ['texto' => $texto, 'tipo' => $tipo];
}

// Mostra a mensagem guardada (e apaga ela)
function mostrarMensagem()
{
    if (isset($_SESSION['mensagem'])) {
        $m = $_SESSION['mensagem'];
        echo '<div class="alert alert-' . e($m['tipo']) . '">' . e($m['texto']) . '</div>';
        unset($_SESSION['mensagem']);
    }
}

// Calcula a porcentagem da meta (no máximo 100%)
function porcentagem($recebido, $meta)
{
    if ($meta <= 0) {
        return 0;
    }
    return min(100, round(($recebido / $meta) * 100));
}

// Salva a imagem enviada no formulário dentro da pasta uploads/
// Retorna o nome do arquivo salvo, ou null se não foi enviada imagem.
// Se a imagem for inválida, adiciona a mensagem no array $erros.
function salvarImagem($arquivo, &$erros)
{
    // Nenhum arquivo enviado: não é erro, a foto é opcional
    if (!isset($arquivo) || $arquivo['error'] === UPLOAD_ERR_NO_FILE) {
        return null;
    }

    if ($arquivo['error'] !== UPLOAD_ERR_OK) {
        $erros[] = 'Erro ao enviar a imagem. Tente novamente.';
        return null;
    }

    // Limite de 2 MB
    if ($arquivo['size'] > 2 * 1024 * 1024) {
        $erros[] = 'A imagem deve ter no máximo 2 MB.';
        return null;
    }

    // Confere o tipo REAL do arquivo (não confia só na extensão do nome)
    $tiposPermitidos = [
        'image/jpeg' => 'jpg',
        'image/png'  => 'png',
        'image/webp' => 'webp',
    ];
    $tipo = mime_content_type($arquivo['tmp_name']);
    if (!isset($tiposPermitidos[$tipo])) {
        $erros[] = 'A imagem deve ser JPG, PNG ou WEBP.';
        return null;
    }

    // Gera um nome único para não sobrescrever outra imagem
    $nomeArquivo = uniqid('necessidade_') . '.' . $tiposPermitidos[$tipo];
    $destino = __DIR__ . '/../uploads/' . $nomeArquivo;

    if (!move_uploaded_file($arquivo['tmp_name'], $destino)) {
        $erros[] = 'Não foi possível salvar a imagem no servidor.';
        return null;
    }

    // Salva no banco o caminho a partir da raiz do projeto
    return 'uploads/' . $nomeArquivo;
}

// Apaga uma imagem antiga da pasta uploads/
// As ilustrações padrão (pasta img/) nunca são apagadas
function apagarImagem($caminhoImagem)
{
    if (empty($caminhoImagem) || strpos($caminhoImagem, 'uploads/') !== 0) {
        return;
    }
    // basename() garante que só vamos mexer em arquivos dentro de uploads/
    $caminho = __DIR__ . '/../uploads/' . basename($caminhoImagem);
    if (is_file($caminho)) {
        unlink($caminho);
    }
}

// Lista de ícones que a entidade pode escolher para as categorias (Bootstrap Icons)
function iconesDisponiveis()
{
    return [
        'basket2-fill'     => 'Cesta',
        'droplet-fill'     => 'Gota',
        'bucket-fill'      => 'Balde',
        'house-heart-fill' => 'Casa com coração',
        'capsule'          => 'Remédio',
        'cup-hot-fill'     => 'Xícara',
        'egg-fried'        => 'Ovo',
        'book-fill'        => 'Livro',
        'puzzle-fill'      => 'Quebra-cabeça',
        'gift-fill'        => 'Presente',
        'heart-fill'       => 'Coração',
        'box-seam-fill'    => 'Caixa',
    ];
}

// Formata 11 números de telefone como (47) 99678-5392
function formatarTelefone($numeros)
{
    return '(' . substr($numeros, 0, 2) . ') ' . substr($numeros, 2, 5) . '-' . substr($numeros, 7, 4);
}

// Converte data do banco (2026-10-28) para o formato brasileiro (28/10/2026)
function dataBR($data)
{
    if (empty($data)) {
        return '-';
    }
    return date('d/m/Y', strtotime($data));
}
