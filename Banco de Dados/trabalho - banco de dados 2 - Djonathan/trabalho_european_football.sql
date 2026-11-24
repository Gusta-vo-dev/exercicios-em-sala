-- =====================================================================
-- TRABALHO DE BANCO DE DADOS II - UNIDAVI - AULA 18
-- BASE: EUROPEAN FOOTBALL (PostgreSQL)
-- EQUIPE: Djonathan, Gustavo, Joaquim e Kauan Paulo
-- APRESENTAÇÃO: 24/11/2026, 19h
-- =====================================================================
-- COMO USAR ESTE ARQUIVO
--   1. Crie um banco de teste e rode o europeanfootball.sql (cria as 9
--      tabelas vazias) e depois os INSERTs (clube.sql, jogador.sql etc.).
--   2. Rode este arquivo por partes, na ordem das seções.
--   3. Cada comando tem um comentário dizendo o que faz e por quê.
--
-- PREMISSAS (o script original só tem CREATE TABLE, sem PK/FK):
--   As chaves e relações abaixo foram INFERIDAS pelos nomes das colunas.
--   Confirme na base real (veja a seção 6, checklist, no final).
-- =====================================================================


-- =====================================================================
-- ATIVIDADE 1 - MODELO DE DADOS ORIGINAL (2 pts)
-- Objetivo: documentar o modelo com todos os detalhes: tabelas, colunas,
-- chaves primárias (PK), chaves estrangeiras (FK) e cardinalidades.
-- =====================================================================
--
-- RESUMO DO MODELO ORIGINAL (use como legenda do diagrama ER):
--
--   competicao   PK cmp_sequencia
--                FK cmp_sequencia_domestica -> competicao  (copas e
--                supercopas apontam para a liga do país; ex.: CDR -> ES1)
--   clube        PK clb_sequencia
--                FK cmp_sequencia_domestica -> competicao
--   jogador      PK jog_sequencia
--                FK clb_sequencia_atual -> clube
--                FK cmp_sequencia_atual -> competicao
--   partida      PK gam_sequencia
--                FK cmp_sequencia -> competicao
--                FK mandante_clb_sequencia, visitante_clb_sequencia -> clube
--   historico    PK gam_sequencia  (1:1 com partida)
--                FK gam_sequencia -> partida; mandante/visitante -> clube
--   participacao PK (gam_sequencia, jog_sequencia)
--                FK partida, jogador, clube (2x), competicao
--   escalacao    PK (gam_sequencia, jog_sequencia)
--                FK partida, jogador, clube
--   ocorrencia   PK ocr_sequencia (chave substituta, criada por nós)
--                FK partida, clube, jogador, jogador que entra,
--                jogador que assiste
--   mercado      PK (jog_sequencia, data)
--                FK jogador, clube, competicao
--
-- CARDINALIDADES:
--   competicao 1:N clube | competicao 1:N partida
--   clube 1:N jogador    | clube 1:N partida (como mandante e visitante)
--   partida 1:1 historico
--   partida 1:N participacao / escalacao / ocorrencia
--   jogador 1:N participacao / escalacao / mercado / ocorrencia

-- ---- 1.1 Chaves primárias --------------------------------------------
-- Uma PK garante que cada linha é única e cria um índice automaticamente.
ALTER TABLE competicao   ADD CONSTRAINT pk_competicao   PRIMARY KEY (cmp_sequencia);
ALTER TABLE clube        ADD CONSTRAINT pk_clube        PRIMARY KEY (clb_sequencia);
ALTER TABLE jogador      ADD CONSTRAINT pk_jogador      PRIMARY KEY (jog_sequencia);
ALTER TABLE partida      ADD CONSTRAINT pk_partida      PRIMARY KEY (gam_sequencia);
ALTER TABLE historico    ADD CONSTRAINT pk_historico    PRIMARY KEY (gam_sequencia);
-- PK composta: um jogador só participa uma vez de cada jogo.
ALTER TABLE participacao ADD CONSTRAINT pk_participacao PRIMARY KEY (gam_sequencia, jog_sequencia);
ALTER TABLE escalacao    ADD CONSTRAINT pk_escalacao    PRIMARY KEY (gam_sequencia, jog_sequencia);
-- Um jogador tem um valor de mercado por data.
ALTER TABLE mercado      ADD CONSTRAINT pk_mercado      PRIMARY KEY (jog_sequencia, data);
-- ocorrencia não tem chave natural: criamos uma chave substituta.
ALTER TABLE ocorrencia   ADD COLUMN ocr_sequencia bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

