-- =====================================================
-- Mural Solidário - Script do banco de dados
-- Projeto de Extensão - Programação Web I - UNIDAVI
-- =====================================================

-- Garante que os acentos do script sejam lidos como UTF-8
SET NAMES utf8mb4;

DROP DATABASE IF EXISTS mural_solidario;
CREATE DATABASE mural_solidario CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE mural_solidario;

-- Usuários que acessam a área administrativa (pessoal da entidade)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Categorias das necessidades (higiene, alimentação...)
-- icone = nome de um ícone do Bootstrap Icons (ex.: basket2-fill)
-- cor   = cor da categoria em hexadecimal (ex.: #e8913a)
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    icone VARCHAR(40) NOT NULL DEFAULT 'box-seam-fill',
    cor VARCHAR(7) NOT NULL DEFAULT '#2e7d5b'
);

-- O que a entidade está precisando
CREATE TABLE necessidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    unidade VARCHAR(30) NOT NULL,          -- pacotes, kg, litros, unidades...
    meta INT NOT NULL,                     -- quantidade que a entidade precisa
    urgente TINYINT(1) NOT NULL DEFAULT 0, -- 1 = aparece primeiro e com destaque
    imagem VARCHAR(255) NULL,              -- caminho da imagem (img/itens/... ou uploads/...)
    status ENUM('aberta', 'encerrada') DEFAULT 'aberta',
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Doações feitas pela comunidade
-- prometida = pessoa disse que vai doar
-- recebida  = a entidade confirmou que chegou (só essa conta no "Recebido")
-- cancelada = pessoa desistiu ou não apareceu
CREATE TABLE doacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    necessidade_id INT NOT NULL,
    nome_doador VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    quantidade INT NOT NULL,
    data_prevista DATE NOT NULL,
    status ENUM('prometida', 'recebida', 'cancelada') DEFAULT 'prometida',
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    recebido_em DATETIME NULL,
    FOREIGN KEY (necessidade_id) REFERENCES necessidades(id)
);

-- =====================================================
-- Dados de exemplo
-- =====================================================

-- Usuário: admin@mural.com / senha: admin123
INSERT INTO usuarios (nome, email, senha) VALUES
('Administrador', 'admin@mural.com', '$2y$10$/K7Q2Hr73U47ri3BxEll6eCJMtr10TM2pEPv8YnIguMplk9hEevwC');

INSERT INTO categorias (nome, icone, cor) VALUES
('Alimentação',   'basket2-fill',    '#e8913a'),
('Higiene',       'droplet-fill',    '#4a8fd9'),
('Limpeza',       'bucket-fill',     '#2fa198'),
('Roupas e Cama', 'house-heart-fill', '#9563c9');

