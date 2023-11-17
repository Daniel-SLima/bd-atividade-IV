CREATE DATABASE gerenciamento_escola;
USE gerenciamento_escola;

CREATE TABLE alunos (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(255),
    data_nascimento DATE,
    serie INT
);

INSERT INTO alunos (id_aluno, nome, data_nascimento, serie) VALUES
(1, 'João', '2008-05-15', 5),
(2, 'Maria', '2009-08-20', 4),
(3, 'Carlos', '2010-03-10', 3);

CREATE TABLE matriculas (
    id_matricula INT PRIMARY KEY,
    id_aluno INT,
    data_matricula DATE,
    status VARCHAR(255),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);

INSERT INTO matriculas (id_matricula, id_aluno, data_matricula, status) VALUES
(1, 1, '2023-11-17', 'Ativa'),
(2, 2, '2023-11-18', 'Ativa'),
(3, 3, '2023-11-19', 'Ativa');

DELIMITER //
CREATE TRIGGER verifica_idade_aluno
BEFORE INSERT ON matriculas
FOR EACH ROW
BEGIN
    DECLARE idade_aluno INT;
    DECLARE serie_aluno INT;

    SELECT TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) INTO idade_aluno
    FROM alunos
    WHERE id_aluno = NEW.id_aluno;

    SELECT serie INTO serie_aluno
    FROM alunos
    WHERE id_aluno = NEW.id_aluno;

    IF idade_aluno < serie_aluno + 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Aluno não atende aos requisitos de idade para a série.';
    END IF;
END;
//
DELIMITER ;

INSERT INTO matriculas (id_matricula, id_aluno, data_matricula, status) VALUES (4, 3, '2023-11-20', 'Ativa');

SELECT * FROM alunos;
SELECT * FROM matriculas;
