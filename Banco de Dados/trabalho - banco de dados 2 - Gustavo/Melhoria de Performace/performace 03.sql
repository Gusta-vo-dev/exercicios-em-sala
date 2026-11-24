-- Pré-calcula estatísticas consolidadas de jogadores por competição e temporada
CREATE MATERIALIZED VIEW mv_estatisticas_jogador_temporada AS
SELECT 
    p.cmp_sequencia,
    p.temporada,
    pa.jog_sequencia,
    j.nome AS nome_jogador,
    pa.clb_sequencia,
    c.nome AS nome_clube,
    COUNT(pa.gam_sequencia) AS total_jogos,
    SUM(pa.gols) AS total_gols,
    SUM(pa.assistencia) AS total_assistencias,
    SUM(pa.cartao_amarelo) AS total_amarelos,
    SUM(pa.cartao_vermelho) AS total_vermelhos,
    SUM(pa.minuto_em_campo) AS total_minutos
FROM participacao pa
JOIN partida p ON pa.gam_sequencia = p.gam_sequencia
JOIN jogador j ON pa.jog_sequencia = j.jog_sequencia
JOIN clube c ON pa.clb_sequencia = c.clb_sequencia
GROUP BY 
    p.cmp_sequencia, p.temporada, pa.jog_sequencia, 
    j.nome, pa.clb_sequencia, c.nome;

-- Índice único na visão (obrigatório para permitir atualização sem travar leituras)
CREATE UNIQUE INDEX idx_mv_est_jog_temp_pk 
ON mv_estatisticas_jogador_temporada (cmp_sequencia, temporada, jog_sequencia, clb_sequencia);

-- Índice secundário para buscar rapidamente os artilheiros de uma temporada
CREATE INDEX idx_mv_est_artilharia 
ON mv_estatisticas_jogador_temporada (cmp_sequencia, temporada, total_gols DESC);