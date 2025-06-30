create database Lesson_22
go
use Lesson_22





CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')







select * from sales_data




select *,
sum(total_amount) over (partition by customer_id order by total_amount) as running_total
from sales_data





select *,
count(quantity_sold) over (partition by product_category order by quantity_sold) as num_of_quantity
from sales_data






select *,
max(total_amount) over (partition by product_category order by total_amount desc) as max_total_amount
from sales_data








select *,
min(unit_price) over (partition by product_category order by total_amount desc) as min_total_amount
from sales_data







select *,
avg(total_amount) over (order by order_date rows between 1 preceding and 1 following) as avg_last_3days
from sales_data






select *,
sum(total_amount) over (partition by region) as total_amount_per_region
from sales_data





select *, 
DENSE_RANK() over (order by total_amount desc) as customer_rank
from sales_data






; with cte as (
select *,
lag(total_amount) over (partition by customer_id order by order_date) as Previous_day
from sales_data
)
select *, (total_amount-Previous_day) as differences from cte




; with cte as (
select *, 
RANK() over (partition by product_category order by total_amount desc) as top_rank
from sales_data
) 
select * from cte
where top_rank<=3






SELECT *,
SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;






SELECT *,
SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sales_category
FROM sales_data







SELECT *,
SUM(total_amount) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS sum_of_preview_values
FROM sales_data






CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);




select * from OneColumn




SELECT *,
SUM([Value]) OVER (ORDER BY [Value] ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS sum_of_preview_values
FROM OneColumn






SELECT 
    customer_id,
    customer_name,
    COUNT(DISTINCT product_category) AS unique_categories
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;






; with cte as (
select *,
avg(total_amount) over (partition by region) as avg_sale
from sales_data
)
select * from cte
where total_amount>avg_sale






select *,
DENSE_RANK() over (partition by region order by total_amount desc) as ranking
from sales_data






select *,
sum(total_amount) over (partition by customer_id order by order_date) as running_total
from sales_data






; with cte as (
select *,
lag(total_amount) over (partition by month(order_date) order by month(order_date)) as Previous_day
from sales_data
)
select *, (total_amount-Previous_day) as differences from cte








; WITH cte AS (
    SELECT 
        customer_id,
        customer_name,
        order_date,
        total_amount,
        SUM(total_amount) OVER (PARTITION BY customer_id) AS total_spent,
        FIRST_VALUE(total_amount) OVER (
            PARTITION BY customer_id
            ORDER BY order_date DESC
        ) AS last_order_amount
    FROM sales_data
)
SELECT DISTINCT 
    customer_id,
    customer_name,
    total_spent,
    last_order_amount
FROM cte
WHERE total_spent > last_order_amount;






; with cte as (
select *,
avg(total_amount) over () as avg_sale
from sales_data
)
select * from cte
where total_amount>avg_sale







CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);


select * from MyData





SELECT *,
    CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS GroupTotal
FROM MyData;







CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);




select * from TheSumPuzzle







SELECT 
    ID,
    SUM(Cost) AS TotalCost,
    SUM(DISTINCT Quantity) AS TotalQuantity
FROM TheSumPuzzle
GROUP BY ID;






CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 




select * from Seats






; WITH RankedSeats AS (
 SELECT SeatNumber,
 ROW_NUMBER() OVER (ORDER BY SeatNumber) AS rn
 FROM Seats
)
SELECT MIN(SeatNumber) AS StartSeat, MAX(SeatNumber) AS EndSeat
FROM RankedSeats
GROUP BY (SeatNumber - rn)
HAVING COUNT(*) > 1;
