-- Acelera busca de eventos específicos por partida (ex: gols, cartões, substituições)
CREATE INDEX idx_ocorrencia_jogo_tipo 
ON ocorrencia (gam_sequencia, tipo);

-- Acelera o histórico de atuações de um jogador por clube
CREATE INDEX idx_participacao_jogador_clube 
ON participacao (jog_sequencia, clb_sequencia);

-- Acelera a montagem da escalação de um clube em uma partida específica
CREATE INDEX idx_escalacao_jogo_clube 
ON escalacao (gam_sequencia, clb_sequencia);