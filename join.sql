-- Criar banco de dados
CREATE DATABASE Empresa1;
GO

-- Usar o banco de dados
USE Empresa1;
GO

-- Criar tabelas
CREATE TABLE FUNCIONARIO (
    Pnome VARCHAR(15) NOT NULL,
    Minicial CHAR,
    Unome VARCHAR(15) NOT NULL,
    Cpf CHAR(11),
    Datanasc DATE,
    Endereco VARCHAR(255),
    Sexo CHAR,
    Salario DECIMAL(10,2),
    Cpf_supervisor CHAR(11),
    Dnr INT,
    PRIMARY KEY (Cpf),
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);
GO

CREATE TABLE DEPARTAMENTO (
    Dnome VARCHAR(15) NOT NULL,
    Dnumero INT,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    PRIMARY KEY (Dnumero),
    UNIQUE (Dnome),
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(CPF)
);
GO

ALTER TABLE FUNCIONARIO
ADD CONSTRAINT FK_Funcionario_Departamento
FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO(Dnumero);
GO

CREATE TABLE LOCALIZACAO_DEP (
    Dnumero INT NOT NULL,
    Dlocal VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO(Dnumero)
);
GO

CREATE TABLE PROJETO(
    Projnome VARCHAR(15) NOT NULL,
    Projnumero INT NOT NULL,
    Projlocal VARCHAR(15),
    Dnum INT,
    PRIMARY KEY (Projnumero),
    UNIQUE (Projnome),
    FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO(Dnumero)
);
GO

CREATE TABLE TRABALHA_EM(
    Fcpf CHAR(11) NOT NULL,
    Pnr INT NOT NULL,
    Horas DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (Fcpf, Pnr),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf),
    FOREIGN KEY (Pnr) REFERENCES PROJETO(Projnumero)
);
GO

CREATE TABLE DEPENDENTE(
    Fcpf CHAR(11) NOT NULL,
    Nome_dependente VARCHAR(15) NOT NULL,
    Sexo CHAR,
    Datanasc DATE,
    Parentesco VARCHAR(8),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);
GO

-- Inserir dados originais (do script anterior)
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Pesquisa', 5), ('Administração', 4), ('Matriz', 1);
GO

