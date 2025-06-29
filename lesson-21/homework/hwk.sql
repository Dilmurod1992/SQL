create database Lesson21
go
use Lesson21





CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);
INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 148.00, 2, 101),
(2, 'Product B', '2023-01-02', 202.00, 3, 102),
(3, 'Product C', '2023-01-03', 248.00, 1, 103),
(4, 'Product A', '2023-01-04', 149.50, 4, 101),
(5, 'Product B', '2023-01-05', 203.00, 5, 104),
(6, 'Product C', '2023-01-06', 252.00, 2, 105),
(7, 'Product A', '2023-01-07', 151.00, 1, 101),
(8, 'Product B', '2023-01-08', 205.00, 8, 102),
(9, 'Product C', '2023-01-09', 253.00, 7, 106),
(10, 'Product A', '2023-01-10', 152.00, 2, 107),
(11, 'Product B', '2023-01-11', 207.00, 3, 108),
(12, 'Product C', '2023-01-12', 249.00, 1, 109),
(13, 'Product A', '2023-01-13', 153.00, 4, 110),
(14, 'Product B', '2023-01-14', 208.50, 5, 111),
(15, 'Product C', '2023-01-15', 251.00, 2, 112),
(16, 'Product A', '2023-01-16', 154.00, 1, 113),
(17, 'Product B', '2023-01-17', 210.00, 8, 114),
(18, 'Product C', '2023-01-18', 254.00, 7, 115),
(19, 'Product A', '2023-01-19', 155.00, 3, 116),
(20, 'Product B', '2023-01-20', 211.00, 4, 117),
(21, 'Product C', '2023-01-21', 256.00, 2, 118),
(22, 'Product A', '2023-01-22', 157.00, 5, 119),
(23, 'Product B', '2023-01-23', 213.00, 3, 120),
(24, 'Product C', '2023-01-24', 255.00, 1, 121),
(25, 'Product A', '2023-01-25', 158.00, 6, 122),
(26, 'Product B', '2023-01-26', 215.00, 7, 123),
(27, 'Product C', '2023-01-27', 257.00, 3, 124),
(28, 'Product A', '2023-01-28', 159.50, 4, 125),
(29, 'Product B', '2023-01-29', 218.00, 5, 126),
(30, 'Product C', '2023-01-30', 258.00, 2, 127);




select * from ProductSales


select *,
ROW_NUMBER() over (order by SaleAmount desc) as rw
from ProductSales




select *,
ROW_NUMBER() over (partition by ProductName order by SaleAmount desc) as rw
from ProductSales




select *,
DENSE_RANK() over (partition by ProductName order by Quantity desc) as rnk
from ProductSales




; with cte as (
select *,
ROW_NUMBER() over (partition by CustomerID order by SaleAmount desc) as top_sale
from ProductSales
)
select * from cte
where top_sale=1






select *,
lead(SaleAmount) over (order by SaleDate) as next_day
from ProductSales





select *,
lead(SaleAmount) over (partition by ProductName order by SaleDate) as next_day
from ProductSales






select *,
lag(SaleAmount) over (order by SaleDate) as Previous_day
from ProductSales




select *,
lag(SaleAmount) over (partition by ProductName order by SaleDate) as Previous_day
from ProductSales



; with cte as (
select *,
lag(SaleAmount) over (order by SaleDate) as Previous_day
from ProductSales
)
select * from cte
where SaleAmount>Previous_day








; with cte as (
select *,
lag(SaleAmount) over (partition by ProductName order by SaleDate) as Previous_day
from ProductSales
)
select *, (SaleAmount-Previous_day) as difference from cte






; with cte as (
select *,
lead(SaleAmount) over (order by SaleDate) as next_day
from ProductSales
)
select *, concat(cast(next_day*100/SaleAmount as decimal(10,2)), ' ', '%') as difference from cte






; with cte as (
select *,
lead(SaleAmount) over (partition by ProductName order by SaleDate) as next_day
from ProductSales
)
select *, (concat(cast(next_day*100/SaleAmount as decimal(10,2)), ' ', '%')) as ratio from cte






select * from ProductSales



; with cte as (
select *,
FIRST_VALUE(SaleAmount) over (partition by ProductName order by SaleDate) as first_day
from ProductSales
)
select *, (SaleAmount-first_day) as diff from cte





; with cte as (
select *,
lag(SaleAmount) over (partition by ProductName order by SaleDate) as Previous_day
from ProductSales
)
select * from cte
where SaleAmount>Previous_day





select *,
sum(SaleAmount) over (partition by ProductName order by SaleDate) as running_total
from ProductSales




select *,
avg(SaleAmount) over (order by SaleDate rows between 2 preceding and current row) as avg_last_3rows
from ProductSales




; with cte as (
select *,
avg(SaleAmount) over () as avg_sale
from ProductSales
)
select *, cast((SaleAmount-avg_sale) as decimal (10,2)) as difference from cte






CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');




select * from Employees1




select *,
rank() over (order by Salary desc) as ranking
from Employees1






; with cte as (
select *,
rank() over (partition by Department order by Salary desc) as ranking
from Employees1
)
select * from cte
where ranking<=2




select *,
last_value(Name) over (partition by Department order by Salary desc rows between unbounded preceding and unbounded following) as lowest_paid_employee
from Employees1





select *,
sum(Salary) over (partition by Department order by Salary) as running_total
from Employees1





select *,
sum(Salary) over (partition by Department) as total_sale
from Employees1







select *,
avg(Salary) over (partition by Department) as avg_sale
from Employees1





; with cte as (
select *,
avg(Salary) over (partition by Department) as avg_sale
from Employees1
)
select *, cast((Salary-avg_sale) as decimal (10,2)) as [difference] from cte








select *,
avg(Salary) over (order by Salary rows between 1 preceding and 1 following) as avg_3employees
from Employees1






select *,
sum(Salary) over (order by HireDate desc rows between current row and 2 following) as total_salary_of_last_3
from Employees1
