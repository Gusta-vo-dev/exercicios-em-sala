CREATE TABLE "competicao" (
  "cmp_sequencia" char(5) PRIMARY KEY,
  "nome" varchar(200),
  "subtipo" varchar(200),
  "tipo" varchar(200),
  "pais_sequencia" integer,
  "cmp_sequencia_domestica" char(5),
  "competicao_principal" integer
);

CREATE TABLE "pais" (
  "pais_sequencia" integer PRIMARY KEY,
  "nome" varchar(200)
);

CREATE TABLE "clube" (
  "clb_sequencia" integer PRIMARY KEY,
  "nome" varchar(200),
  "cmp_sequencia_domestica" char(5),
  "numero_jogadores" integer,
  "media_idade" decimal(18,8),
  "numero_estrangeiros" integer,
  "jogadores_selecao" integer,
  "est_sequencia" integer,
  "ultima_temporada" integer
);

CREATE TABLE "estadio" (
  "est_sequencia" integer PRIMARY KEY,
  "nome" varchar(200),
  "assentos" integer
);

CREATE TABLE "jogador" (
  "jog_sequencia" integer PRIMARY KEY,
  "primeiro_nome" varchar(200),
  "sobrenome" varchar(200),
  "nome" varchar(200),
  "ultima_temporada" integer,
  "clb_sequencia_atual" integer,
  "nacionalidade" varchar(200),
  "naturalidade" varchar(200),
  "cidadania" varchar(200),
  "nascimento" timestamp,
  "subposicao" varchar(200),
  "posicao" varchar(200),
  "dominante" varchar(200),
  "altura" decimal(18,8),
  "cmp_sequencia_atual" char(5),
  "valor_mercado" decimal(18,8),
  "maior_valor_mercado" decimal(18,8)
);

CREATE TABLE "partida" (
  "gam_sequencia" integer PRIMARY KEY,
  "cmp_sequencia" char(5),
  "temporada" integer,
  "rodada" varchar(200),
  "data" timestamp,
  "mandante_clb_sequencia" integer,
  "visitante_clb_sequencia" integer,
  "mandante_gols" integer,
  "visitante_gols" integer,
  "mandante_posicao" integer,
  "visitante_posicao" integer,
  "mandante_tecnico" varchar(200),
  "visitante_tecnico" varchar(200),
  "est_sequencia" "FK",
  "publico" decimal(18,8),
  "arbitro" varchar(200),
  "mandante_formacao" varchar(200),
  "visitante_formacao" varchar(200),
  "agregado" varchar(200)
);

CREATE TABLE "historico" (
  "gam_sequencia" integer,
  "mandante_clb_sequencia" integer,
  "mandante_gols" integer,
  "mandante_position" decimal(18,8),
  "mandante_tecnico" varchar(200),
  "visitante_clb_sequencia" integer,
  "visitante_gols" integer,
  "visitante_position" decimal(18,8),
  "visitante_tecnico" varchar(200),
  "tipo" varchar(200),
  "vitoria" integer,
  PRIMARY KEY ("gam_sequencia", "mandante_clb_sequencia")
);

CREATE TABLE "mercado" (
  "jog_sequencia" integer,
  "data" timestamp,
  "valor_mercado" integer,
  "clb_sequencia" integer,
  "cmp_sequencia" char(5),
  PRIMARY KEY ("jog_sequencia", "data")
);

CREATE TABLE "ocorrencia" (
  "data" timestamp,
  "gam_sequencia" integer,
  "minuto" integer,
  "tipo" varchar(200),
  "clb_sequencia" integer,
  "jog_sequencia" integer,
  "descricao" varchar(200),
  "jog_sequencia_entrada" integer,
  "jog_sequencia_assistencia" integer
);

CREATE TABLE "participacao" (
  "gam_sequencia" integer,
  "jog_sequencia" integer,
  "clb_sequencia" integer,
  "cartao_amarelo" integer,
  "cartao_vermelho" integer,
  "gols" integer,
  "assistencia" integer,
  "minuto_em_campo" integer,
  PRIMARY KEY ("gam_sequencia", "jog_sequencia")
);

CREATE TABLE "escalacao" (
  "gam_sequencia" integer,
  "jog_sequencia" integer,
  "clb_sequencia" integer,
  "tipo" varchar(200),
  "posicao" varchar(200),
  "numero" varchar(200),
  "capitao" integer,
  PRIMARY KEY ("gam_sequencia", "jog_sequencia")
);

ALTER TABLE "competicao" ADD FOREIGN KEY ("cmp_sequencia_domestica") REFERENCES "competicao" ("cmp_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "competicao" ADD FOREIGN KEY ("pais_sequencia") REFERENCES "pais" ("pais_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clube" ADD FOREIGN KEY ("cmp_sequencia_domestica") REFERENCES "competicao" ("cmp_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clube" ADD FOREIGN KEY ("est_sequencia") REFERENCES "estadio" ("est_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "partida" ADD FOREIGN KEY ("est_sequencia") REFERENCES "estadio" ("est_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "jogador" ADD FOREIGN KEY ("clb_sequencia_atual") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "jogador" ADD FOREIGN KEY ("cmp_sequencia_atual") REFERENCES "competicao" ("cmp_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "partida" ADD FOREIGN KEY ("cmp_sequencia") REFERENCES "competicao" ("cmp_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "partida" ADD FOREIGN KEY ("mandante_clb_sequencia") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "partida" ADD FOREIGN KEY ("visitante_clb_sequencia") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "historico" ADD FOREIGN KEY ("gam_sequencia") REFERENCES "partida" ("gam_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "historico" ADD FOREIGN KEY ("mandante_clb_sequencia") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "historico" ADD FOREIGN KEY ("visitante_clb_sequencia") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "mercado" ADD FOREIGN KEY ("jog_sequencia") REFERENCES "jogador" ("jog_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "mercado" ADD FOREIGN KEY ("clb_sequencia") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "mercado" ADD FOREIGN KEY ("cmp_sequencia") REFERENCES "competicao" ("cmp_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "ocorrencia" ADD FOREIGN KEY ("gam_sequencia") REFERENCES "partida" ("gam_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "ocorrencia" ADD FOREIGN KEY ("clb_sequencia") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "ocorrencia" ADD FOREIGN KEY ("jog_sequencia") REFERENCES "jogador" ("jog_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "ocorrencia" ADD FOREIGN KEY ("jog_sequencia_entrada") REFERENCES "jogador" ("jog_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "ocorrencia" ADD FOREIGN KEY ("jog_sequencia_assistencia") REFERENCES "jogador" ("jog_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "participacao" ADD FOREIGN KEY ("gam_sequencia") REFERENCES "partida" ("gam_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "participacao" ADD FOREIGN KEY ("jog_sequencia") REFERENCES "jogador" ("jog_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "participacao" ADD FOREIGN KEY ("clb_sequencia") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "escalacao" ADD FOREIGN KEY ("gam_sequencia") REFERENCES "partida" ("gam_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "escalacao" ADD FOREIGN KEY ("jog_sequencia") REFERENCES "jogador" ("jog_sequencia") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "escalacao" ADD FOREIGN KEY ("clb_sequencia") REFERENCES "clube" ("clb_sequencia") DEFERRABLE INITIALLY IMMEDIATE;
