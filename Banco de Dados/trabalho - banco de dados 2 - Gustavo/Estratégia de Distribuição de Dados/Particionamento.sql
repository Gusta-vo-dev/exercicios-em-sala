-- Exemplo de particionamento anual na tabela ocorrencia (PostgreSQL)
CREATE TABLE ocorrencia (
    data timestamp NOT NULL,
    gam_sequencia integer NOT NULL,
    minuto integer,
    tipo varchar(200),
    clb_sequencia integer,
    jog_sequencia integer,
    descricao varchar(200),
    jog_sequencia_entrada integer,
    jog_sequencia_assistencia integer
) PARTITION BY RANGE (data);

CREATE TABLE ocorrencia_2025 PARTITION OF ocorrencia
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE ocorrencia_2026 PARTITION OF ocorrencia
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');