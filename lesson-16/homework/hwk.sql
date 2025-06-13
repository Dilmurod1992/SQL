create database Lesson_16
go
use Lesson_16




										-- Easy Tasks--


; with cte as (
select 1 as num
union all
select num+1 as num from cte
where num<1000
)
select * from cte
option (maxrecursion 1000)





CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);



CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');




select * from Employees
select * from Sales



select emp.EmployeeID, FirstName, LastName, Salary from Employees as emp
join
(
select EmployeeID, sum(SalesAmount) as total_sale from Sales
group by EmployeeID
) as Emp_total_sale
on emp.EmployeeID=Emp_total_sale.EmployeeID




; with cte as (
select EmployeeID, FirstName, LastName, avg(Salary) as avg_salary from Employees
group by EmployeeID, FirstName, LastName
)
select * from cte




CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);



select * from Sales
select * from Products





select pro.ProductID, pro.ProductName, pro.Price, Max_sales_of_product.max_sales from Products as pro
join
(
select ProductID, max(SalesAmount) as max_sales from Sales
group by ProductID
) as Max_sales_of_product
on pro.ProductID=Max_sales_of_product.ProductID






; WITH cte AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2
    FROM cte
    WHERE num * 2 < 1000000
)
SELECT num
FROM cte
OPTION (MAXRECURSION 0);





select * from Sales
select * from Employees





; with cte as (
select emp.EmployeeID, emp.FirstName, emp.LastName, emp.Salary, Sales_quantity.num_of_sales from Employees as emp
join
(select EmployeeID, count(SalesID) as num_of_sales from Sales
group by EmployeeID) as Sales_quantity
on emp.EmployeeID=Sales_quantity.EmployeeID
where num_of_sales>5
) 
select * from cte




select * from Sales
select * from Products




; with cte as (
select Sales.ProductID, Sales.SalesAmount, price_of_product.ProductName, price_of_product.total_price from Sales
join (
select ProductID, ProductName, sum(Price) as total_price from Products
group by ProductID, ProductName
) as price_of_product
on sales.ProductID=price_of_product.ProductID
where total_price>500
)
select * from cte






; with cte as (
select price_of_product.ProductID, pro.ProductName, pro.Price, price_of_product.total_amount from Products as pro
join (
select ProductID, sum(SalesAmount) as total_amount from Sales
group by ProductID
) as price_of_product
on pro.ProductID=price_of_product.ProductID
where total_amount>500
)
select * from cte




; WITH cte AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT e.FirstName, e.FirstName, e.Salary, a.AvgSalary
FROM Employees as e
JOIN cte as a 
ON e.Salary > a.AvgSalary;






										--Medium Tasks--



select * from Sales
select * from Employees





select emp.FirstName, emp.LastName, emp.Salary, largest_sales.num_of_sales from Employees as emp
join (
select top 5 EmployeeID, count(SalesID) as num_of_sales from Sales
group by EmployeeID
order by num_of_sales desc
) as largest_sales
on emp.EmployeeID=largest_sales.EmployeeID




select * from Sales
select * from Products





SELECT p.CategoryID, sum(p.Price) AS SalesPerCategory
FROM (
    SELECT ProductID, sum(SalesAmount) AS TotalSales
    FROM Sales
	group by ProductID
) as s
JOIN Products as p 
ON s.ProductID = p.ProductID
GROUP BY p.CategoryID;





CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)



select * from Numbers1



; WITH FactorialCTE AS (
    SELECT 
        Number AS OriginalValue,
        1 AS Counter,
        1 AS Factorial
    FROM Numbers1

    UNION ALL

    SELECT 
        f.OriginalValue,
        f.Counter + 1,
        f.Factorial * (f.Counter + 1)
    FROM FactorialCTE f
    WHERE f.Counter + 1 <= f.OriginalValue
)

SELECT 
    OriginalValue,
    MAX(Factorial) AS Factorial
