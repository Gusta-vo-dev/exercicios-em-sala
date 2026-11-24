-- ==========================================
-- 1. CRIAÇÃO DAS VIEWS PARA USUÁRIO EXTERNO
-- ==========================================

-- View de placares públicos (oculta dados internos/administrativos)
CREATE OR REPLACE VIEW vw_placares_competicao AS
SELECT 
    c.nome AS competicao,
    p.temporada,
    p.rodada,
    p.data,
    cm.nome AS mandante,
    p.mandante_gols,
    p.visitante_gols,
    cv.nome AS visitante,
    e.nome AS estadio
FROM partida p
JOIN competicao c ON p.cmp_sequencia = c.cmp_sequencia
JOIN clube cm ON p.mandante_clb_sequencia = cm.clb_sequencia
JOIN clube cv ON p.visitante_clb_sequencia = cv.clb_sequencia
LEFT JOIN estadio e ON p.est_sequencia = e.est_sequencia;

-- View simplificada da tabela/posições da competição
CREATE OR REPLACE VIEW vw_tabela_classificacao AS
SELECT 
    c.nome AS competicao,
    p.temporada,
    cm.nome AS clube,
    p.mandante_posicao AS ultima_posicao,
    p.data AS data_referencia
FROM partida p
JOIN competicao c ON p.cmp_sequencia = c.cmp_sequencia
JOIN clube cm ON p.mandante_clb_sequencia = cm.clb_sequencia;

-- ==========================================
-- 2. CRIAÇÃO DOS PAPÉIS (ROLES)
-- ==========================================

CREATE ROLE role_admin;
CREATE ROLE role_operador;
CREATE ROLE role_externo;

-- Garante que ninguém tenha acesso padrão indevido ao schema public
REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;

-- ==========================================
-- 3. PERMISSÕES DO ADMINISTRADOR
-- ==========================================

GRANT ALL PRIVILEGES ON SCHEMA public TO role_admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO role_admin;

-- ==========================================
-- 4. PERMISSÕES DO USUÁRIO NORMAL (OPERADOR)
-- ==========================================

GRANT USAGE ON SCHEMA public TO role_operador;

-- Leitura e escrita operacional (sem DELETE para proteger o histórico)
GRANT SELECT, INSERT, UPDATE ON 
    partida, ocorrencia, participacao, escalacao, historico 
TO role_operador;

-- Leitura e atualização de cadastros organizacionais
GRANT SELECT, UPDATE ON 
    competicao, clube, estadio, pais 
TO role_operador;

-- Apenas leitura de jogadores (para montar escalações e ocorrências)
GRANT SELECT ON jogador TO role_operador;

-- Leitura nas views
GRANT SELECT ON vw_placares_competicao, vw_tabela_classificacao TO role_operador;

-- ==========================================
-- 5. PERMISSÕES DO USUÁRIO EXTERNO
-- ==========================================

GRANT USAGE ON SCHEMA public TO role_externo;

-- Acesso estritamente de leitura apenas às Views públicas
GRANT SELECT ON vw_placares_competicao, vw_tabela_classificacao TO role_externo;

-- ==========================================
-- 6. EXEMPLO DE CRIAÇÃO DE USUÁRIOS E VÍNCULO
-- ==========================================

CREATE USER usr_administrador WITH PASSWORD 'SenhaForteAdmin!2026';
CREATE USER usr_organizador   WITH PASSWORD 'SenhaForteOper!2026';
CREATE USER usr_visitante     WITH PASSWORD 'SenhaForteExt!2026';

GRANT role_admin    TO usr_administrador;
GRANT role_operador TO usr_organizador;
GRANT role_externo  TO usr_visitante;