-- ---- 1.2 Chaves estrangeiras -----------------------------------------
-- NOT VALID: cria a regra para linhas novas sem falhar por causa de
-- linhas antigas órfãs. Depois se valida (item 1.3).
ALTER TABLE competicao ADD CONSTRAINT fk_cmp_domestica FOREIGN KEY (cmp_sequencia_domestica) REFERENCES competicao (cmp_sequencia) NOT VALID;
ALTER TABLE clube      ADD CONSTRAINT fk_clb_cmp       FOREIGN KEY (cmp_sequencia_domestica) REFERENCES competicao (cmp_sequencia) NOT VALID;
ALTER TABLE jogador    ADD CONSTRAINT fk_jog_clube     FOREIGN KEY (clb_sequencia_atual)     REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE jogador    ADD CONSTRAINT fk_jog_cmp       FOREIGN KEY (cmp_sequencia_atual)     REFERENCES competicao (cmp_sequencia) NOT VALID;
ALTER TABLE partida    ADD CONSTRAINT fk_par_cmp       FOREIGN KEY (cmp_sequencia)           REFERENCES competicao (cmp_sequencia) NOT VALID;
ALTER TABLE partida    ADD CONSTRAINT fk_par_mand      FOREIGN KEY (mandante_clb_sequencia)  REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE partida    ADD CONSTRAINT fk_par_vis       FOREIGN KEY (visitante_clb_sequencia) REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE historico  ADD CONSTRAINT fk_his_par       FOREIGN KEY (gam_sequencia)           REFERENCES partida (gam_sequencia)    NOT VALID;
ALTER TABLE historico  ADD CONSTRAINT fk_his_mand      FOREIGN KEY (mandante_clb_sequencia)  REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE historico  ADD CONSTRAINT fk_his_vis       FOREIGN KEY (visitante_clb_sequencia) REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE participacao ADD CONSTRAINT fk_prt_par       FOREIGN KEY (gam_sequencia)       REFERENCES partida (gam_sequencia)    NOT VALID;
ALTER TABLE participacao ADD CONSTRAINT fk_prt_jog       FOREIGN KEY (jog_sequencia)       REFERENCES jogador (jog_sequencia)    NOT VALID;
ALTER TABLE participacao ADD CONSTRAINT fk_prt_clb       FOREIGN KEY (clb_sequencia)       REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE participacao ADD CONSTRAINT fk_prt_clb_atual FOREIGN KEY (clb_sequencia_atual) REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE participacao ADD CONSTRAINT fk_prt_cmp       FOREIGN KEY (cmp_sequencia)       REFERENCES competicao (cmp_sequencia) NOT VALID;
ALTER TABLE escalacao  ADD CONSTRAINT fk_esc_par       FOREIGN KEY (gam_sequencia)           REFERENCES partida (gam_sequencia)    NOT VALID;
ALTER TABLE escalacao  ADD CONSTRAINT fk_esc_jog       FOREIGN KEY (jog_sequencia)           REFERENCES jogador (jog_sequencia)    NOT VALID;
ALTER TABLE escalacao  ADD CONSTRAINT fk_esc_clb       FOREIGN KEY (clb_sequencia)           REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE ocorrencia ADD CONSTRAINT fk_ocr_par       FOREIGN KEY (gam_sequencia)               REFERENCES partida (gam_sequencia) NOT VALID;
ALTER TABLE ocorrencia ADD CONSTRAINT fk_ocr_clb       FOREIGN KEY (clb_sequencia)               REFERENCES clube (clb_sequencia)   NOT VALID;
ALTER TABLE ocorrencia ADD CONSTRAINT fk_ocr_jog       FOREIGN KEY (jog_sequencia)               REFERENCES jogador (jog_sequencia) NOT VALID;
ALTER TABLE ocorrencia ADD CONSTRAINT fk_ocr_ent       FOREIGN KEY (jog_sequencia_entrada)       REFERENCES jogador (jog_sequencia) NOT VALID;
ALTER TABLE ocorrencia ADD CONSTRAINT fk_ocr_ass       FOREIGN KEY (jog_sequencia_assistencia)   REFERENCES jogador (jog_sequencia) NOT VALID;
ALTER TABLE mercado    ADD CONSTRAINT fk_mer_jog       FOREIGN KEY (jog_sequencia)           REFERENCES jogador (jog_sequencia)    NOT VALID;
ALTER TABLE mercado    ADD CONSTRAINT fk_mer_clb       FOREIGN KEY (clb_sequencia)           REFERENCES clube (clb_sequencia)      NOT VALID;
ALTER TABLE mercado    ADD CONSTRAINT fk_mer_cmp       FOREIGN KEY (cmp_sequencia)           REFERENCES competicao (cmp_sequencia) NOT VALID;

-- ---- 1.3 Validação das FKs (rodar depois de limpar eventuais órfãos) --
-- Exemplo de busca de órfãos (deve retornar 0):
--   SELECT COUNT(*) FROM participacao p
--   LEFT JOIN partida g USING (gam_sequencia)
--   WHERE g.gam_sequencia IS NULL;
-- Depois valida cada FK, por exemplo:
--   ALTER TABLE participacao VALIDATE CONSTRAINT fk_prt_par;