FROM FactorialCTE
GROUP BY OriginalValue
ORDER BY OriginalValue

OPTION (MAXRECURSION 1000);





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


select * from Example



; WITH cte AS (
    SELECT
        Id,
        1 AS Position,
        SUBSTRING(String, 1, 1) AS Character,
        String
    FROM Example

    UNION ALL

    SELECT
        Id,
        Position + 1,
        SUBSTRING(String, Position + 1, 1),
        String
    FROM cte
    WHERE Position + 1 <= LEN(String)
)
SELECT Id, Position, Character
FROM cte
ORDER BY Id, Position

OPTION (MAXRECURSION 1000);





select * from Sales




; WITH MonthlySales AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS Month,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesWithDifference AS (
    SELECT 
        Month,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY Month) AS PrevMonthSales,
        TotalSales - LAG(TotalSales) OVER (ORDER BY Month) AS SalesDifference
    FROM MonthlySales
)
SELECT *
FROM SalesWithDifference
ORDER BY Month;






select * from Sales
select * from Employees




SELECT e.EmployeeID, e.FirstName, e.LastName, s.Quarter, s.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        CONCAT(YEAR(SaleDate), ' Q', DATEPART(QUARTER, SaleDate)) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
) as s 
ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 4500
ORDER BY e.EmployeeID, s.Quarter;






										-- Difficult Tasks--



;WITH FibonacciCTE AS (
    SELECT 
        1 AS Position,
        0 AS Fibonacci
    UNION ALL
    SELECT 
        2 AS Position,
        1 AS Fibonacci
    UNION ALL
    SELECT 
        f.Position + 1,
        f.Fibonacci + fNext.Fibonacci
    FROM FibonacciCTE f
    JOIN FibonacciCTE fNext ON f.Position = fNext.Position - 1
    WHERE f.Position + 1 <= 20 
	)
SELECT Position, Fibonacci
FROM FibonacciCTE
ORDER BY Position;





CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



select * from FindSameCharacters


select *, replace(Vals, SUBSTRING(Vals, 1, 1), '') from FindSameCharacters
where len(Vals)>1 and len(replace(Vals, SUBSTRING(Vals, 1, 1), ''))=0





DECLARE @n INT = 5;

;WITH SequenceCTE AS (
    SELECT 
        1 AS Step,
        CAST('1' AS VARCHAR(MAX)) AS Sequence
    UNION ALL
    SELECT 
        Step + 1,
        Sequence + CAST(Step + 1 AS VARCHAR)
    FROM SequenceCTE
    WHERE Step + 1 <= @n
)
SELECT Step, Sequence
FROM SequenceCTE
ORDER BY Step
OPTION (MAXRECURSION 100);




select * from Employees
select * from Sales





SELECT e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales = (
    SELECT MAX(TotalSales)
    FROM (
        SELECT 
            EmployeeID,
            SUM(SalesAmount) AS TotalSales
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY EmployeeID
    ) t
);





CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )






; WITH SplitWords AS (
    SELECT 
        Pawan_slug_name,
        value AS Word
    FROM RemoveDuplicateIntsFromNames
    CROSS APPLY STRING_SPLIT(Pawan_slug_name, ' ')
),
Marked AS (
    SELECT 
        Pawan_slug_name,
        Word,
        COUNT(*) OVER (PARTITION BY Pawan_slug_name, Word) AS WordCount
    FROM SplitWords
),
Filtered AS (
    SELECT DISTINCT Pawan_slug_name, Word
    FROM Marked
    WHERE 
        ISNUMERIC(Word) = 0 
        OR (LEN(Word) > 1 AND WordCount = 1) 
)
SELECT 
   r.Pawan_slug_name,
    STRING_AGG(f.Word, ' ') AS CleanedName
FROM RemoveDuplicateIntsFromNames r
JOIN Filtered f ON r.Pawan_slug_name= f.Pawan_slug_name
GROUP BY r.Pawan_slug_name;