INSERT INTO necessidades (categoria_id, titulo, descricao, unidade, meta, urgente, imagem) VALUES
-- Alimentação (ids 1 a 7)
(1, 'Arroz tipo 1', 'Pacotes de 5 kg. É a base das refeições do dia a dia.', 'pacotes', 20, 0, 'img/itens/arroz.svg'),
(1, 'Feijão carioca', 'Pacotes de 1 kg.', 'pacotes', 30, 0, 'img/itens/feijao.svg'),
(1, 'Leite integral', 'Caixinhas de 1 litro, usadas no café da manhã e no lanche.', 'litros', 120, 1, 'img/itens/leite.svg'),
(1, 'Óleo de soja', 'Garrafas de 900 ml.', 'garrafas', 24, 0, 'img/itens/oleo.svg'),
(1, 'Café em pó', 'Pacotes de 500 g. Os idosos adoram um cafezinho à tarde!', 'pacotes', 15, 0, 'img/itens/cafe.svg'),
(1, 'Açúcar', 'Pacotes de 5 kg.', 'pacotes', 10, 0, 'img/itens/acucar.svg'),
(1, 'Biscoito água e sal', 'Para o lanche da tarde. Preferência por biscoitos sem açúcar.', 'pacotes', 40, 0, 'img/itens/biscoito.svg'),
-- Higiene (ids 8 a 14)
(2, 'Fralda geriátrica tamanho G', 'Usamos cerca de 10 pacotes por semana. É o item que mais falta!', 'pacotes', 50, 1, 'img/itens/fralda-g.svg'),
(2, 'Fralda geriátrica tamanho M', 'Pacotes com 8 unidades ou mais.', 'pacotes', 30, 0, 'img/itens/fralda-m.svg'),
(2, 'Sabonete líquido', 'Frascos com válvula, de preferência neutros (são mais suaves para a pele).', 'frascos', 30, 0, 'img/itens/sabonete.svg'),
(2, 'Creme dental', 'Tubos de 90 g, qualquer marca.', 'tubos', 40, 0, 'img/itens/creme-dental.svg'),
(2, 'Papel higiênico', 'Pacotes com 12 rolos, folha dupla.', 'pacotes', 25, 1, 'img/itens/papel-higienico.svg'),
(2, 'Shampoo neutro', 'Frascos de qualquer tamanho.', 'frascos', 20, 0, 'img/itens/shampoo.svg'),
(2, 'Lenço umedecido', 'Pacotes grandes, sem perfume.', 'pacotes', 35, 0, 'img/itens/lenco.svg'),
-- Limpeza (ids 15 a 21)
(3, 'Água sanitária', 'Frascos de 2 litros.', 'frascos', 25, 0, 'img/itens/agua-sanitaria.svg'),
(3, 'Detergente', 'Frascos de 500 ml.', 'frascos', 40, 0, 'img/itens/detergente.svg'),
(3, 'Sabão em pó', 'Caixas de 1 kg. Lavamos roupa de cama todos os dias.', 'caixas', 30, 1, 'img/itens/sabao-po.svg'),
(3, 'Desinfetante', 'Frascos de 2 litros, qualquer fragrância.', 'frascos', 20, 0, 'img/itens/desinfetante.svg'),
(3, 'Esponja de louça', 'Pacotes com 3 unidades ou mais.', 'pacotes', 15, 0, 'img/itens/esponja.svg'),
(3, 'Saco de lixo 100 L', 'Rolos ou pacotes.', 'rolos', 20, 0, 'img/itens/saco-lixo.svg'),
(3, 'Papel toalha', 'Pacotes com 2 rolos.', 'pacotes', 18, 0, 'img/itens/papel-toalha.svg'),
-- Roupas e Cama (ids 22 a 28)
(4, 'Lençol de solteiro', 'Novos ou em bom estado. Todas as camas são de solteiro.', 'unidades', 15, 0, 'img/itens/lencol.svg'),
(4, 'Toalha de banho', 'Novas ou em bom estado.', 'unidades', 20, 0, 'img/itens/toalha.svg'),
(4, 'Cobertor de solteiro', 'O inverno no Alto Vale é frio! Já estamos nos preparando.', 'unidades', 12, 0, 'img/itens/cobertor.svg'),
(4, 'Fronha', 'Para travesseiros de tamanho padrão.', 'unidades', 25, 0, 'img/itens/fronha.svg'),
(4, 'Travesseiro', 'Novos, de preferência antialérgicos.', 'unidades', 10, 0, 'img/itens/travesseiro.svg'),
(4, 'Meias', 'Meias quentinhas, tamanhos 37 a 43.', 'pares', 30, 0, 'img/itens/meias.svg'),
(4, 'Pijama', 'Pijamas de algodão, tamanhos M, G e GG.', 'unidades', 20, 0, 'img/itens/pijama.svg');