-- DIAGRAMA ER: no pgAdmin, botão direito no banco > "ERD Tool" (ou use o
-- dbdiagram.io). Tire um print para o slide da Atividade 1.


-- =====================================================================
-- ATIVIDADE 2 - TRÊS MELHORIAS DE NORMALIZAÇÃO E NOVO MODELO (2 pts)
-- Objetivo: aplicar normalização (até a 3FN) e gerar um NOVO MODELO.
-- Não precisa converter os dados, só criar o modelo.
-- O novo modelo fica em um schema separado ("normalizado") para não
-- misturar com as tabelas originais.
--
-- MELHORIA 1: tabelas de domínio para eliminar dependências transitivas
--   (pais_nome depende de pais_sequencia; tipo depende de subtipo;
--    posicao depende de subposicao)  -> 3FN
-- MELHORIA 2: extrair entidades embutidas como texto repetido
--   (estádio, técnico, árbitro, formação)
-- MELHORIA 3: eliminar redundância e dados derivados
--   (historico duplica partida; datas e competição repetidas em
--    participacao/escalacao/ocorrencia; agregados gravados em clube e
--    valor de mercado atual em jogador)
-- =====================================================================

CREATE SCHEMA IF NOT EXISTS normalizado;
SET search_path TO normalizado;

-- ---- MELHORIA 1: tabelas de domínio -----------------------------------
CREATE TABLE pais (
  pais_sequencia integer PRIMARY KEY,
  nome           varchar(200) NOT NULL
);

CREATE TABLE tipo_competicao (
  tpc_sequencia smallint PRIMARY KEY,
  tipo          varchar(200) NOT NULL UNIQUE
);

-- subtipo determina tipo (ex.: first_tier -> domestic_league)
CREATE TABLE subtipo_competicao (
  stc_sequencia smallint PRIMARY KEY,
  subtipo       varchar(200) NOT NULL UNIQUE,
  tpc_sequencia smallint NOT NULL REFERENCES tipo_competicao
);

CREATE TABLE posicao (
  pos_sequencia smallint PRIMARY KEY,
  posicao       varchar(200) NOT NULL UNIQUE
);

-- subposicao determina posicao (premissa a confirmar na base real)
CREATE TABLE subposicao (
  sps_sequencia smallint PRIMARY KEY,
  subposicao    varchar(200) NOT NULL UNIQUE,
  pos_sequencia smallint NOT NULL REFERENCES posicao
);

-- ---- MELHORIA 2: entidades que estavam como texto repetido ------------
CREATE TABLE estadio (
  est_sequencia integer PRIMARY KEY,
  nome          varchar(200) NOT NULL,
  assentos      integer
);

CREATE TABLE tecnico (
  tec_sequencia integer PRIMARY KEY,
  nome          varchar(200) NOT NULL
);

CREATE TABLE arbitro (
  arb_sequencia integer PRIMARY KEY,
  nome          varchar(200) NOT NULL
);

CREATE TABLE formacao (
  frm_sequencia smallint PRIMARY KEY,
  descricao     varchar(50) NOT NULL UNIQUE
);

-- Tipo do evento do jogo (gol, cartão, substituição...) em vez de texto
CREATE TABLE tipo_ocorrencia (
  toc_sequencia smallint PRIMARY KEY,
  tipo          varchar(200) NOT NULL UNIQUE
);

-- ---- Tabelas principais já normalizadas (aplicam as 3 melhorias) ------
-- competicao: saem pais_nome, tipo e subtipo (agora vêm das tabelas de domínio)
CREATE TABLE competicao (
  cmp_sequencia           char(5) PRIMARY KEY,
  nome                    varchar(200) NOT NULL,
  stc_sequencia           smallint REFERENCES subtipo_competicao,
  pais_sequencia          integer  REFERENCES pais,          -- nulo em torneios internacionais
  cmp_sequencia_domestica char(5)  REFERENCES competicao,
  competicao_principal    boolean NOT NULL DEFAULT false
);

-- clube: saem nome_estadio/assentos (viram FK para estadio) e os
-- agregados numero_jogadores, media_idade, numero_estrangeiros e
-- jogadores_selecao (viram a view v_clube_estatistica, mais abaixo)
CREATE TABLE clube (
  clb_sequencia           integer PRIMARY KEY,
  nome                    varchar(200) NOT NULL,
  cmp_sequencia_domestica char(5) REFERENCES competicao,
  est_sequencia           integer REFERENCES estadio,
  ultima_temporada        integer
);

