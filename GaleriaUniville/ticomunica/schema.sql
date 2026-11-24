-- Galeria Univille (TiComunica) - banco de dados MySQL
-- Como executar:  mysql -u root -p < schema.sql
-- (ou abra este arquivo no MySQL Workbench e execute tudo)

CREATE DATABASE IF NOT EXISTS galeria_univille
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE galeria_univille;

-- ---------------------------------------------------------------
-- Artistas: dados do perfil + dados de acesso (e-mail e senha em hash)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS artistas (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  nome           VARCHAR(120) NOT NULL,
  email          VARCHAR(160) NOT NULL UNIQUE,   -- e-mail de login (não aparece no site)
  senha_hash     VARCHAR(255) NOT NULL,          -- nunca a senha em texto puro
  bio            TEXT NULL,
  vinculo        ENUM('estudante', 'ex-estudante') NULL,
  curso          VARCHAR(120) NULL,
  periodo        VARCHAR(20) NULL,
  foto           VARCHAR(255) NULL,              -- nome do arquivo em static/uploads/
  instagram_url  VARCHAR(500) NULL,              -- link livre (Instagram ou outro)
  contato_email  VARCHAR(160) NULL,              -- e-mail público de contato (opcional)
  contato        VARCHAR(160) NULL,              -- telefone ou texto livre (opcional)
  perfil_publico TINYINT(1) NOT NULL DEFAULT 1,  -- 1 = aparece para os visitantes
  criado_em      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------
-- Linguagens artísticas do artista (quantas quiser)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS artista_linguagens (
  artista_id INT NOT NULL,
  linguagem  ENUM('artes', 'cinema', 'escultura', 'fotografia', 'outros') NOT NULL,
  PRIMARY KEY (artista_id, linguagem),
  FOREIGN KEY (artista_id) REFERENCES artistas (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------
-- Obras publicadas
--   imagem = nome do arquivo em static/uploads/
--   molde  = formato da imagem na página (ex.: 'medio-retrato', 'banner')
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS obras (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  artista_id  INT NOT NULL,
  titulo      VARCHAR(160) NOT NULL,
  ano         SMALLINT NOT NULL,
  categoria   ENUM('artes', 'cinema', 'escultura', 'fotografia') NOT NULL,
  descricao   TEXT NOT NULL,
  imagem      VARCHAR(255) NOT NULL,
  molde       VARCHAR(30) NOT NULL DEFAULT 'pequeno-retrato',
  criado_em   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_obras_artista (artista_id),
  INDEX idx_obras_categoria (categoria),
  FOREIGN KEY (artista_id) REFERENCES artistas (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------
-- Detalhes que mudam conforme o tipo de arte (um registro por campo)
--   artes:      tecnica, dimensoes, serie
--   escultura:  material, dimensoes, tecnica
--   fotografia: local, equipamento, tecnica
--   cinema:     genero, duracao, equipe, video (link)
-- ---------------------------------------------------------------
CREATE TABLE IF NOT EXISTS obra_detalhes (
  obra_id INT NOT NULL,
  campo   VARCHAR(40) NOT NULL,
  valor   VARCHAR(500) NOT NULL,
  PRIMARY KEY (obra_id, campo),
  FOREIGN KEY (obra_id) REFERENCES obras (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
