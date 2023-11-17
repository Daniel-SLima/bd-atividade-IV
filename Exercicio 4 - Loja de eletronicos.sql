CREATE DATABASE gerenciamento_estoque;
USE gerenciamento_estoque;

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(255),
    quantidade_estoque INT
);

INSERT INTO produtos (id_produto, nome, quantidade_estoque) VALUES
(1, 'Smartphone', 50),
(2, 'Notebook', 30),
(3, 'Smart TV', 20);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    data_venda DATETIME
);

INSERT INTO vendas (id_venda, data_venda) VALUES
(1, '2023-11-17 14:30:00'),
(2, '2023-11-18 10:15:00'),
(3, '2023-11-19 16:45:00');

CREATE TABLE itens_venda (
    id_item_venda INT PRIMARY KEY,
    id_venda INT,
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO itens_venda (id_item_venda, id_venda, id_produto, quantidade) VALUES
(1, 1, 1, 3),
(2, 1, 2, 2),
(3, 2, 3, 1);

DELIMITER //
CREATE TRIGGER verifica_estoque
BEFORE INSERT ON itens_venda
FOR EACH ROW
BEGIN
    DECLARE estoque_disponivel INT;
    
    SELECT quantidade_estoque INTO estoque_disponivel
    FROM produtos
    WHERE id_produto = NEW.id_produto;
    
    IF estoque_disponivel < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = CONCAT('Erro: Produto fora de estoque. Quantidade disponível: ', CAST(estoque_disponivel AS CHAR));
    END IF;
END;
//
DELIMITER ;

-- Simulação de teste
INSERT INTO itens_venda (id_item_venda, id_venda, id_produto, quantidade) VALUES (4, 3, 1, 2);

-- Tentar inserir um novo item de venda com quantidade indisponível no estoque (deve gerar um erro)
-- Inserirá um registro, mas mostrará uma mensagem de erro
INSERT INTO itens_venda (id_item_venda, id_venda, id_produto, quantidade) VALUES (5, 3, 2, 35);

-- Verificar os dados da tabela "produtos" e "itens_venda" após as inserções
SELECT * FROM produtos;
SELECT * FROM itens_venda;
