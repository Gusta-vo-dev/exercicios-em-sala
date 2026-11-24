-- Acelera listagem de jogos por competição e temporada já ordenados por data
CREATE INDEX idx_partida_comp_temp_data 
ON partida (cmp_sequencia, temporada, data DESC);

-- Acelera a consulta da evolução ou do último valor de mercado de um jogador
CREATE INDEX idx_mercado_jogador_data 
ON mercado (jog_sequencia, data DESC);

-- Índice parcial: indexa apenas registros onde o jogador foi capitão
CREATE INDEX idx_escalacao_capitao 
ON escalacao (clb_sequencia, gam_sequencia) 
WHERE capitao = 1;