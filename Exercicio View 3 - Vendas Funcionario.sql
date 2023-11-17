CREATE DATABASE controle_vendas;
USE controle_vendas;

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(255),
    cargo VARCHAR(255),
    salario DECIMAL(10, 2)
);

INSERT INTO funcionarios (id_funcionario, nome, cargo, salario) VALUES
(1, 'João Silva', 'Vendedor', 3000.00),
(2, 'Maria Oliveira', 'Gerente', 5000.00),
(3, 'Carlos Santos', 'Vendedor', 3500.00);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_funcionario INT,
    data_venda DATE,
    valor_venda DECIMAL(10, 2),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

INSERT INTO vendas (id_venda, id_funcionario, data_venda, valor_venda) VALUES
(1, 1, '2023-11-17', 1500.00),
(2, 2, '2023-11-18', 2000.00),
(3, 1, '2023-11-19', 1200.00);

DELIMITER //
CREATE VIEW relatorio_vendas_funcionario AS
SELECT
    f.nome AS nome_funcionario,
    COUNT(v.id_venda) AS num_vendas,
    SUM(v.valor_venda) AS total_vendas
FROM
    funcionarios f
JOIN
    vendas v ON f.id_funcionario = v.id_funcionario
GROUP BY
    f.id_funcionario;
//
DELIMITER ;


SELECT * FROM funcionarios;
SELECT * FROM vendas;


SELECT * FROM relatorio_vendas_funcionario;
