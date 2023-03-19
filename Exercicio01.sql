-- Enunciado: Criar tabela de estoques
-- id: INT
-- produto: VARCHAR(50)
-- quantidade: INT
-- preco_unitario: FLOAT(6, 2)
-- data_vencimento: DATE
-- categoria: VARCHAR(30)

-- Inserir 7 registros
-- 2 registros de frutas
-- 2 registros de lanches
-- 2 registros de bebidas
-- 1 registro de produtos de limpeza

-- Sem *
-- Consultar todas as colunas de registro
-- Consultar o menor preço
-- Consultar a maior quantidade
-- Consultar nome, quantidade, preço unitário e valor dos produtos
-- Consultar soma total dos valores dos produtos (qunatidade multiplicando preço unitário)
-- Consultar os produtos da categoria bebidas ordenando pela menor quantidade
-- Consultar os produtos da categoria frutas e preço unitário maior que 10,00

CREATE DATABASE exercicio1;
USE exercicio1;

CREATE TABLE estoque(
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(50) NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario FLOAT(6, 2),
    data_vencimento DATE NOT NULL,
    categoria VARCHAR(30)
)

INSERT INTO estoque (produto, quantidade, preco_unitario, data_vencimento, categoria) VALUE ("Maçã", 2, 1.50, "2023-03-26", "Fruta");
INSERT INTO estoque (produto, quantidade, preco_unitario, data_vencimento, categoria) VALUE ("Banana", 1, 1.00, "2023-03-24", "Fruta");
INSERT INTO estoque (produto, quantidade, preco_unitario, data_vencimento, categoria) VALUE ("Doritos", 1, 7.00, "2023-11-17", "Lanche");
INSERT INTO estoque (produto, quantidade, preco_unitario, data_vencimento, categoria) VALUE ("Cebolitos", 1, 6.50, "2023-08-09", "Lanche");
INSERT INTO estoque (produto, quantidade, preco_unitario, data_vencimento, categoria) VALUE ("Laranjinha", 3, 5.00, "2024-01-05", "Bebida");
INSERT INTO estoque (produto, quantidade, preco_unitario, data_vencimento, categoria) VALUE ("Água", 10, 2.50, "2024-05-15", "Bebida");
INSERT INTO estoque (produto, quantidade, preco_unitario, data_vencimento, categoria) VALUE ("Vanish", 0, 6.00, "2025-04-06", "Produto de limpeza");

SELECT id, produto, quantidade, preco_unitario, data_vencimento, categoria FROM estoque;

SELECT MIN(preco_unitario) FROM estoque;

SELECT MAX(quantidade) FROM estoque;

SELECT produto, quantidade, preco_unitario FROM estoque;

SELECT SUM(quantidade * preco_unitario) FROM estoque;

SELECT id, produto, quantidade, preco_unitario, data_vencimento, categoria FROM estoque WHERE categoria = "bebida" ORDER BY quantidade ASC;

SELECT id, produto, quantidade, preco_unitario, data_vencimento, categoria FROM estoque WHERE categoria = "fruta" AND preco_unitario > 10;