-- 1. Criar um relatório que mostre os detalhes principais dos produtos, combinando informações de produtos, categorias e fornecedores.
-- Listar o nome do produto, o nome da empresa fornecedora, o nome da categoria, o preço unitário do produto e a quantidade em estoque.

SELECT 
    p.ProductName AS nome_produto, 
    s.CompanyName AS nome_fornecedor, 
    c.CategoryName AS nome_categoria, 
    p.UnitPrice AS preco_unitario, 
    p.UnitsInStock AS quantidade_em_estoque
FROM 
    Products p
JOIN 
    Suppliers s ON p.SupplierID = s.SupplierID
JOIN 
    Categories c ON p.CategoryID = c.CategoryID;

-- 2. Filtrar a lista de produtos, mostrando apenas aqueles que estão disponíveis para venda imediata.
-- A partir da consulta anterior, ocultar os produtos que possuem estoque zero ou que foram descontinuados.

SELECT 
    p.ProductName AS nome_produto, 
    p.UnitPrice AS preco_unitario, 
    p.UnitsInStock AS quantidade_em_estoque
FROM 
    Products p
WHERE 
    p.UnitsInStock > 0 AND p.Discontinued = 0;

-- 3. Analisar a produtividade da equipe de vendas por vendedor. 
-- Mostrar o nome completo de cada vendedor (funcionário) e a quantidade total de vendas que ele realizou.

SELECT 
    e.FirstName + ' ' + e.LastName AS nome_vendedor, 
    COUNT(o.OrderID) AS total_pedidos, 
    SUM(od.Quantity * od.UnitPrice) AS total_vendas
FROM 
    Orders o
JOIN 
    Employees e ON o.EmployeeID = e.EmployeeID
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    e.FirstName, e.LastName;

-- 4. Identificar os vendedores com o maior volume de transações.
-- Exibir apenas os vendedores que realizaram uma quantidade de vendas maior ou igual a 100.

SELECT 
    e.FirstName + ' ' + e.LastName AS nome_vendedor, 
    COUNT(o.OrderID) AS total_pedidos, 
    SUM(od.Quantity * od.UnitPrice) AS total_vendas
FROM 
    Orders o
JOIN 
    Employees e ON o.EmployeeID = e.EmployeeID
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    e.FirstName, e.LastName
HAVING 
    SUM(od.Quantity * od.UnitPrice) >= 100;

-- 5. Entender a distribuição de trabalho dos vendedores por áreas geográficas.
-- Mostrar o nome completo do vendedor e a quantidade de territórios aos quais ele está vinculado.

SELECT 
    e.FirstName + ' ' + e.LastName AS nome_vendedor, 
    COUNT(t.TerritoryID) AS total_territorios
FROM 
    Employees e
JOIN 
    EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
JOIN 
    Territories t ON et.TerritoryID = t.TerritoryID
GROUP BY 
    e.FirstName, e.LastName;

-- 6. Classificar os pedidos pelo seu valor monetário total, permitindo identificar as vendas mais valiosas.
-- Listar todos os pedidos, calculando o valor total de cada um (considerando preço, quantidade e desconto), e ordená-los do maior para o menor valor.

SELECT 
    o.OrderID, 
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS valor_total
FROM 
    Orders o
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    o.OrderID
ORDER BY 
    valor_total DESC;

-- 7. Criar uma consulta que identifique todos os itens de pedidos que foram vendidos por um preço unitário inferior ao padrão cadastrado na tabela de produtos.
-- Exibir o ID do Pedido, nome do produto e preço unitário dos itens vendidos a um preço inferior ao preço padrão.

SELECT 
    od.OrderID, 
    p.ProductName, 
    od.UnitPrice
FROM 
    [Order Details] od
JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    od.UnitPrice < p.UnitPrice;