-- jogador: saem cmp_sequencia_atual (derivável de clube), equipe,
-- valor_mercado e maior_valor_mercado (deriváveis de mercado) e
-- posicao/subposicao (viram sps_sequencia)
-- PREMISSA: nacionalidade e cidadania guardam nomes de países; se não,
-- mantenha como varchar.
CREATE TABLE jogador (
  jog_sequencia        integer PRIMARY KEY,
  primeiro_nome        varchar(200),
  sobrenome            varchar(200),
  nome                 varchar(200) NOT NULL,
  ultima_temporada     integer,
  clb_sequencia_atual  integer REFERENCES clube,
  nacionalidade_pais   integer REFERENCES pais,
  naturalidade         varchar(200),
  cidadania_pais       integer REFERENCES pais,
  nascimento           timestamp,
  sps_sequencia        smallint REFERENCES subposicao,
  dominante            varchar(200),
  altura               decimal(18,8)
);

-- partida: saem competicao_tipo (derivado), técnicos/árbitro/estádio/
-- formações como texto (viram FKs)
CREATE TABLE partida (
  gam_sequencia           integer PRIMARY KEY,
  cmp_sequencia           char(5) NOT NULL REFERENCES competicao,
  temporada               integer,
  rodada                  varchar(200),
  data                    timestamp,
  mandante_clb_sequencia  integer NOT NULL REFERENCES clube,
  visitante_clb_sequencia integer NOT NULL REFERENCES clube,
  mandante_gols           integer,
  visitante_gols          integer,
  mandante_posicao        integer,
  visitante_posicao       integer,
  mandante_tec_sequencia  integer REFERENCES tecnico,
  visitante_tec_sequencia integer REFERENCES tecnico,
  est_sequencia           integer REFERENCES estadio,
  publico                 decimal(18,8),
  arb_sequencia           integer REFERENCES arbitro,
  mandante_frm_sequencia  smallint REFERENCES formacao,
  visitante_frm_sequencia smallint REFERENCES formacao,
  agregado                varchar(200)
);

-- participacao: saem date, cmp_sequencia (vêm de partida) e
-- clb_sequencia_atual (vem de jogador).
-- DECISÃO CONSCIENTE: gols, assistencia e cartões ficam aqui por
-- desempenho (desnormalização intencional, lidos o tempo todo em rankings).
CREATE TABLE participacao (
  gam_sequencia   integer NOT NULL REFERENCES partida,
  jog_sequencia   integer NOT NULL REFERENCES jogador,
  clb_sequencia   integer NOT NULL REFERENCES clube,
  cartao_amarelo  integer,
  cartao_vermelho integer,
  gols            integer,
  assistencia     integer,
  minuto_em_campo integer,
  PRIMARY KEY (gam_sequencia, jog_sequencia)
);

-- escalacao: sai data (vem de partida)
CREATE TABLE escalacao (
  gam_sequencia integer NOT NULL REFERENCES partida,
  jog_sequencia integer NOT NULL REFERENCES jogador,
  clb_sequencia integer NOT NULL REFERENCES clube,
  tipo          varchar(200),
  posicao       varchar(200),
  numero        varchar(200),
  capitao       integer,
  PRIMARY KEY (gam_sequencia, jog_sequencia)
);

-- ocorrencia: sai data; tipo vira FK para tipo_ocorrencia
CREATE TABLE ocorrencia (
  ocr_sequencia             bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  gam_sequencia             integer NOT NULL REFERENCES partida,
  minuto                    integer,
  toc_sequencia             smallint REFERENCES tipo_ocorrencia,
  clb_sequencia             integer REFERENCES clube,
  jog_sequencia             integer REFERENCES jogador,
  descricao                 varchar(200),
  jog_sequencia_entrada     integer REFERENCES jogador,
  jog_sequencia_assistencia integer REFERENCES jogador
);

CREATE TABLE mercado (
  jog_sequencia integer NOT NULL REFERENCES jogador,
  data          timestamp NOT NULL,
  valor_mercado integer,
  clb_sequencia integer REFERENCES clube,
  cmp_sequencia char(5) REFERENCES competicao,
  PRIMARY KEY (jog_sequencia, data)
);

-- ---- MELHORIA 3: views que substituem o que foi removido --------------
-- historico deixou de existir como tabela: é calculado a partir de partida.
CREATE VIEW v_historico AS
SELECT p.gam_sequencia,
       p.mandante_clb_sequencia,  p.mandante_gols,  p.mandante_posicao,  p.mandante_tec_sequencia,
       p.visitante_clb_sequencia, p.visitante_gols, p.visitante_posicao, p.visitante_tec_sequencia,
       CASE WHEN p.mandante_gols > p.visitante_gols THEN 1
            WHEN p.mandante_gols < p.visitante_gols THEN -1
            ELSE 0 END AS vitoria          -- 1 = mandante, -1 = visitante, 0 = empate
