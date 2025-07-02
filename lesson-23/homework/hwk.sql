create database Lesson_23
go
use Lesson_23






CREATE TABLE Dates (
    Id INT,
    Dt DATETIME
);
INSERT INTO Dates VALUES
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');


select * from Dates


SELECT Id,
    FORMAT(Dt, 'MM') AS Month
FROM Dates;





CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);


select * from MyTabel




; with cte as (
select Id, rID, max(Vals) as max_vals from MyTabel
group by Id, rID
) 
select count(Id) as dist_id, max(rID) as rID, sum(max_vals) as total_max_vals from cte






CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');


select * from TestFixLengths
where len(Vals)>=6 and len(Vals)<=10






CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);
INSERT INTO TestMaximum VALUES
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);




select * from TestMaximum



; WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY ID ORDER BY Vals DESC) AS rn
    FROM TestMaximum
)
SELECT ID, Item, Vals
FROM cte
WHERE rn = 1;







CREATE TABLE SumOfMax (
    DetailedNumber INT,
    Vals INT,
    Id INT
);
INSERT INTO SumOfMax VALUES
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);


select * from SumOfMax


; with cte as (
select DetailedNumber, Id, max(Vals) as max_vals from SumOfMax
group by DetailedNumber, Id
)
select Id, sum(max_vals) as total_max_vals from cte
group by Id







CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);




; with cte as (
select *,
case when a-b<>0 then a-b
	 else 0 end as result
from TheZeroPuzzle
)
select Id, a, b, replace(result, 0, ' ') as new_result from cte







CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50),
    CustomerID INT
);

INSERT INTO Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region, CustomerID)
VALUES
('Laptop', 'Electronics', 10, 800.00, '2024-01-01', 'North', 1),
('Smartphone', 'Electronics', 15, 500.00, '2024-01-02', 'North', 2),
('Tablet', 'Electronics', 8, 300.00, '2024-01-03', 'East', 3),
('Headphones', 'Electronics', 25, 100.00, '2024-01-04', 'West', 4),
('TV', 'Electronics', 5, 1200.00, '2024-01-05', 'South', 5),
('Refrigerator', 'Appliances', 3, 1500.00, '2024-01-06', 'South', 6),
('Microwave', 'Appliances', 7, 200.00, '2024-01-07', 'East', 7),
('Washing Machine', 'Appliances', 4, 1000.00, '2024-01-08', 'North', 8),
('Oven', 'Appliances', 6, 700.00, '2024-01-09', 'West', 9),
('Smartwatch', 'Electronics', 12, 250.00, '2024-01-10', 'East', 10),
('Vacuum Cleaner', 'Appliances', 5, 400.00, '2024-01-11', 'South', 1),
('Gaming Console', 'Electronics', 9, 450.00, '2024-01-12', 'North', 2),
('Monitor', 'Electronics', 14, 300.00, '2024-01-13', 'West', 3),
('Keyboard', 'Electronics', 20, 50.00, '2024-01-14', 'South', 4),
('Mouse', 'Electronics', 30, 25.00, '2024-01-15', 'East', 5),
('Blender', 'Appliances', 10, 150.00, '2024-01-16', 'North', 6),
('Fan', 'Appliances', 12, 75.00, '2024-01-17', 'South', 7),
('Heater', 'Appliances', 8, 120.00, '2024-01-18', 'East', 8),
('Air Conditioner', 'Appliances', 2, 2000.00, '2024-01-19', 'West', 9),
('Camera', 'Electronics', 7, 900.00, '2024-01-20', 'North', 10);





select * from Sales

SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;






select Product, avg(UnitPrice) as avg_unit_price from Sales
group by Product




select  avg(UnitPrice) as avg_unit_price from Sales




select count(SaleID) as number_of_sale from Sales






select *,
max(QuantitySold) over (order by QuantitySold desc) as max_total_amount
from sales







; with cte as (
select *,
sum(QuantitySold) over (partition by category order by QuantitySold ) as total_quantity_each_category
from sales
)
select category, max(total_quantity_each_category) as max_total from cte
group by Category





; with cte as (
select *,
sum(QuantitySold*UnitPrice) over (partition by region order by QuantitySold*UnitPrice) as total_quantity_each_region
from sales
)
select Region, max(total_quantity_each_region) as max_total from cte
group by Region






SELECT TOP 1 
    Product,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;







select *,
sum(QuantitySold*UnitPrice) over (order by SaleDate) as running_total
from sales






SELECT Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    ROUND(
        SUM(QuantitySold * UnitPrice) * 100.0 / 
        SUM(SUM(QuantitySold * UnitPrice)) OVER (), 2
    ) AS PercentageOfTotal
FROM Sales
GROUP BY Category;








CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    JoinDate DATE
);
INSERT INTO Customers (CustomerName, Region, JoinDate)
VALUES
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');







select CustomerName, Product from Customers as cus
join Sales s
on cus.CustomerID=s.CustomerID






select CustomerName, Product, Category, QuantitySold, UnitPrice, (QuantitySold * UnitPrice) as total_amount from Customers as cus
join Sales s
on cus.CustomerID=s.CustomerID







select CustomerName, Product from Customers as c
left join Sales as s
on c.CustomerID=s.CustomerID
where Product is null






select * from Customers
select * from Sales







SELECT CustomerID, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY CustomerID
ORDER BY TotalRevenue DESC;







SELECT top 1 CustomerID, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY CustomerID
ORDER BY TotalRevenue DESC;








SELECT *,
sum(QuantitySold*UnitPrice) over (partition by CustomerID order by CustomerID) as total_revenue_per_customer
FROM Sales








CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2)
);
INSERT INTO Products (ProductName, Category, CostPrice, SellingPrice)
VALUES
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);






select * from Products
select * from Sales





select Product, QuantitySold, UnitPrice from Products as pro
full outer join Sales s
on pro.ProductName=s.Product
where QuantitySold>=1






select top 1 ProductName, CostPrice, SellingPrice from Products
order by SellingPrice desc





; with cte as (
select *,
rank() over (order by SellingPrice desc) as ranking
from Products
)
select * from cte
where ranking=1






; with cte as (
select *,
avg(SellingPrice) over (partition by Category) as avg_price
from Products
)
select * from cte
where SellingPrice>avg_price
