CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE livros (
    id_livro INT PRIMARY KEY,
    titulo VARCHAR(255),
    autor VARCHAR(255),
    quantidade_estoque INT
);

INSERT INTO livros (id_livro, titulo, autor, quantidade_estoque) VALUES
(1, 'Dom Casmurro', 'Machado de Assis', 5),
(2, 'A Moreninha', 'Joaquim Manuel de Macedo', 3),
(3, 'Memórias Póstumas de Brás Cubas', 'Machado de Assis', 7);

CREATE TABLE emprestimos (
    id_emprestimo INT PRIMARY KEY,
    id_livro INT,
    data_emprestimo DATETIME,
    data_devolucao DATETIME,
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

INSERT INTO emprestimos (id_emprestimo, id_livro, data_emprestimo, data_devolucao) VALUES
(1, 1, '2023-11-17 10:00:00', '2023-11-24 10:00:00'),
(2, 2, '2023-11-18 14:30:00', '2023-11-25 14:30:00'),
(3, 3, '2023-11-19 08:45:00', '2023-11-26 08:45:00');

DELIMITER //
CREATE TRIGGER atualiza_estoque
AFTER INSERT ON emprestimos
FOR EACH ROW
BEGIN
    UPDATE livros
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE id_livro = NEW.id_livro;
END;
//
DELIMITER ;