FROM partida p;

-- Valor de mercado atual e máximo agora vêm do histórico (mercado).
CREATE VIEW v_jogador_valor AS
SELECT m.jog_sequencia,
       (ARRAY_AGG(m.valor_mercado ORDER BY m.data DESC))[1] AS valor_mercado_atual,
       MAX(m.valor_mercado)                                 AS maior_valor_mercado
FROM mercado m
GROUP BY m.jog_sequencia;

-- Clube/competição atual do jogador, sem guardar redundância.
CREATE VIEW v_jogador_atual AS
SELECT j.jog_sequencia, j.nome, c.clb_sequencia, c.nome AS clube,
       c.cmp_sequencia_domestica AS competicao_atual
FROM jogador j
LEFT JOIN clube c ON c.clb_sequencia = j.clb_sequencia_atual;

-- Estatísticas do elenco calculadas em vez de gravadas.
-- (numero_estrangeiros e jogadores_selecao dependem de regra de negócio
--  que o script não mostra; deixamos número de jogadores e média de idade)
CREATE VIEW v_clube_estatistica AS
SELECT j.clb_sequencia_atual AS clb_sequencia,
       COUNT(*) AS numero_jogadores,
       ROUND(AVG(EXTRACT(YEAR FROM AGE(j.nascimento)))::numeric, 2) AS media_idade
FROM jogador j
WHERE j.clb_sequencia_atual IS NOT NULL
GROUP BY j.clb_sequencia_atual;

-- Opcional: guardar o histórico dos agregados do clube por temporada.
CREATE TABLE clube_temporada (
  clb_sequencia       integer NOT NULL REFERENCES clube,
  temporada           integer NOT NULL,
  numero_jogadores    integer,
  media_idade         decimal(18,8),
  numero_estrangeiros integer,
  jogadores_selecao   integer,
  PRIMARY KEY (clb_sequencia, temporada)
);

-- Volta ao schema original para as próximas atividades.
SET search_path TO public;


-- =====================================================================
-- ATIVIDADE 3 - POLÍTICA DE SEGURANÇA PARA 3 PAPÉIS (2 pts)
-- Base teórica (aula 15): controle discricionário (DAC), princípio do
-- menor privilégio, roles em vez de permissão por usuário, auditoria
-- pelo dicionário de dados.
--
--   papel_consulta : somente leitura (analistas, aplicações). Não vê o
--                    valor de mercado (dado comercial sensível).
--   papel_operador : carrega os dados das rodadas. INSERT/UPDATE nas
--                    tabelas de jogo, sem DELETE.
--   papel_admin    : DBA, controle total e gestão de roles.
-- =====================================================================

-- Papéis sem login: os usuários herdam as permissões do papel.
CREATE ROLE papel_consulta NOLOGIN;
CREATE ROLE papel_operador NOLOGIN;
CREATE ROLE papel_admin    NOLOGIN CREATEROLE;

-- Base fechada por padrão: ninguém acessa nada sem GRANT explícito.
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO papel_consulta, papel_operador, papel_admin;

-- ---- papel_consulta ---------------------------------------------------
GRANT SELECT ON clube, competicao, partida, historico,
                participacao, escalacao, ocorrencia TO papel_consulta;
-- Privilégio por COLUNA: jogador sem valor_mercado e maior_valor_mercado.
-- (Para endurecer, retire também "nascimento": dado pessoal pela LGPD.
--  Aqui já está fora da lista.)
GRANT SELECT (jog_sequencia, primeiro_nome, sobrenome, nome, ultima_temporada,
              clb_sequencia_atual, nacionalidade, naturalidade, cidadania,
              subposicao, posicao, dominante, altura, cmp_sequencia_atual, equipe)
  ON jogador TO papel_consulta;
-- mercado não é concedido: o papel de consulta não vê valores.

-- ---- papel_operador ---------------------------------------------------
GRANT SELECT ON clube, competicao, jogador TO papel_operador;
GRANT SELECT, INSERT, UPDATE ON partida, participacao, escalacao, ocorrencia TO papel_operador;
-- Sem DELETE: quem carrega dados não apaga histórico.
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO papel_operador;  -- ocorrencia usa IDENTITY

-- ---- papel_admin ------------------------------------------------------
GRANT ALL PRIVILEGES ON ALL TABLES    IN SCHEMA public TO papel_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO papel_admin;

-- ---- Usuários (sintaxe PostgreSQL) ------------------------------------
-- ATENÇÃO: o material da aula 15 usa "IDENTIFIED BY" (Oracle) e tem erros
-- de digitação; no PostgreSQL é CREATE USER ... PASSWORD.
CREATE USER usuario_analista LOGIN PASSWORD 'trocar_senha_1';
CREATE USER usuario_operador LOGIN PASSWORD 'trocar_senha_2';
CREATE USER usuario_admin    LOGIN PASSWORD 'trocar_senha_3';

