create database Lesson_18
go
use Lesson_18





CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');



select * from Products
select * from Sales






CREATE TABLE #MonthlySales (
    ProductID INT,
    ProductName VARCHAR(100),
    total_price DECIMAL(18, 2),
    total_quantity int
);


INSERT INTO #MonthlySales (ProductID, ProductName, total_price, total_quantity)

select pro.ProductID, ProductName, sum(Price) as total_price, sum(Quantity) as total_quantity from Products as pro
join Sales as s
on pro.ProductID=s.ProductID
where month(s.SaleDate)=4
group by pro.ProductID, ProductName


select * from #MonthlySales





Create view vw_ProductSalesSummary as 
select s.SaleDate, pro.ProductID, ProductName, Category, sum(Quantity) as TotalQuantitySold from Products as pro
join Sales as s
on pro.ProductID=s.ProductID
group by s.SaleDate, pro.ProductID, ProductName, Category


select * from vw_ProductSalesSummary


sp_helptext vw_ProductSalesSummary






select * from Products








Alter function fn_GetTotalRevenueForProduct(@ProductID INT)
returns table
as
return
(
select ProductID, sum(Price) as total_revenue from Products
where ProductID=@ProductID
group by ProductID
)


select * from fn_GetTotalRevenueForProduct(2)







Create function fn_GetSalesByCategory(@Category VARCHAR(50))
returns table
as
return
(
select Category, sum(Price) as total_revenue from Products
where Category=@Category
group by Category
)


select * from fn_GetSalesByCategory('Clothing')







CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1;

    IF @Number < 2
        RETURN 'No';

    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END

    RETURN CASE WHEN @IsPrime = 1 THEN 'Yes' ELSE 'No' END;
END;



select dbo.fn_IsPrime(6)








CREATE FUNCTION dbo.fn_GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS @Numbers TABLE
(
    Number INT
)
AS
BEGIN
    DECLARE @i INT = @Start;

    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers (Number)
        VALUES (@i);
        SET @i = @i + 1;
    END

    RETURN;
END;
go



SELECT * FROM dbo.fn_GetNumbersBetween(3, 100);




create table Employee(id int, salary decimal(10,2))

insert into Employee(id, salary) values
(1, 100), (2, 200), (3, 300)


select * from Employee



DECLARE @N INT = 2;

SELECT MAX(Salary) AS HighestNSalary
FROM (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS RankNum
    FROM Employee
) AS RankedSalaries
WHERE RankNum = @N;







create table RequestAccepted (requester_id int, accepter_id int, accept_date date)


insert into RequestAccepted (requester_id, accepter_id, accept_date) values 
 (1, 2, '2016/06/03'),
(1, 3, '2016/06/08'),
(2, 3, '2016/06/08'),
(3, 4, '2016/06/09') 


select * from RequestAccepted


SELECT TOP 1 user_id, COUNT(*) AS total_friends
FROM (
    SELECT requester_id AS user_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS user_id FROM RequestAccepted
) AS AllFriends
GROUP BY user_id
ORDER BY COUNT(*) DESC;






CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);


INSERT INTO Customers (customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');


INSERT INTO Orders (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);





select * from Customers
select * from Orders




select ord.customer_id, name, count(order_id) as total_orders, sum(amount) as total_amount from Customers as cus
join Orders as ord
on cus.customer_id=ord.customer_id
where order_date=(select max(order_date) from Orders)
group by ord.customer_id, name








CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,'Charlie'),(8,NULL),(9,NULL);



select * from Gaps



SELECT g.RowNumber,
       COALESCE(g.TestCase, prev.TestCase) AS TestCase
FROM Gaps g
OUTER APPLY (
    SELECT TOP 1 TestCase
    FROM Gaps g2
    WHERE g2.RowNumber < g.RowNumber AND g2.TestCase IS NOT NULL
    ORDER BY g2.RowNumber DESC
) AS prev
ORDER BY g.RowNumber;
