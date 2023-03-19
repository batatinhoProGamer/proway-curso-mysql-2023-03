-- Consultar bancos de dados criados
SHOW SCHEMAS;

-- Apagar o banco de dados que foi criado 
DROP DATABASE IF EXISTS curso_mysql;

-- Criar o banco de dados que será utilizado no curso
CREATE DATABASE IF NOT EXISTS curso_mysql;

-- Definir o banco de dados que será executado as consultas(queries(query))
USE curso_mysql;

-- Consultar as tabelas do banco de dados utilizado
SHOW TABLES;

-- criar tabela para armazenar os registros dos alunos
-- VARCHAR(100) coluna com no máximo 100 caracteres 
-- NOT NULL coluna que é obrigatório informar valor
-- vai fazer o id começar com e depois incrementar em 1 cada registro
CREATE TABLE alunos(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL 
);

-- Consultar todos os registros da tabela de alunos
SELECT
    id,
    nome
    FROM alunos;

-- Criar registro na tabela de alunos
INSERT INTO alunos (nome) VALUE ("José");

-- Apagar todos os registros da tabela
REMOVE FROM alunos;

-- Descrição da tabela
DESCRIBE alunos;

-- Redefinir o AUTO_INCREMENT e apagar todos os registros da tabela
-- Não pode ter FK relacionado à essa tabela
TRUNCATE TABLE alunos;

-- Criar registro na tabela de alunos
INSERT INTO alunos (nome) VALUE ("José");
INSERT INTO alunos (nome) VALUE ("Luiz");
INSERT INTO alunos (nome) VALUE ("Bruno");
INSERT INTO alunos (nome) VALUE ("Lucas");
INSERT INTO alunos (nome) VALUE ("Jardel");
INSERT INTO alunos (nome) VALUE ("Zaquel");
INSERT INTO alunos (nome) VALUE ("João");

-- Apagar registro do João
DELETE FROM alunos WHERE nome = "João";
DELETE FROM alunos WHERE id = 7;

-- Contagem de quantos ids possui na tabela alunos
SELECT COUNT(id) FROM alunos;

CREATE TABLE professores(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    valor_hora FLOAT(5, 2) -- cinco números, sendo 2 na parte decimal
);

INSERT INTO professores (nome, valor_hora) VALUE("Francisco", 53.00);
INSERT INTO professores (nome, valor_hora) VALUE("Javeiro", 80.30);
INSERT INTO professores (nome, valor_hora) VALUE("Rubens", 75.00);
INSERT INTO professores (nome, valor_hora) VALUE("Pablo", 60.00);
INSERT INTO professores (nome, valor_hora) VALUE("Pamela", 100.00);

SELECT id, nome, valor_hora FROM professores;

CREATE TABLE cursos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    carga_horaria INT -- cinco números, sendo 2 na parte decimal
);

INSERT INTO cursos (nome, carga_horaria) VALUE("MySQL", 28);
INSERT INTO cursos (nome, carga_horaria) VALUE("C#", 40);
INSERT INTO cursos (nome, carga_horaria) VALUE("Python", 39);
INSERT INTO cursos (nome, carga_horaria) VALUE("Java", 41);
INSERT INTO cursos (nome, carga_horaria) VALUE("HTML, CSS", 32);
INSERT INTO cursos (nome, carga_horaria) VALUE("React", 52);

SELECT id, nome, carga_horaria FROM cursos;

-- Consultar registros de cursos ordenados em ordem crescente(ASC) da coluna nome
SELECT id, nome, carga_horaria FROM cursos ORDER BY nome ASC;

-- Consultar registros de cursos ordenados em ordem crescente(DESC) da coluna nome
SELECT id, nome, carga_horaria FROM cursos ORDER BY nome DESC;

-- Ordenando pela carga horaria em ordem crescente, sendo como >= 40
SELECT id, nome, carga_horaria FROM cursos WHERE carga_horaria >= 40 ORDER BY carga_horaria ASC;

-- Operadores relacionais 
-- igual  =
-- diferente !=  <>
-- menor  <
-- menor ou igual  <=
-- maior  >
-- maior ou igual  >=

SELECT MIN(carga_horaria) FROM cursos;
SELECT MAX(carga_horaria) FROM cursos;
SELECT SUM(carga_horaria) FROM cursos;
SELECT COUNT(id) FROM cursos;

-- Saber média
SELECT SUM(carga_horaria) / COUNT(id) FROM cursos;
SELECT AVG(carga_horaria) FROM cursos;

SELECT AVG(carga_horaria) AS "Média de carga horária dos cursos > 40h" FROM cursos WHERE carga_horaria > 40;

SELECT LENGTH(nome), nome FROM cursos;

-- Adicionar coluna em tabela existente
ALTER TABLE alunos ADD COLUMN data_nascimento DATE;

UPDATE alunos SET data_nascimento = "2000-06-28";

SELECT id, nome, data_nascimento FROM alunos;

UPDATE alunos SET data_nascimento = "2000-06-28" WHERE id = 1;
UPDATE alunos SET data_nascimento = "2004-10-27" WHERE id = 2;
UPDATE alunos SET data_nascimento = "1981-10-18" WHERE id = 3;
UPDATE alunos SET data_nascimento = "2000-01-01" WHERE id = 4;
UPDATE alunos SET data_nascimento = "1996-07-27" WHERE id = 5;
UPDATE alunos SET data_nascimento = "2000-01-02" WHERE id = 6;

SELECT DATE_FORMAT(data_nascimento, "%d/%m/%Y") AS "Data de nascimento" FROM alunos;
SELECT YEAR(data_nascimento) FROM alunos;
SELECT CONCAT(nome, " ", data_nascimento) FROM alunos;

SELECT nome, data_nascimento FROM alunos WHERE YEAR(data_nascimento) >= 2000 ORDER BY YEAR(data_nascimento) ASC, MONTH(data_nascimento) ASC, DAY(data_nascimento) ASC;

SELECT id, nome, data_nascimento FROM alunos WHERE YEAR(data_nascimento) >= 1990 AND YEAR(data_nascimento) <= 1999;

SELECT id, nome FROM cursos WHERE nome IN ("Java", "C#", "Python");

SELECT id, nome, carga_horaria FROM cursos WHERE carga_horaria BETWEEN 40 AND 45;

SELECT id, nome, carga_horaria FROM cursos WHERE carga_horaria NOT IN ("C#", "Python", "Java");