GRANT papel_consulta TO usuario_analista;
GRANT papel_operador TO usuario_operador;
GRANT papel_admin    TO usuario_admin;

-- Tabelas criadas no futuro já nascem legíveis pelo papel de consulta.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO papel_consulta;

-- ---- Revogação (ciclo de vida do usuário) -----------------------------
-- Saída de um funcionário: basta remover o usuário do papel.
--   REVOKE papel_operador FROM usuario_operador;
-- Ajuste de política (CASCADE remove também de quem recebeu por delegação):
--   REVOKE INSERT ON ocorrencia FROM papel_operador;
--   REVOKE SELECT ON ocorrencia FROM papel_consulta CASCADE;

-- ---- Auditoria periódica (combate ao "privilege creep") ---------------
-- Quem pode o quê em cada tabela:
SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
ORDER BY grantee, table_name;

-- Permissões por coluna do papel de consulta:
SELECT grantee, table_name, column_name, privilege_type
FROM information_schema.role_column_grants
WHERE table_schema = 'public' AND grantee = 'papel_consulta';

-- Quem pertence a cada papel:
SELECT r.rolname AS papel, m.rolname AS membro
FROM pg_auth_members am
JOIN pg_roles r ON r.oid = am.roleid
JOIN pg_roles m ON m.oid = am.member
ORDER BY r.rolname;


-- =====================================================================
-- ATIVIDADE 4 - TRÊS ALTERNATIVAS DE PERFORMANCE: ÍNDICES E VISÕES (2 pts)
-- Método (aula 16): 1) medir com EXPLAIN ANALYZE; 2) criar o índice;
-- 3) medir de novo e registrar os prints do antes e depois
-- (Seq Scan -> Index Scan e o "Execution Time").
-- Os tempos dependem do volume: usem os números da base real.
-- =====================================================================

-- ---- ALTERNATIVA 1: índices B-tree compostos em FKs e filtros --------
-- Cada índice acelera JOINs e filtros frequentes sem varrer a tabela toda.
CREATE INDEX idx_partida_cmp_temp  ON partida (cmp_sequencia, temporada, data);
CREATE INDEX idx_partida_mandante  ON partida (mandante_clb_sequencia, data DESC);
CREATE INDEX idx_partida_visitante ON partida (visitante_clb_sequencia, data DESC);
CREATE INDEX idx_participacao_jog  ON participacao (jog_sequencia, date);
CREATE INDEX idx_participacao_clb  ON participacao (clb_sequencia, cmp_sequencia, date);
CREATE INDEX idx_ocorrencia_jogo   ON ocorrencia (gam_sequencia, minuto);
CREATE INDEX idx_mercado_jog_data  ON mercado (jog_sequencia, data DESC);
CREATE INDEX idx_jogador_clube     ON jogador (clb_sequencia_atual);

-- Reescrita "sargável" (regra da aula 16): função sobre coluna indexada
-- anula o índice. As consultas das atividades anteriores usavam
--   WHERE EXTRACT(YEAR FROM p.date) = 2023        (NÃO usa índice)
-- Troque por faixa de datas:
--   WHERE p.cmp_sequencia = 'FR1'
--     AND p.date >= DATE '2023-01-01' AND p.date < DATE '2024-01-01'

-- Exemplo para medir (rode antes e depois de criar os índices):
EXPLAIN ANALYZE
SELECT c.nome, AVG(j.altura) AS media_altura
FROM participacao p
JOIN jogador j ON j.jog_sequencia = p.jog_sequencia
JOIN clube c   ON c.clb_sequencia = p.clb_sequencia
WHERE p.cmp_sequencia = 'FR1'
  AND p.date >= DATE '2023-01-01' AND p.date < DATE '2024-01-01'
GROUP BY c.clb_sequencia, c.nome;

-- ---- ALTERNATIVA 2: índices especializados ----------------------------
-- Parciais: indexam só as linhas relevantes (menores e mais rápidos).
CREATE INDEX idx_prt_gols     ON participacao (jog_sequencia) WHERE gols > 0;
CREATE INDEX idx_prt_amarelos ON participacao (jog_sequencia) WHERE cartao_amarelo > 0;
CREATE INDEX idx_prt_vermelho ON participacao (jog_sequencia) WHERE cartao_vermelho > 0;

-- BRIN: índice minúsculo para tabelas grandes gravadas em ordem de data
-- (só funciona bem se a tabela estiver fisicamente em ordem cronológica).
CREATE INDEX idx_mercado_data_brin ON mercado USING BRIN (data);

-- Trigram: acelera busca por parte do nome (ILIKE '%nome%').
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX idx_jogador_nome_trgm ON jogador USING GIN (nome gin_trgm_ops);

