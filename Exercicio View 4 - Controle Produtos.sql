CREATE DATABASE controle_produtos;
USE controle_produtos;

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nome_categoria VARCHAR(255),
    descricao VARCHAR(255)
);

INSERT INTO categorias (id_categoria, nome_categoria, descricao) VALUES
(1, 'Eletrônicos', 'Produtos eletrônicos para casa'),
(2, 'Roupas', 'Vestuário masculino e feminino'),
(3, 'Livros', 'Diversos títulos para leitura');

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255),
    preco_unitario DECIMAL(10, 2),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

INSERT INTO produtos (id_produto, nome, preco_unitario, id_categoria) VALUES
(1, 'Smartphone', 800.00, 1),
(2, 'Notebook', 1500.00, 1),
(3, 'Camiseta', 25.00, 2);

DELIMITER //
CREATE VIEW relatorio_produtos_categoria AS
SELECT
    c.nome_categoria AS nome_categoria,
    COUNT(p.id_produto) AS quantidade_produtos
FROM
    categorias c
LEFT JOIN
    produtos p ON c.id_categoria = p.id_categoria
GROUP BY
    c.id_categoria;
//
DELIMITER ;

SELECT * FROM categorias;
SELECT * FROM produtos;

SELECT * FROM relatorio_produtos_categoria;
