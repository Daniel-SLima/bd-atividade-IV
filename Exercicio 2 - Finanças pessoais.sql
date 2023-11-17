CREATE DATABASE financas_pessoais;
USE financas_pessoais;

CREATE TABLE contas (
    id_conta INT PRIMARY KEY,
    nome VARCHAR(255),
    saldo DECIMAL(10, 2)
);


INSERT INTO contas (id_conta, nome, saldo) VALUES
(1, 'Conta Corrente', 1000.00),
(2, 'Conta Poupança', 500.50),
(3, 'Carteira', 200.00);


CREATE TABLE transacoes (
    id_transacao INT PRIMARY KEY,
    id_conta INT,
    tipo VARCHAR(255),
    valor DECIMAL(10, 2),
    FOREIGN KEY (id_conta) REFERENCES contas(id_conta)
);


INSERT INTO transacoes (id_transacao, id_conta, tipo, valor) VALUES
(1, 1, 'entrada', 200.00),
(2, 2, 'saída', 50.25),
(3, 3, 'entrada', 100.50);


DELIMITER //
CREATE TRIGGER atualiza_saldo
AFTER INSERT ON transacoes
FOR EACH ROW
BEGIN
    IF NEW.tipo = 'entrada' THEN
        UPDATE contas
        SET saldo = saldo + NEW.valor
        WHERE id_conta = NEW.id_conta;
    ELSE
        UPDATE contas
        SET saldo = saldo - NEW.valor
        WHERE id_conta = NEW.id_conta;
    END IF;
END;
//
DELIMITER ;

INSERT INTO transacoes (id_transacao, id_conta, tipo, valor) VALUES
(4, 1, 'entrada', 300.75);

SELECT * FROM contas;
SELECT * FROM transacoes;