-- Custo dos índices: cada INSERT/UPDATE precisa atualizá-los. Monitore os
-- que não são usados e remova:
--   SELECT relname, indexrelname, idx_scan FROM pg_stat_user_indexes
--   ORDER BY idx_scan;

-- ---- ALTERNATIVA 3: visões (comum e materializada) --------------------
-- Visão comum: padroniza o JOIN mais repetido (não guarda dados).
CREATE VIEW v_partida_detalhada AS
SELECT p.gam_sequencia, p.data, p.temporada, p.rodada,
       c.nome AS competicao, m.nome AS mandante, v.nome AS visitante,
       p.mandante_gols, p.visitante_gols, p.publico
FROM partida p
JOIN competicao c ON c.cmp_sequencia = p.cmp_sequencia
JOIN clube m      ON m.clb_sequencia = p.mandante_clb_sequencia
JOIN clube v      ON v.clb_sequencia = p.visitante_clb_sequencia;

-- Visão materializada: GUARDA o resultado pré-calculado (artilharia,
-- cartões, minutos). A consulta deixa de agrupar toda a participacao
-- a cada chamada.
CREATE MATERIALIZED VIEW mv_estatistica_jogador_temporada AS
SELECT pr.jog_sequencia, pa.cmp_sequencia, pa.temporada,
       COUNT(*)                  AS jogos,
       SUM(pr.gols)              AS gols,
       SUM(pr.assistencia)       AS assistencias,
       SUM(pr.cartao_amarelo)    AS amarelos,
       SUM(pr.cartao_vermelho)   AS vermelhos,
       SUM(pr.minuto_em_campo)   AS minutos
FROM participacao pr
JOIN partida pa ON pa.gam_sequencia = pr.gam_sequencia
GROUP BY pr.jog_sequencia, pa.cmp_sequencia, pa.temporada;

-- O índice único é obrigatório para atualizar sem bloquear leituras.
CREATE UNIQUE INDEX ux_mv_est_jogador
  ON mv_estatistica_jogador_temporada (jog_sequencia, cmp_sequencia, temporada);

-- Rode depois de cada carga de rodada:
REFRESH MATERIALIZED VIEW CONCURRENTLY mv_estatistica_jogador_temporada;

-- Manutenção (aula 16): após cargas grandes e periodicamente:
--   VACUUM ANALYZE participacao;
--   REINDEX TABLE CONCURRENTLY participacao;


-- =====================================================================
-- ATIVIDADE 5 - ESTRATÉGIA DE DISTRIBUIÇÃO DOS DADOS (2 pts)
-- Aula 17: evoluir em camadas. Medir antes, esgotar cada estratégia e só
-- então avançar: índices/consultas -> réplicas e particionamento ->
-- multi-tenant -> sharding.
-- =====================================================================

-- ---- 5.0 Diagnóstico: quais tabelas são realmente grandes? -------------
SELECT relname, pg_size_pretty(pg_total_relation_size(relid)) AS tamanho
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC;

-- ---- 5.1 REPLICAÇÃO ----------------------------------------------------
-- (a) Física (streaming): 1 primário + 1 ou 2 réplicas "hot standby".
--     Escritas só no primário; relatórios e rankings nas réplicas.
--     Assíncrona na réplica de leitura (menor latência de escrita);
--     síncrona só em um standby de failover se o RPO exigido for zero.
--     Failover automático: Patroni ou Repmgr.
--     No primário (postgresql.conf):
--       wal_level = logical
--       max_wal_senders = 5
--       hot_standby = on
--
-- (b) Lógica: envia só algumas tabelas a um banco analítico.
CREATE PUBLICATION pub_analitico FOR TABLE partida, participacao, clube, competicao;
-- No banco analítico (outro servidor/banco):
--   CREATE SUBSCRIPTION sub_analitico
--     CONNECTION 'host=primario dbname=europeanfootball user=replicador'
--     PUBLICATION pub_analitico;

-- ---- 5.2 PARTICIONAMENTO (recomendação principal) -----------------------
-- RANGE por data, uma partição por temporada (jul a jun). Ganhos:
-- partition pruning, DROP de partição antiga no lugar de DELETE e
-- manutenção por partição.
-- ATENÇÃO: em tabela particionada a PK precisa incluir a coluna de
-- partição. Por isso a PK vira (gam_sequencia, data) e as FKs de
-- participacao/escalacao/ocorrencia (que já guardam a data no modelo
-- original) passam a referenciar (gam_sequencia, data).
CREATE TABLE partida_part (LIKE partida INCLUDING DEFAULTS)
  PARTITION BY RANGE (data);
ALTER TABLE partida_part ADD PRIMARY KEY (gam_sequencia, data);

CREATE TABLE partida_2223 PARTITION OF partida_part
  FOR VALUES FROM ('2022-07-01') TO ('2023-07-01');
