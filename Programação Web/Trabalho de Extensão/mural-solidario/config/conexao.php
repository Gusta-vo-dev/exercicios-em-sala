<?php
// Configurações do banco (padrão do XAMPP: usuário root sem senha)
$host  = 'localhost';
$banco = 'mural_solidario';
$usuario = 'root';
$senha = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$banco;charset=utf8mb4", $usuario, $senha);
    // Faz o PDO lançar exceção quando der erro no SQL
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    // Retorna os resultados como array associativo ($linha['nome'])
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die('Erro ao conectar com o banco de dados: ' . $e->getMessage());
}

// Dados da entidade parceira (aparecem na página "Sobre")
// Trocar pelos dados reais da entidade escolhida
define('ENTIDADE_NOME', 'Lar de Idosos Recanto da Paz');
define('ENTIDADE_ENDERECO', 'R. Guilherme Gemballa, 13 - Jardim América, Rio do Sul - SC');
define('ENTIDADE_TELEFONE', '(47) 3500-0000');
define('ENTIDADE_HORARIO', 'Segunda a sexta, das 8h às 17h');
