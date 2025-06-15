create database Lesson_17
go
use Lesson_17


CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);



select * from #RegionSales


; WITH cte AS (
    SELECT DISTINCT R.Region, D.Distributor
    FROM (SELECT DISTINCT Region FROM #RegionSales) as R
    CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) as D
)

SELECT
    A.Region,
    A.Distributor,
    ISNULL(RS.Sales, 0) AS Sales
FROM
    cte as A
LEFT JOIN
    #RegionSales RS
    ON A.Region = RS.Region AND A.Distributor = RS.Distributor







CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);




select * from Employee




select a.name as manager_name, a.id, b.num_of_names from Employee as a
join  (
select managerId, count(name) as num_of_names from Employee 
group by managerId
) as b
on a.id=b.managerId
where b.num_of_names>=5






CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);




select * from Products
select * from Orders





select pro.product_id, pro.product_name, pro.product_category, ord.total_unit from Products as pro
join (
select product_id, sum(unit) as total_unit from Orders
where YEAR(order_date)=2020 and MONTH(order_date)=2
group by product_id
) as ord
on pro.product_id=ord.product_id
where ord.total_unit>=100





DROP TABLE  Orders;





CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');




select * from Orders



;with cte as(
select *, (select sum([COUNT]) from Orders as ord2 where ord1.CustomerID=ord2.CustomerID and ord1.Vendor=ord2.Vendor) as Total
from Orders as ord1
)
select distinct CustomerID,Vendor from cte
where Total=(select Max(Total) from cte as cte1 where cte.CustomerID=cte1.CustomerID)






DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1; 

IF @Check_Prime < 2
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0; 
            BREAK;
        END
        SET @i = @i + 1;
    END
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';






CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');



select * from Device




;with cte as(
select *, 
(Select count(locations) from device as dev where dev.Device_id=device.Device_id and dev.Locations=device.Locations) as cnt_loc
from Device
)
select distinct cte.Device_id,cte.Locations, aggregated.cnt_locs,aggregated.cnt_distc_loc from cte

JOIN (select Device_id, count(Locations) as cnt_locs, count(distinct locations) as cnt_distc_loc  from Device group by Device_id) as aggregated
on cte.Device_id=aggregated.Device_id

where cnt_loc=(select max(cnt_loc) from cte as cte1 where cte.Device_id=cte1.Device_id)






drop table Employee



CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);


select * from Employee



select EmpName, Salary, (select avg(Salary) from Employee as emp2 where emp2.DeptID=emp1.DeptID) as avg_salary from Employee as emp1
where Salary>(select avg(Salary) from Employee as emp2 where emp2.DeptID=emp1.DeptID)






CREATE TABLE #WinningNumbers (Number INT);
INSERT INTO #WinningNumbers VALUES (25), (45), (78);

CREATE TABLE #Tickets (
    TicketID VARCHAR(20),
    Number INT
);
INSERT INTO #Tickets VALUES
('A23423', 25), ('A23423', 45), ('A23423', 78),
('B35643', 25), ('B35643', 45), ('B35643', 98),
('C98787', 67), ('C98787', 86), ('C98787', 91);




select * from #WinningNumbers
select * from #Tickets





; WITH MatchCounts AS (
    SELECT 
        T.TicketID,
        COUNT(*) AS MatchCount
    FROM 
        #Tickets T
    INNER JOIN 
        #WinningNumbers W ON T.Number = W.Number
    GROUP BY 
        T.TicketID
)

SELECT 
    SUM(CASE 
        WHEN MatchCount = 3 THEN 100
        WHEN MatchCount IN (1, 2) THEN 10
        ELSE 0
    END) AS TotalWinnings
FROM 
    MatchCounts;





CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);



select * from Spending



; WITH UserPlatformSpend AS (
    SELECT 
        User_id,
        Spend_date,
        SUM(CASE WHEN Platform = 'Mobile' THEN Amount ELSE 0 END) AS MobileSpend,
        SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS DesktopSpend
    FROM Spending
    GROUP BY User_id, Spend_date
),
UserCategory AS (
    SELECT 
        Spend_date,
        CASE 
            WHEN MobileSpend > 0 AND DesktopSpend = 0 THEN 'MobileOnly'
            WHEN DesktopSpend > 0 AND MobileSpend = 0 THEN 'DesktopOnly'
            WHEN MobileSpend > 0 AND DesktopSpend > 0 THEN 'Both'
        END AS Category,
        (MobileSpend + DesktopSpend) AS TotalAmount
    FROM UserPlatformSpend
)

SELECT 
    Spend_date,
    Category,
    COUNT(*) AS TotalUsers,
    SUM(TotalAmount) AS TotalAmountSpent
FROM UserCategory
GROUP BY Spend_date, Category
ORDER BY Spend_date, Category;







CREATE TABLE Grouped (
  Product VARCHAR(50),
  Quantity INT
);

INSERT INTO Grouped VALUES 
('Pencil', 3),
('Eraser', 4),
('Notebook', 2);


select * from Grouped




; WITH Repeater AS (
    SELECT 
        Product,
        Quantity,
        1 AS Occurrence
    FROM Grouped

    UNION ALL

    SELECT 
        Product,
        Quantity,
        Occurrence + 1
    FROM Repeater
    WHERE Occurrence + 1 <= Quantity
)

SELECT Product
FROM Repeater
ORDER BY Product, Occurrence
OPTION (MAXRECURSION 1000);