CREATE TABLE partida_2324 PARTITION OF partida_part
  FOR VALUES FROM ('2023-07-01') TO ('2024-07-01');
-- Linhas fora das faixas caem aqui, em vez de dar erro:
CREATE TABLE partida_default PARTITION OF partida_part DEFAULT;

-- Migração (em janela de manutenção):
--   INSERT INTO partida_part SELECT * FROM partida;
--   depois renomear partida -> partida_old e partida_part -> partida.
--
-- Outras formas de particionar (comparação para apresentar):
--   RANGE por data : partida, participacao, escalacao, ocorrencia, mercado
--                    (consultas e cargas por temporada: caso principal)
--   LIST por cmp_sequencia : partida (consultas sempre de uma liga)
--   HASH por jog_sequencia : participacao (consultas centradas no jogador,
--                            sem critério natural de faixa)
-- No modelo NORMALIZADO (que removeu a data de participacao etc.), uma
-- alternativa é particionar por HASH (gam_sequencia), mantendo PK simples.

-- ---- 5.3 FRAGMENTAÇÃO (SHARDING): avaliada e NÃO recomendada -----------
-- Aula 17: sharding é último recurso, a partir de cerca de 1 TB de dados
-- ativos ou quando o limite de escrita do primário é atingido. Base
-- histórica de futebol, atualizada por rodada, tende a ficar longe disso
-- (confirmar com a consulta 5.0). Além disso, JOINs entre partida,
-- participacao e ocorrencia ficariam caros entre shards.
-- Se um dia for necessário (ex.: dados ao vivo de dezenas de ligas),
-- Citus distribuindo por gam_sequencia, com co-location:
--   SELECT create_distributed_table('partida', 'gam_sequencia');
--   SELECT create_distributed_table('participacao', 'gam_sequencia',
--                                   colocate_with => 'partida');
--   SELECT create_reference_table('competicao');
--   SELECT create_reference_table('clube');

-- ---- 5.4 MULTI-TENANT (cenário: sistema vendido como SaaS) ------------
-- Cada liga, federação ou clube cliente seria um "tenant".
--   Banco compartilhado + tenant_id + RLS : muitos tenants pequenos; barato
--   Schema por tenant                      : médio porte; isolamento lógico forte
--   Banco dedicado                         : grandes clientes com compliance (LGPD)
-- Proposta HÍBRIDA: compartilhado com RLS para a maioria e banco dedicado
-- para clientes enterprise.
ALTER TABLE partida ADD COLUMN tenant_id uuid;
CREATE INDEX idx_partida_tenant ON partida (tenant_id);   -- sempre indexar tenant_id
ALTER TABLE partida ENABLE ROW LEVEL SECURITY;

-- Cada sessão só enxerga as linhas do seu tenant, mesmo que a aplicação
-- esqueça o filtro.
CREATE POLICY tenant_isolation ON partida
  USING (tenant_id = current_setting('app.current_tenant_id')::uuid);

-- A aplicação define o tenant no início de cada sessão:
--   SET app.current_tenant_id = '00000000-0000-0000-0000-000000000001';
-- Regra da aula: a aplicação NÃO pode usar superuser (ele ignora o RLS).

-- ---- 5.5 Recomendação final --------------------------------------------
--   Agora          : índices e visões (Atividade 4), replicação física com
--                    1 réplica de leitura e particionamento RANGE por temporada
--   Análise pesada : replicação lógica para um banco analítico
--   Se virar SaaS  : multi-tenant híbrido com RLS
--   Crescimento extremo: sharding com Citus


-- =====================================================================
-- CHECKLIST ANTES DE APRESENTAR
-- =====================================================================
-- 1. Rodar tudo em banco de teste; os scripts não foram executados.
-- 2. Procurar órfãos antes de VALIDATE CONSTRAINT das FKs.
-- 3. Conferir as premissas:
--    a) historico é cópia de partida (deve retornar 0):
--       SELECT COUNT(*) FROM historico h JOIN partida p USING (gam_sequencia)
--       WHERE h.mandante_gols IS DISTINCT FROM p.mandante_gols
--          OR h.visitante_gols IS DISTINCT FROM p.visitante_gols;
--    b) subposicao determina posicao (sem linhas retornadas):
--       SELECT subposicao FROM jogador GROUP BY subposicao
--       HAVING COUNT(DISTINCT posicao) > 1;
--    c) conteúdo das colunas nacionalidade, naturalidade e cidadania.
-- 4. Prints para os slides: ERD original, ERD normalizado, EXPLAIN ANALYZE
--    antes e depois dos índices, consultas de auditoria.
-- 5. Se o professor exigir o modelo em PDF/Word, usem os diagramas do
--    pgAdmin e as tabelas do documento completo.
