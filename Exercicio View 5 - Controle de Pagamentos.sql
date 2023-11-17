CREATE DATABASE controle_pagamentos;
USE controle_pagamentos;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255)
);

INSERT INTO clientes (id_cliente, nome, endereco, cidade) VALUES
(1, 'João Silva', 'Rua A, 123', 'São Paulo'),
(2, 'Maria Oliveira', 'Av. B, 456', 'Rio de Janeiro'),
(3, 'Carlos Santos', 'Praça C, 789', 'São Paulo');

CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY,
    id_cliente INT,
    data_pagamento DATE,
    valor_pagamento DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO pagamentos (id_pagamento, id_cliente, data_pagamento, valor_pagamento) VALUES
(1, 1, '2023-11-17', 50.00),
(2, 2, '2023-11-18', 75.20),
(3, 1, '2023-11-19', 30.50);

DELIMITER //
CREATE VIEW relatorio_pagamentos_cidade AS
SELECT
    c.cidade AS nome_cidade,
    SUM(p.valor_pagamento) AS valor_total_pagamentos
FROM
    clientes c
LEFT JOIN
    pagamentos p ON c.id_cliente = p.id_cliente
GROUP BY
    c.cidade;
//
DELIMITER ;

SELECT * FROM clientes;
SELECT * FROM pagamentos;

SELECT * FROM relatorio_pagamentos_cidade;
