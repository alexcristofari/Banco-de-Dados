
-- 1. Projetos por Funcionário
CREATE FUNCTION fn_ProjetosPorFuncionario (@Cpf CHAR(11))
RETURNS TABLE
AS
RETURN (
    SELECT P.Projnome
    FROM TRABALHA_EM T
    JOIN PROJETO P ON T.Pnr = P.Projnumero
    WHERE T.Fcpf = @Cpf
);
GO

-- 2. Listar Dependentes
CREATE FUNCTION fn_ListarDependentes (@Cpf CHAR(11))
RETURNS TABLE
AS
RETURN (
    SELECT Nome_dependente, Parentesco
    FROM DEPENDENTE
    WHERE Fcpf = @Cpf
);
GO

-- 3. Nome do Supervisor
CREATE FUNCTION fn_NomeSupervisor (@Cpf CHAR(11))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Nome VARCHAR(100);

    SELECT @Nome = (S.Pnome + ' ' + ISNULL(S.Minicial,'') + ' ' + S.Unome)
    FROM FUNCIONARIO F
    JOIN FUNCIONARIO S ON F.Cpf_supervisor = S.Cpf
    WHERE F.Cpf = @Cpf;

    RETURN @Nome;
END;
GO

-- 4. Ganha Mais que o Supervisor
CREATE FUNCTION fn_GanhaMaisQueSupervisor (@Cpf CHAR(11))
RETURNS BIT
AS
BEGIN
    DECLARE @Resultado BIT;

    SELECT @Resultado = CASE WHEN F.Salario > S.Salario THEN 1 ELSE 0 END
    FROM FUNCIONARIO F
    JOIN FUNCIONARIO S ON F.Cpf_supervisor = S.Cpf
    WHERE F.Cpf = @Cpf;

    RETURN @Resultado;
END;
GO

-- 5. Ano de Aposentadoria
CREATE FUNCTION fn_AnoAposentadoria (@DataNasc DATE)
RETURNS INT
AS
BEGIN
    RETURN YEAR(@DataNasc) + 65;
END;
GO

-- 6. Mais que N Dependentes
CREATE FUNCTION fn_TemMaisQueNDependentes (@N INT, @Cpf CHAR(11))
RETURNS BIT
AS
BEGIN
    DECLARE @Resultado BIT;

    SELECT @Resultado = CASE WHEN COUNT(*) > @N THEN 1 ELSE 0 END
    FROM DEPENDENTE
    WHERE Fcpf = @Cpf;

    RETURN @Resultado;
END;
GO

-- 7. Quantidade de Projetos por Funcionário
CREATE FUNCTION fn_QtdProjetosFuncionario (@Cpf CHAR(11))
RETURNS INT
AS
BEGIN
    DECLARE @Qtd INT;

    SELECT @Qtd = COUNT(*)
    FROM TRABALHA_EM
    WHERE Fcpf = @Cpf;

    RETURN @Qtd;
END;
GO

-- 8. Ranking de Salário por Departamento
CREATE FUNCTION fn_RankingSalarioDepartamento (@Dnumero INT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        (F.Pnome + ' ' + ISNULL(F.Minicial,'') + ' ' + F.Unome) AS NomeCompleto,
        F.Salario,
        ROW_NUMBER() OVER (ORDER BY F.Salario DESC) AS PosicaoRanking
    FROM FUNCIONARIO F
    WHERE F.Dnr = @Dnumero
);
GO

-- 9. Custo Mensal de um Departamento
CREATE FUNCTION fn_CustoDepartamento (@Dnumero INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Custo DECIMAL(18,2);

    SELECT @Custo = SUM(Salario)
    FROM FUNCIONARIO
    WHERE Dnr = @Dnumero;

    RETURN @Custo;
END;
GO

-- 10. Teste da Função CustoDepartamento
-- SELECT D.Dnome, dbo.fn_CustoDepartamento(D.Dnumero) AS CustoMensal FROM DEPARTAMENTO D;
GO

-- 11. Nome dos Dependentes Concatenados
CREATE FUNCTION fn_NomeDependentesFuncionario (@Cpf CHAR(11))
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @Dependentes VARCHAR(MAX);

    SELECT @Dependentes = STRING_AGG(Nome_dependente, ', ')
    FROM DEPENDENTE
    WHERE Fcpf = @Cpf;

    RETURN @Dependentes;
END;
GO

-- 12. Funcionário Estrela
CREATE FUNCTION fn_FuncionarioEstrela (@Cpf CHAR(11))
RETURNS TABLE
AS
RETURN (
    SELECT 
        (F.Pnome + ' ' + ISNULL(F.Minicial,'') + ' ' + F.Unome) AS NomeCompleto,
        (SELECT COUNT(*) FROM DEPENDENTE D WHERE D.Fcpf = F.Cpf) AS QtdDependentes,
        (SELECT COUNT(*) FROM TRABALHA_EM T WHERE T.Fcpf = F.Cpf) AS QtdProjetos,
        dbo.fn_GanhaMaisQueSupervisor(F.Cpf) AS GanhaMaisQueSupervisor
    FROM FUNCIONARIO F
    WHERE F.Cpf = @Cpf
);
GO
