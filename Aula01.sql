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

SELECT * FROM cursos LIMIT 2;
-- +----+-------+---------------+
-- | id | nome  | carga_horaria |
-- +----+-------+---------------+
-- |  1 | MySQL |            28 |
-- |  2 | C#    |            40 |
-- +----+-------+---------------+

SELECT * FROM cursos LIMIT 1, 2;
-- +----+--------+---------------+
-- | id | nome   | carga_horaria |
-- +----+--------+---------------+
-- |  2 | C#     |            40 |
-- |  3 | Python |            39 |
-- +----+--------+---------------+

SELECT * FROM cursos LIMIT 4, 2;
-- +----+-----------+---------------+
-- | id | nome      | carga_horaria |
-- +----+-----------+---------------+
-- |  5 | HTML, CSS |            32 |
-- |  6 | React     |            52 |
-- +----+-----------+---------------+

-- Como se fosse um if
SELECT nome, CASE WHEN YEAR(data_nascimento) BETWEEN 1980 and 1994 THEN "Geração Y"
    WHEN YEAR(data_nascimento) BETWEEN 1995 and 2009 THEN "Geração Z"
    WHEN YEAR(data_nascimento) BETWEEN 2010 and 2023 THEN "Geração Alpha" ELSE "Geração X" END AS "Geração" From alunos;

-- https://miro.com/app/board/uXjVMeHZLE0=/?share_link_id=821951056661

CREATE TABLE turmas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_curso INT NOT NULL,
    id_professor INT NOT NULL,

    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL,

    FOREIGN KEY(id_curso) REFERENCES cursos(id),
    FOREIGN KEY(id_professor) REFERENCES professores(id)
);

INSERT INTO turmas(id_curso, id_professor, data_inicio, data_termino) VALUES
(1, 1, "2023-03-12", "2023-04-23"),
(1,	1, "2023-03-12", "2023-04-16"),
(2,	1, "2023-05-01", "2023-07-10"),
(3,	2, "2024-01-01", "2024-02-10"),
(4,	2, "2022-01-01", "2022-12-31"),
(5,	3, "2023-04-01", "2023-04-10"),
(6,	4, "2024-01-10", "2024-02-10"),
(5,	5, "2023-05-11", "2023-05-20"),
(5,	3, "2023-08-01", "2023-08-20");


SELECT 
    t.id,
    p.nome,
    t.data_inicio
    FROM turmas AS t
    INNER JOIN professores AS p ON (p.id = t.id_professor);

SELECT 
    cursos.nome AS "Curso",
    turmas.data_inicio AS "Data de inicio",
    turmas.data_termino AS "Data de término"
    FROM turmas
    INNER JOIN cursos ON (cursos.id = turmas.id_curso);

SELECT
    LOWER(professores.nome) AS "Professor",
    UPPER(cursos.nome) AS "Curso",
    turmas.data_inicio AS "Data inicio",
    turmas.data_termino AS "Data término"
    FROM turmas
    INNER JOIN professores ON(professores.id = turmas.id_professor)
    INNER JOIN cursos on(cursos.id = turmas.id_curso);

SELECT
    CONCAT(
        professores.nome, " => ",
        cursos.nome, "(",
        cursos.carga_horaria, ")"
    ) AS "Turmas"
    FROM professores
    INNER JOIN turmas ON (professores.id = turmas.id_professor)
    INNER JOIN cursos ON (cursos.id = turmas.id_curso);

SELECT
    CONCAT(
        professores.nome, SPACE(30 - LENGTH(professores.nome)), " => ",
        cursos.nome, SPACE(30 - LENGTH(cursos.nome)), "(",
        cursos.carga_horaria, ")"
    ) AS "Turmas"
    FROM professores
    INNER JOIN turmas ON (professores.id = turmas.id_professor)
    INNER JOIN cursos ON (cursos.id = turmas.id_curso);

SELECT SUBSTRING(nome, 1, 2) FROM cursos;

CREATE TABLE mercadorias(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL
);

INSERT INTO mercadorias (nome) VALUES
("   Nescau   "),
("Nescau"),
("Nescau  "),
("Nescau cereal"),
("O nescau de todo dia"),
("Nescal com L"),
("Uma mercadoria que termina com nescau");

SELECT * FROM mercadorias WHERE nome LIKE "Nescau%";

SELECT * FROM mercadorias WHERE nome LIKE "%Nescau";

SELECT * FROM mercadorias WHERE nome LIKE "%Nescau%";

SELECT COUNT(*) FROM mercadorias WHERE nome LIKE "%Nescau%";

SELECT REPLACE(nome, "Nescal", "Nescau") FROM mercadorias;

SELECT LTRIM(nome), LENGTH(LTRIM(nome)) FROM mercadorias;

SELECT RTRIM(nome), LENGTH(RTRIM(nome)) FROM mercadorias;

SELECT TRIM(nome), LENGTH(TRIM(nome)) FROM mercadorias;

ALTER TABLE mercadorias ADD COLUMN data_vencimento DATE;

ALTER TABLE mercadorias DROP COLUMN data_vencimento;

SHOW CREATE TABLE mercadorias;

ALTER TABLE mercadorias ADD COLUMN data_vencimento DATE;
ALTER TABLE mercadorias ADD COLUMN estoque INT FIRST;
ALTER TABLE mercadorias ADD COLUMN valor_unitario FLOAT(5, 2) AFTER nome;

ALTER TABLE mercadorias ALTER data_vencimento SET DEFAULT "2023-04-05";

-- TODO
-- ALTER TABLE mercadorias ALTER data_vencimento SET DEFAULT DATE(DATE_ADD(NOW(), INTERVAL 10 DAY));

UPDATE mercadorias SET data_vencimento = DATE(DATE_ADD(NOW(), INTERVAL 10 DAY));

INSERT INTO mercadorias (nome, estoque, valor_unitario) VALUE ("Toddy", 3, 13.50);

ALTER TABLE mercadorias ALTER data_vencimento DROP DEFAULT;

INSERT INTO mercadorias (nome, estoque, valor_unitario, data_vencimento) VALUE("Todinho", 1, 5.00, "2024-01-01");

ALTER TABLE mercadorias MODIFY nome VARCHAR(75);

ALTER TABLE mercadorias CHANGE valor_unitario preco_unitario FLOAT(5, 2);