-- Doações recebidas (espalhadas nos últimos meses, para o relatório ter dados)
INSERT INTO doacoes (necessidade_id, nome_doador, telefone, quantidade, data_prevista, status, recebido_em) VALUES
(1,  'Maria Souza',                 '(47) 99911-1001', 6,  CURDATE() - INTERVAL 40 DAY, 'recebida', NOW() - INTERVAL 40 DAY),
(1,  'Mercado Bom Preço',           '(47) 99911-1002', 8,  CURDATE() - INTERVAL 12 DAY, 'recebida', NOW() - INTERVAL 12 DAY),
(3,  'Mercado Bom Preço',           '(47) 99911-1002', 60, CURDATE() - INTERVAL 3 DAY,  'recebida', NOW() - INTERVAL 3 DAY),
(5,  'Grupo de Jovens da Paróquia', '(47) 99911-1003', 10, CURDATE() - INTERVAL 20 DAY, 'recebida', NOW() - INTERVAL 20 DAY),
(5,  'Ana Lima',                    '(47) 99911-1004', 5,  CURDATE() - INTERVAL 6 DAY,  'recebida', NOW() - INTERVAL 6 DAY),
(7,  'Turma de SI - UNIDAVI',       '(47) 99911-1005', 30, CURDATE() - INTERVAL 15 DAY, 'recebida', NOW() - INTERVAL 15 DAY),
(8,  'Maria Souza',                 '(47) 99911-1001', 10, CURDATE() - INTERVAL 5 DAY,  'recebida', NOW() - INTERVAL 5 DAY),
(8,  'João Pereira',                '(47) 99911-1006', 8,  CURDATE() - INTERVAL 2 DAY,  'recebida', NOW() - INTERVAL 2 DAY),
(9,  'Luciana Hoffmann',            '(47) 99911-1007', 12, CURDATE() - INTERVAL 30 DAY, 'recebida', NOW() - INTERVAL 30 DAY),
(10, 'Luciana Hoffmann',            '(47) 99911-1007', 6,  CURDATE() - INTERVAL 50 DAY, 'recebida', NOW() - INTERVAL 50 DAY),
(11, 'Turma de SI - UNIDAVI',       '(47) 99911-1005', 20, CURDATE() - INTERVAL 15 DAY, 'recebida', NOW() - INTERVAL 15 DAY),
(12, 'Roberto Kraus',               '(47) 99911-1008', 3,  CURDATE() - INTERVAL 60 DAY, 'recebida', NOW() - INTERVAL 60 DAY),
(14, 'Juliana Weber',               '(47) 99911-1009', 10, CURDATE() - INTERVAL 25 DAY, 'recebida', NOW() - INTERVAL 25 DAY),
(15, 'Mercado Bom Preço',           '(47) 99911-1002', 12, CURDATE() - INTERVAL 45 DAY, 'recebida', NOW() - INTERVAL 45 DAY),
(16, 'Mercado Bom Preço',           '(47) 99911-1002', 24, CURDATE() - INTERVAL 45 DAY, 'recebida', NOW() - INTERVAL 45 DAY),
(17, 'Clube de Mães',               '(47) 99911-1010', 4,  CURDATE() - INTERVAL 8 DAY,  'recebida', NOW() - INTERVAL 8 DAY),
(19, 'Beatriz Lange',               '(47) 99911-1011', 12, CURDATE() - INTERVAL 35 DAY, 'recebida', NOW() - INTERVAL 35 DAY),
(22, 'Campanha do Agasalho',        '(47) 99911-1012', 8,  CURDATE() - INTERVAL 70 DAY, 'recebida', NOW() - INTERVAL 70 DAY),
(23, 'Campanha do Agasalho',        '(47) 99911-1012', 10, CURDATE() - INTERVAL 70 DAY, 'recebida', NOW() - INTERVAL 70 DAY),
(24, 'Campanha do Agasalho',        '(47) 99911-1012', 9,  CURDATE() - INTERVAL 75 DAY, 'recebida', NOW() - INTERVAL 75 DAY),
(27, 'Tiago Moser',                 '(47) 99911-1013', 12, CURDATE() - INTERVAL 18 DAY, 'recebida', NOW() - INTERVAL 18 DAY),
(28, 'Helena Krieger',              '(47) 99911-1014', 4,  CURDATE() - INTERVAL 22 DAY, 'recebida', NOW() - INTERVAL 22 DAY);

-- Doações prometidas (ainda vão ser entregues) e canceladas
INSERT INTO doacoes (necessidade_id, nome_doador, telefone, quantidade, data_prevista, status) VALUES
(1,  'Carlos Schmitt',   '(47) 99911-1015', 4,  CURDATE() + INTERVAL 1 DAY,  'prometida'),
(3,  'Paróquia São João', '(47) 99911-1016', 24, CURDATE() + INTERVAL 2 DAY,  'prometida'),
(8,  'Ana Lima',         '(47) 99911-1004', 5,  CURDATE() + INTERVAL 3 DAY,  'prometida'),
(11, 'Pedro Becker',     '(47) 99911-1017', 10, CURDATE() + INTERVAL 4 DAY,  'prometida'),
(16, 'Marcos Vieira',    '(47) 99911-1018', 6,  CURDATE() + INTERVAL 5 DAY,  'prometida'),
(23, 'Patrícia Schulz',  '(47) 99911-1019', 3,  CURDATE() + INTERVAL 2 DAY,  'prometida'),
(27, 'Camila Rosa',      '(47) 99911-1020', 6,  CURDATE() + INTERVAL 6 DAY,  'prometida'),
(12, 'Fernanda Kraus',   '(47) 99911-1021', 2,  CURDATE() - INTERVAL 10 DAY, 'cancelada');
