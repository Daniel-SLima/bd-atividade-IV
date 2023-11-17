CREATE DATABASE controle_estoque;
USE controle_estoque;

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255),
    preco_unitario DECIMAL(10, 2),
    categoria VARCHAR(255)
);

INSERT INTO produtos (id_produto, nome, preco_unitario, categoria) VALUES
(1, 'Notebook', 1500.00, 'Eletrônicos'),
(2, 'Smartphone', 800.00, 'Eletrônicos'),
(3, 'Livro', 30.00, 'Cultura');

CREATE TABLE estoque (
    id_produto INT PRIMARY KEY,
    quantidade INT,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO estoque (id_produto, quantidade) VALUES
(1, 10),
(2, 5),
(3, 2);

DELIMITER //
CREATE VIEW estoque_critico AS
SELECT
    p.nome AS nome_produto,
    e.quantidade AS quantidade_em_estoque
FROM
    produtos p
JOIN
    estoque e ON p.id_produto = e.id_produto
WHERE
    e.quantidade < 5; -- Limite estabelecido pela empresa
//
DELIMITER ;

-- Verificar os dados das tabelas "produtos" e "estoque" após as inserções
SELECT * FROM produtos;
SELECT * FROM estoque;

-- Verificar os dados da view "estoque_critico"
SELECT * FROM estoque_critico;
