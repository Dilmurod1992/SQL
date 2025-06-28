create database Lesson_20
go
use Lesson_20




CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');


select * from #Sales


SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND s2.SaleDate >= '2024-03-01'
      AND s2.SaleDate <  '2024-04-01'
);



; with cte as (
select *, (select (Quantity*Price) from #Sales as s2 where s1.SaleID=s2.SaleID) as max_total_ptice from #Sales as s1
)
select max(max_total_ptice) from cte





SELECT MAX(SaleAmount) AS SecondHighestSaleAmount
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) AS Sub
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price) 
    FROM #Sales
);





select s1.*,(select sum(quantity) as total_quantity from #Sales as s2 where s1.Quantity=s2.Quantity and s1.SaleDate=s2.SaleDate) as sold_per_month from #Sales as s1







select * from #Sales

select s1.CustomerName, s1.Product, s2.Price from #Sales as s1
join #Sales as s2
on s1.Product=s2.Product and s1.CustomerName<>s2.CustomerName






create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')



select * from Fruits



select Name, sum(case when Fruit='Apple' then 1 else 0 end) as Apple_count,
	 sum(case when Fruit='Orange' then 1 else 0 end) as Orange_count,
	 sum(case when Fruit='Banana' then 1 else 0 end) as Banana_count
from Fruits
group by Name




create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)



select * from Family




SELECT f1.ParentID AS OlderPerson
FROM Family f1
WHERE EXISTS (
    SELECT 1
    FROM Family f2
    WHERE f2.ParentID = f1.ChildID
);





CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);




select * from #Orders



SELECT *
FROM #Orders o1
WHERE o1.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders o2
      WHERE o2.CustomerID = o1.CustomerID
        AND o2.DeliveryState = 'CA'
  );





create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')





select * from #residents




select *,
case when charindex('name=', [address])=0 then stuff([address], charindex('age=', [address]), 0, concat('name=',fullname, ' '))
else [address] end as updated_address
from #residents







CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);



select * from #Routes






; with cte as (
select concat_ws('-', first_city.DepartureCity, first_city.ArrivalCity, second_city.ArrivalCity, third_city.ArrivalCity, fourth_city.ArrivalCity) as Road_map,
isnull(first_city.Cost,0)+isnull(second_city.Cost,0)+isnull(third_city.Cost,0)+isnull(fourth_city.Cost,0) as total_cost from (select * from #Routes where DepartureCity='Tashkent') as first_city
left join #Routes as second_city
on first_city.ArrivalCity=second_city.DepartureCity
left join #Routes as third_city
on second_city.ArrivalCity=third_city.DepartureCity
left join #Routes as fourth_city
on third_city.ArrivalCity=fourth_city.DepartureCity
)
select * from cte
where total_cost=(select min(total_cost) from cte) or total_cost=(select max(total_cost) from cte)





CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')



select * from #RankingPuzzle




; WITH ProductMarkers AS (
    SELECT ID,
           ROW_NUMBER() OVER (ORDER BY ID) AS ProductGroupRank
    FROM #RankingPuzzle
    WHERE Vals = 'Product'
)
SELECT p.ID,
       p.Vals,
       pm.ProductGroupRank
FROM #RankingPuzzle p
OUTER APPLY (
    SELECT TOP 1 ProductGroupRank
    FROM ProductMarkers pm
    WHERE pm.ID < p.ID
    ORDER BY pm.ID DESC
) pm
WHERE p.Vals <> 'Product';






CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);



select * from #EmployeeSales



; with cte as (
select *, (select avg(SalesAmount) from #EmployeeSales as emp2 where emp1.Department=emp2.Department) as  avg_sale
from #EmployeeSales as emp1
)
select * from cte
where SalesAmount>avg_sale






SELECT EmployeeID, EmployeeName, Department, SalesAmount, SalesMonth, SalesYear
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesYear = e1.SalesYear
      AND e2.SalesMonth = e1.SalesMonth
      AND e2.SalesAmount > e1.SalesAmount
);






SELECT DISTINCT e1.EmployeeID, e1.EmployeeName
FROM #EmployeeSales e1
WHERE  not EXISTS (
    SELECT 1
    FROM (
        SELECT DISTINCT SalesMonth 
        FROM #EmployeeSales
    ) AS AllMonths
    WHERE not EXISTS (
        SELECT 1
        FROM #EmployeeSales e2
        WHERE e2.EmployeeID = e1.EmployeeID
          AND e2.SalesMonth = AllMonths.SalesMonth
    )
);




CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);



select * from Products


; with cte as (
select *, (select avg(Price) from Products as pro2) as  avg_price
from Products as pro1
)
select * from cte
where Price>avg_price






; with cte as (
select *, (select count(Stock) from Products as pro2) as stock_count 
from Products as pro1
)
select * from cte
where Stock<(select max(stock_count) from cte)






select * from Products


SELECT Name
FROM Products
WHERE Category = (
    SELECT Category
    FROM Products
    WHERE Name = 'laptop'
);



; with cte as (
select *, (select min(price) from Products as p2 where Category='Electronics') as min_price
from Products as p1
)
select * from cte
where Price>min_price




; with cte as (
select *, (select avg(price) from Products as pro2 where pro1.Category=pro2.Category) as avg_price
from Products as pro1
) 
select * from cte
where Price>avg_price





CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');


select * from Orders


SELECT DISTINCT p.Name, p.Category, p.Price
FROM Products p
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.ProductID = p.ProductID
);





SELECT DISTINCT p.Name, p.Category, p.Price, o.OrderDate, o.Quantity
FROM Products as p
JOIN Orders as o 
ON p.ProductID = o.ProductID;






select * from Orders
select * from Products




select pro.ProductID, pro.Name, avg(quantity) as avg_quantity from Products as pro
join Orders as ord
on pro.ProductID=ord.ProductID
group by pro.ProductID, pro.Name





select ord.OrderID, pro.ProductID, pro.Name, ord.Quantity from Orders as ord
join Products as pro
on ord.ProductID=pro.ProductID
where ord.Quantity>(select avg(quantity) from Orders)





select pro.Name, pro.Category, pro.Price, ord.Quantity from Products as pro
left join Orders as ord
on pro.ProductID=ord.ProductID
where ord.Quantity is null




select * from Products as pro
join Orders as ord
on pro.ProductID=ord.ProductID
where Quantity=(select max(quantity) from Orders)
