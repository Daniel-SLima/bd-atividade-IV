CREATE DATABASE gerenciamento_pedidos;
USE gerenciamento_pedidos;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
    telefone VARCHAR(20)
);

INSERT INTO clientes (id_cliente, nome, email, telefone) VALUES
(1, 'João Silva', 'joao.silva@example.com', '123456789'),
(2, 'Maria Oliveira', 'maria.oliveira@example.com', '987654321'),
(3, 'Carlos Santos', 'carlos.santos@example.com', '111223344');

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO pedidos (id_pedido, id_cliente, data_pedido, valor_total) VALUES
(1, 1, '2023-11-17', 100.50),
(2, 2, '2023-11-18', 75.20),
(3, 1, '2023-11-19', 150.75);

DELIMITER //
CREATE VIEW relatorio_pedidos_cliente AS
SELECT
    c.nome AS nome_cliente,
    COUNT(p.id_pedido) AS num_pedidos,
    SUM(p.valor_total) AS total_gasto
FROM
    clientes c
JOIN
    pedidos p ON c.id_cliente = p.id_cliente
GROUP BY
    c.id_cliente;
//
DELIMITER ;


SELECT * FROM clientes;
SELECT * FROM pedidos;


SELECT * FROM relatorio_pedidos_cliente;
