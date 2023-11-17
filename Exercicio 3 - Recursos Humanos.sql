CREATE DATABASE recursos_humanos;
USE recursos_humanos;

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(255),
    data_admissao DATE
);

INSERT INTO funcionarios (id_funcionario, nome, data_admissao) VALUES
(1, 'João Silva', '2023-01-15'),
(2, 'Maria Oliveira', '2023-02-20'),
(3, 'Carlos Santos', '2022-12-10');

DELIMITER //
CREATE TRIGGER verifica_data_admissao
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
    IF NEW.data_admissao <= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: A data de admissão deve ser maior que a data atual.';
    END IF;
END;
//
DELIMITER ;

INSERT INTO funcionarios (id_funcionario, nome, data_admissao) VALUES (4, 'Ana Souza', '2024-11-17');

INSERT INTO funcionarios (id_funcionario, nome, data_admissao) VALUES (5, 'Pedro Oliveira', '2022-11-17');