INSERT INTO FUNCIONARIO VALUES 
('Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000, NULL, 1),
('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av Arthur de Lima, 54, Santo André, SP', 'F', 43000, '88866555576', 4),
('Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, '88866555576', 5),
('João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, '33344555587', 5),
('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, '98765432168', 4),
('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, '33344555587', 5),
('Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, '33344555587', 5),
('André', 'E', 'Brito', '98798798733', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, '98765432168', 4);
GO

UPDATE DEPARTAMENTO SET Cpf_gerente = '33344555587', Data_inicio_gerente = '1988-05-22' WHERE Dnumero = 5;
UPDATE DEPARTAMENTO SET Cpf_gerente = '98765432168', Data_inicio_gerente = '1995-01-01' WHERE Dnumero = 4;
UPDATE DEPARTAMENTO SET Cpf_gerente = '88866555576', Data_inicio_gerente = '1981-06-19' WHERE Dnumero = 1;
GO

INSERT INTO LOCALIZACAO_DEP VALUES 
(1, 'São Paulo'), (4, 'Mauá'), (5, 'Santo André'), (5, 'Itu'), (5, 'São Paulo');
GO

INSERT INTO PROJETO VALUES 
('ProdutoX', 1, 'Santo André', 5), ('ProdutoY', 2, 'Itu', 5), ('ProdutoZ', 3, 'São Paulo', 5),
('Informatização', 10, 'Mauá', 4), ('Reorganização', 20, 'São Paulo', 1), ('Novosbenefícios', 30, 'Mauá', 4);
GO

INSERT INTO TRABALHA_EM VALUES 
('12345678966',1,32.5), ('12345678966',2,7.5), ('66688444476',3,40), ('45345345376',1,20),
('45345345376',2,20), ('33344555587',2,10), ('33344555587',3,10), ('33344555587',10,10),
('33344555587',20,10), ('99988777767',10,10), ('99988777767',30,30), ('98798798733',10,35),
('98798798733',30,5), ('98765432168',30,20), ('98765432168',20,15);
GO

INSERT INTO DEPENDENTE VALUES 
('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'), ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
('33344555587', 'Janaina', 'F', '1958-05-03', 'Eposa'), ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'), ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');
GO

-- Inserir novos dados (do script atual)
INSERT INTO FUNCIONARIO (Pnome, Minicial, Unome, Cpf, Datanasc, Endereco, Sexo, Salario, Cpf_supervisor, Dnr)
VALUES ('Carlos', 'M', 'Ferreira', '12312312311', '1980-02-15', 'Av. Paulista, 1000, São Paulo, SP', 'M', 45000, NULL, NULL),
       ('Mariana', 'L', 'Gomes', '32132132122', '1985-06-22', 'Rua das Acácias, 500, Rio de Janeiro, RJ', 'F', 42000, NULL, NULL),
       ('Pedro', 'A', 'Silva', '65465465433', '1990-11-10', 'Rua da Praia, 200, Salvador, BA', 'M', 47000, NULL, NULL);
GO

INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Vendas', 6), ('RH', 7), ('TI', 8);
GO

-- Consultas (corrigidas)
-- INNER JOIN 1
SELECT Pnome, Unome, Dnome 
FROM Funcionario 
INNER JOIN Departamento ON Dnumero = Dnr 
WHERE Dnome = 'Pesquisa';
GO

-- INNER JOIN 2
SELECT F.Pnome, P.Projnome
FROM Funcionario AS F
INNER JOIN TRABALHA_EM AS T ON F.Cpf = T.Fcpf
INNER JOIN PROJETO AS P ON T.Pnr = P.Projnumero
WHERE P.Projnome = 'ProdutoX';
GO

-- INNER JOIN 3 (corrigido aspas)
SELECT Projnumero, Dnum, Unome, Endereco, Datanasc
FROM ((PROJETO JOIN DEPARTAMENTO ON Dnum = Dnumero) 
      JOIN FUNCIONARIO ON Cpf_gerente = Cpf)
WHERE Projlocal = 'Mauá'; -- Aspas simples corrigidas
GO

-- LEFT JOIN 1: Funcionários sem departamento
SELECT 
    FUNCIONARIO.Pnome, FUNCIONARIO.Minicial, FUNCIONARIO.Unome, FUNCIONARIO.Cpf,
    FUNCIONARIO.Datanasc, FUNCIONARIO.Endereco, FUNCIONARIO.Sexo, FUNCIONARIO.Salario,
    FUNCIONARIO.Cpf_supervisor, FUNCIONARIO.Dnr, DEPARTAMENTO.Dnome
FROM FUNCIONARIO
LEFT JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero;
GO

-- LEFT JOIN 2: Departamentos sem funcionários (Exemplo 1)
SELECT DEPARTAMENTO.Dnome, DEPARTAMENTO.Dnumero
FROM DEPARTAMENTO
LEFT JOIN FUNCIONARIO ON DEPARTAMENTO.Dnumero = FUNCIONARIO.Dnr
WHERE FUNCIONARIO.Dnr IS NULL;
GO

-- LEFT JOIN 3: Departamentos sem funcionários (Exemplo 2)
SELECT Dnome, Dnumero
FROM DEPARTAMENTO
WHERE Dnumero NOT IN (SELECT Dnr FROM FUNCIONARIO WHERE Dnr IS NOT NULL);
GO

-- LEFT JOIN 4: Departamentos sem funcionários (Exemplo 3)
SELECT Dnome, Dnumero
FROM DEPARTAMENTO d
WHERE NOT EXISTS (SELECT 1 FROM FUNCIONARIO f WHERE f.Dnr = d.Dnumero);
GO

-- RIGHT JOIN
SELECT 
    FUNCIONARIO.Pnome, FUNCIONARIO.Minicial, FUNCIONARIO.Unome, FUNCIONARIO.Cpf,
    FUNCIONARIO.Datanasc, FUNCIONARIO.Endereco, FUNCIONARIO.Sexo, FUNCIONARIO.Salario,
    FUNCIONARIO.Cpf_supervisor, FUNCIONARIO.Dnr, DEPARTAMENTO.Dnome
FROM FUNCIONARIO
RIGHT JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero;
GO

-- FULL JOIN
SELECT 
    FUNCIONARIO.Pnome, FUNCIONARIO.Minicial, FUNCIONARIO.Unome, FUNCIONARIO.Cpf,
    FUNCIONARIO.Datanasc, FUNCIONARIO.Endereco, FUNCIONARIO.Sexo, FUNCIONARIO.Salario,
    FUNCIONARIO.Cpf_supervisor, FUNCIONARIO.Dnr, DEPARTAMENTO.Dnome
FROM FUNCIONARIO
FULL JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero;
GO

-- SELF JOIN
SELECT F.Pnome AS Nome_Funcionario, F.Unome AS Sobrenome_Funcionario,
       S.Pnome AS Nome_Supervisor, S.Unome AS Sobrenome_Supervisor
FROM FUNCIONARIO AS F
JOIN FUNCIONARIO AS S ON F.Cpf_supervisor = S.Cpf;
GO

-- UNION 1: Nomes únicos de projetos e departamentos
SELECT Dnome AS Nome FROM DEPARTAMENTO
UNION
SELECT Projnome AS Nome FROM PROJETO;
GO

-- UNION 2: Cidades (localização de departamentos e projetos)
SELECT Dlocal AS Cidade FROM LOCALIZACAO_DEP
UNION 
SELECT Projlocal AS Cidade FROM PROJETO;
GO

-- UNION ALL: Cidades (com duplicatas)
SELECT Dlocal AS Cidade FROM LOCALIZACAO_DEP
UNION ALL
SELECT Projlocal AS Cidade FROM PROJETO;
GO

-- EXCEPT: Funcionários que não são gerentes
SELECT Cpf FROM FUNCIONARIO
EXCEPT
SELECT Cpf_gerente FROM DEPARTAMENTO;
GO

-- EXCEPT: Funcionários que não são supervisores
SELECT Pnome, Unome
FROM FUNCIONARIO
WHERE Cpf IN (
    SELECT Cpf FROM FUNCIONARIO
    EXCEPT 
    SELECT Cpf_supervisor FROM FUNCIONARIO WHERE Cpf_supervisor IS NOT NULL
);
GO

-- INTERSECT: Funcionários que são gerentes
SELECT Cpf FROM FUNCIONARIO
INTERSECT
SELECT Cpf_gerente FROM DEPARTAMENTO;
GO

-- INTERSECT: Funcionários que são supervisores
SELECT Pnome, Unome
FROM FUNCIONARIO
WHERE Cpf IN (
    SELECT Cpf FROM FUNCIONARIO
    INTERSECT 
    SELECT Cpf_supervisor FROM FUNCIONARIO
);
GO

-- GROUP BY 1: Número de funcionários por departamento
SELECT DEPARTAMENTO.Dnome, COUNT(FUNCIONARIO.Cpf) AS NumeroFuncionarios
FROM FUNCIONARIO
JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero
GROUP BY DEPARTAMENTO.Dnome;
GO

-- GROUP BY 2: Soma dos salários por departamento
SELECT DEPARTAMENTO.Dnome, SUM(FUNCIONARIO.Salario) AS SalarioTotal
FROM FUNCIONARIO
JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero
GROUP BY DEPARTAMENTO.Dnome;
GO

-- GROUP BY 3: Média de horas por projeto
SELECT PROJETO.Projnome, AVG(TRABALHA_EM.Horas) AS MediaHorasTrabalhadas
FROM TRABALHA_EM
JOIN PROJETO ON TRABALHA_EM.Pnr = PROJETO.Projnumero
GROUP BY PROJETO.Projnome;
GO

-- GROUP BY 4: Quantidade de funcionários por sexo
SELECT Sexo, COUNT(*) AS NumeroFuncionarios
FROM FUNCIONARIO
GROUP BY Sexo;
GO

-- GROUP BY 5: Maior salário por departamento
SELECT DEPARTAMENTO.Dnome, MAX(FUNCIONARIO.Salario) AS MaiorSalario
FROM FUNCIONARIO
JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero
GROUP BY DEPARTAMENTO.Dnome;
GO

-- GROUP BY 6: Número de projetos por local
SELECT Projlocal, COUNT(*) AS NumeroProjetos
FROM PROJETO
GROUP BY Projlocal;
GO

-- HAVING 1: Departamentos com mais de 3 funcionários
SELECT DEPARTAMENTO.Dnome, COUNT(FUNCIONARIO.Cpf) AS NumeroFuncionarios
FROM FUNCIONARIO
JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero
GROUP BY DEPARTAMENTO.Dnome
HAVING COUNT(FUNCIONARIO.Cpf) > 3;
GO

-- HAVING 2: Projetos com mais de 100 horas no total
SELECT PROJETO.Projnome, SUM(TRABALHA_EM.Horas) AS TotalHoras
FROM TRABALHA_EM
JOIN PROJETO ON TRABALHA_EM.Pnr = PROJETO.Projnumero
GROUP BY PROJETO.Projnome
HAVING SUM(TRABALHA_EM.Horas) > 100;
GO

-- EXISTS 1: Funcionários que são gerentes
SELECT Pnome, Unome, Cpf
FROM FUNCIONARIO
WHERE EXISTS (
    SELECT 1 FROM DEPARTAMENTO 
    WHERE DEPARTAMENTO.Cpf_gerente = FUNCIONARIO.Cpf
);
GO

-- EXISTS 2: Departamentos com projetos
SELECT Dnome, Dnumero
FROM DEPARTAMENTO
WHERE EXISTS (
    SELECT 1 FROM PROJETO 
    WHERE PROJETO.Dnum = DEPARTAMENTO.Dnumero
);
GO

-- ANY: Funcionários que ganham mais que qualquer um de 'Administração'
SELECT Pnome, Unome, Salario
FROM FUNCIONARIO
WHERE Salario > ANY (
    SELECT Salario 
    FROM FUNCIONARIO 
    JOIN DEPARTAMENTO ON FUNCIONARIO.Dnr = DEPARTAMENTO.Dnumero
    WHERE DEPARTAMENTO.Dnome = 'Administração'
);
GO

-- ALL: Projetos com mais horas que todos os projetos de 'São Paulo'
SELECT Projnome, SUM(TRABALHA_EM.Horas) AS TotalHoras
FROM PROJETO
JOIN TRABALHA_EM ON PROJETO.Projnumero = TRABALHA_EM.Pnr
GROUP BY Projnome
HAVING SUM(TRABALHA_EM.Horas) > ALL (
    SELECT SUM(TRABALHA_EM.Horas) 
    FROM PROJETO
    JOIN TRABALHA_EM ON PROJETO.Projnumero = TRABALHA_EM.Pnr
    WHERE PROJETO.Projlocal = 'São Paulo'
    GROUP BY PROJETO.Projnome
);
 -- 1. INNER JOIN: Quantos funcionários tem em cada departamento?
SELECT 
    D.Dnome AS Departamento,
    COUNT(F.Cpf) AS TotalFuncionarios
FROM DEPARTAMENTO D
INNER JOIN FUNCIONARIO F ON D.Dnumero = F.Dnr
GROUP BY D.Dnome
ORDER BY TotalFuncionarios DESC;
GO

-- 2. LEFT JOIN: Listar todos os departamentos e seus funcionários (incluindo departamentos sem funcionários)
SELECT 
    D.Dnome AS Departamento,
    F.Pnome + ' ' + F.Unome AS Funcionario
FROM DEPARTAMENTO D
LEFT JOIN FUNCIONARIO F ON D.Dnumero = F.Dnr
ORDER BY D.Dnome, Funcionario;
GO

-- 3. RIGHT JOIN: Listar todos os funcionários e seus departamentos (incluindo funcionários sem departamento)
SELECT 
    F.Pnome + ' ' + F.Unome AS Funcionario,
    D.Dnome AS Departamento
FROM FUNCIONARIO F
RIGHT JOIN DEPARTAMENTO D ON F.Dnr = D.Dnumero
ORDER BY Departamento, Funcionario;
GO

-- 4. CROSS JOIN: Combinação de todos os funcionários com todos os projetos
SELECT 
    F.Pnome + ' ' + F.Unome AS Funcionario,
    P.Projnome AS Projeto
FROM FUNCIONARIO F
CROSS JOIN PROJETO P
ORDER BY F.Pnome, P.Projnome;
GO

-- 5. UNION: Lista unificada de nomes de funcionários e dependentes
SELECT Pnome + ' ' + Unome AS Nome, 'Funcionário' AS Tipo
FROM FUNCIONARIO

UNION

SELECT Nome_dependente, 'Dependente'
FROM DEPENDENTE

ORDER BY Nome;
GO

-- 6. EXCEPT: Funcionários que não são gerentes de departamento
SELECT Cpf, Pnome + ' ' + Unome AS Nome
FROM FUNCIONARIO

EXCEPT

SELECT Cpf_gerente, Pnome + ' ' + Unome
FROM FUNCIONARIO F
JOIN DEPARTAMENTO D ON F.Cpf = D.Cpf_gerente;
GO

-- 7. GROUP BY: Total de horas trabalhadas por projeto
SELECT 
    P.Projnome AS Projeto,
    SUM(T.Horas) AS TotalHoras,
    COUNT(DISTINCT T.Fcpf) AS NumFuncionarios
FROM PROJETO P
JOIN TRABALHA_EM T ON P.Projnumero = T.Pnr
GROUP BY P.Projnome
ORDER BY TotalHoras DESC;
GO

-- 8. GROUP BY + HAVING: Departamentos com mais de 3 funcionários
SELECT 
    D.Dnome AS Departamento,
    COUNT(F.Cpf) AS TotalFuncionarios
FROM DEPARTAMENTO D
JOIN FUNCIONARIO F ON D.Dnumero = F.Dnr
GROUP BY D.Dnome
HAVING COUNT(F.Cpf) > 3;
GO

-- 9. GROUP BY: Média salarial por departamento
SELECT 
    D.Dnome AS Departamento,
    AVG(F.Salario) AS MediaSalarial,
    MIN(F.Salario) AS MenorSalario,
    MAX(F.Salario) AS MaiorSalario
FROM DEPARTAMENTO D
JOIN FUNCIONARIO F ON D.Dnumero = F.Dnr
GROUP BY D.Dnome
ORDER BY MediaSalarial DESC;
GO

-- 10. GROUP BY: Quantidade de projetos por localização
SELECT 
    Projlocal AS Localizacao,
    COUNT(*) AS TotalProjetos
FROM PROJETO
GROUP BY Projlocal
ORDER BY TotalProjetos DESC;
GO

-- 11. INNER JOIN: Funcionários que trabalham em projetos fora de seu departamento
SELECT DISTINCT
    F.Pnome + ' ' + F.Unome AS Funcionario,
    D.Dnome AS DepartamentoFuncionario,
    P.Projnome AS Projeto,
    P.Projlocal AS LocalProjeto
FROM FUNCIONARIO F
JOIN TRABALHA_EM T ON F.Cpf = T.Fcpf
JOIN PROJETO P ON T.Pnr = P.Projnumero
JOIN DEPARTAMENTO D ON F.Dnr = D.Dnumero
WHERE P.Dnum <> F.Dnr;
GO

-- 12. LEFT JOIN: Projetos sem funcionários alocados
SELECT 
    P.Projnome AS Projeto,
    P.Projlocal AS Localizacao
FROM PROJETO P
LEFT JOIN TRABALHA_EM T ON P.Projnumero = T.Pnr
WHERE T.Fcpf IS NULL;
GO

-- 13. GROUP BY + HAVING: Projetos com mais de 30 horas trabalhadas
SELECT 
    P.Projnome AS Projeto,
    SUM(T.Horas) AS TotalHoras
FROM PROJETO P
JOIN TRABALHA_EM T ON P.Projnumero = T.Pnr
GROUP BY P.Projnome
HAVING SUM(T.Horas) > 30
ORDER BY TotalHoras DESC;
GO

-- 14. UNION: Todas as cidades onde há departamentos ou projetos
SELECT Dlocal AS Cidade, 'Departamento' AS Tipo
FROM LOCALIZACAO_DEP

UNION

SELECT Projlocal, 'Projeto'
FROM PROJETO

ORDER BY Cidade, Tipo;
GO

-- 15. EXCEPT: Funcionários que não supervisionam ninguém
SELECT Cpf, Pnome + ' ' + Unome AS Nome
FROM FUNCIONARIO

EXCEPT

SELECT Cpf_supervisor, Pnome + ' ' + Unome
FROM FUNCIONARIO
WHERE Cpf_supervisor IS NOT NULL;
GO

-- 16. GROUP BY: Número de dependentes por funcionário
SELECT 
    F.Pnome + ' ' + F.Unome AS Funcionario,
    COUNT(D.Nome_dependente) AS NumDependentes
FROM FUNCIONARIO F
LEFT JOIN DEPENDENTE D ON F.Cpf = D.Fcpf
GROUP BY F.Pnome, F.Unome, F.Cpf
HAVING COUNT(D.Nome_dependente) > 0
ORDER BY NumDependentes DESC;
GO

-- 17. INNER JOIN: Gerentes e seus departamentos
SELECT 
    F.Pnome + ' ' + F.Unome AS Gerente,
    D.Dnome AS Departamento,
    D.Data_inicio_gerente
FROM FUNCIONARIO F
JOIN DEPARTAMENTO D ON F.Cpf = D.Cpf_gerente
ORDER BY D.Dnome;
GO

-- 18. GROUP BY: Distribuição de funcionários por sexo
SELECT 
    Sexo,
    COUNT(*) AS TotalFuncionarios,
    AVG(Salario) AS MediaSalarial
FROM FUNCIONARIO
GROUP BY Sexo;
GO

-- 19. LEFT JOIN: Departamentos e suas localizações (incluindo departamentos sem localização)
SELECT 
    D.Dnome AS Departamento,
    L.Dlocal AS Localizacao
FROM DEPARTAMENTO D
LEFT JOIN LOCALIZACAO_DEP L ON D.Dnumero = L.Dnumero
ORDER BY D.Dnome, L.Dlocal;
GO

-- 20. CROSS JOIN: Combinação de departamentos e projetos
SELECT 
    D.Dnome AS Departamento,
    P.Projnome AS Projeto
FROM DEPARTAMENTO D
CROSS JOIN PROJETO P
ORDER BY D.Dnome, P.Projnome;
GO

-- projetos

SELECT 

