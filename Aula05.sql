DROP DATABASE IF EXISTS Financeiro;
CREATE DATABASE Financeiro;
USE Financeiro;

CREATE TABLE contas (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    valor DECIMAL(6, 2),
    status TINYINT
); 

INSERT INTO contas (nome, valor, status) VALUES
("Luz", 240, 0);

SHOW SCHEMAS;

INSERT INTO contas (nome, valor, status) VALUES
("Youtube Premium", 36, 1);

SELECT * FROM financeiro.contas;

UPDATE contas SET valor = 40 WHERE id = 2;

CREATE TABLE entradas_saidas (
	id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100),
    nome VARCHAR(100),
    valor DECIMAL(6, 2),
    registro_ativo BIT
);

ALTER TABLE entradas_saidas ADD COLUMN data DATE AFTER valor;

INSERT INTO entradas_saidas (tipo, nome, valor) VALUES
("Salário Google", "pagamento", 1000 * 5.60);

UPDATE entradas_saidas SET data = "2023-05-01" WHERE id = 1;
SELECT * FROM entradas_saidas es;

INSERT INTO entradas_saidas (nome, tipo, valor, data) VALUES
("Salário de Professor C#", "pagamento", 5000, "2023-05-01"),
("Investimentos cripto", "pagamento", 2500.2, "2023-05-01"),
("Investimentos cripto", "pagamento", 2600.2, "2023-06-01");

UPDATE entradas_saidas SET registro_ativo = 0 WHERE id = 4;

-- Auditoria
ALTER TABLE entradas_saidas ADD COLUMN created_by VARCHAR(100);
ALTER TABLE entradas_saidas ADD COLUMN created_at DATETIME DEFAULT NOW();
ALTER TABLE entradas_saidas ADD COLUMN updated_by VARCHAR(100);
ALTER TABLE entradas_saidas ADD COLUMN updated_at DATETIME DEFAULT NOW();
ALTER TABLE entradas_saidas ADD COLUMN deleted_by VARCHAR(100);
ALTER TABLE entradas_saidas ADD COLUMN deleted_at DATETIME DEFAULT NOW();
ALTER TABLE entradas_saidas ALTER COLUMN registro_ativo SET DEFAULT 1;

UPDATE entradas_saidas SET registro_ativo = 1 WHERE registro_ativo IS NULL;

DESCRIBE entradas_saidas;

ALTER TABLE contas DROP COLUMN status;
ALTER TABLE contas DROP COLUMN valor;
TRUNCATE TABLE contas;
ALTER TABLE contas ADD COLUMN saldo DECIMAL(10, 2) NOT NULL;

DESCRIBE contas;


DROP PROCEDURE IF EXISTS CriarContaBancaria;
DELIMITER $
CREATE PROCEDURE CriarContaBancaria(nome VARCHAR(30), investimento_inicial DECIMAL(10, 2))
BEGIN
	INSERT INTO contas (nome, saldo) VALUES (nome, investimento_inicial);
END $
DELIMITER ;

TRUNCATE contas;
CALL CriarContaBancaria("Wise", 2000);
CALL CriarContaBancaria("Viacredi", 21947.33);

TRUNCATE entradas_saidas;
ALTER TABLE entradas_saidas ADD COLUMN id_conta INT;
ALTER TABLE entradas_saidas ADD FOREIGN KEY(id_conta) REFERENCES contas(id);

DELIMITER $
DROP PROCEDURE IF EXISTS AtualizarSaldo $
CREATE PROCEDURE AtualizarSaldo (nome_conta VARCHAR(30), valor DECIMAL(10, 2), modo INT)
BEGIN
	-- Depositar 8001
	-- Sacar     8000
	DECLARE conta_id INT;
	SELECT id INTO conta_id FROM contas WHERE nome = nome_conta;
	
	IF modo = 8001 THEN
		UPDATE contas SET saldo = saldo + valor WHERE id = conta_id;
	ELSEIF modo = 8000 THEN
		UPDATE contas SET saldo = saldo - valor WHERE id = conta_id;
	END IF;
END $

DROP PROCEDURE IF EXISTS Depositar $
CREATE PROCEDURE Depositar(nome_conta VARCHAR(30), valor DECIMAL(10, 2))
BEGIN
	CALL AtualizarSaldo(nome_conta, valor, 8001);
END $

DROP PROCEDURE IF EXISTS Sacar $
CREATE PROCEDURE Sacar(nome_conta VARCHAR(30), valor DECIMAL(10, 2))
BEGIN
	CALL AtualizarSaldo(nome_conta, valor, 8000);
END $

DROP PROCEDURE IF EXISTS RegistrarEntrada $
CREATE PROCEDURE RegistrarEntrada(nome_conta VARCHAR(100), nome_entrada VARCHAR(200), tipo VARCHAR(100), valor DECIMAL(6, 2), data DATE)
BEGIN
	DECLARE conta_id INT;
	

	INSERT INTO entradas_saidas (id_conta, tipo, nome, valor, data) VALUES
	(conta_id, tipo, nome_entrada, valor, data);
	CALL Depositar(nome_conta, valor);
END $

DROP FUNCTION IF EXISTS ConsultarContaPorNome $
CREATE FUNCTION ConsultarContaPorNome (nome_conta VARCHAR(100))
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE conta_id INT;
	SELECT id INTO conta_id FROM contas WHERE nome = nome_conta;
	RETURN conta_id;
END $
DELIMITER ;


-- CALL RegistrarEntrada("Wise", "Pagamento da Google", "Pagamento", 1500.90, "2023-05-10");
SELECT * FROM contas;

SELECT ConsultarContaPorNome("Wise");

















