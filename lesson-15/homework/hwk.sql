create database Lesson_15
go
use Lesson_15



CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);


select * from employees
where salary=(select min(salary) from employees)




CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);


select * from products
where price>(select avg(price) from products)




drop table employees


CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);





select emp.name, dep.department_name from employees as emp
join departments as dep
on emp.department_id=dep.id
where dep.department_name='Sales'






select emp.name, (select department_name from departments as dep where dep.id=emp.department_id and dep.department_name='Sales' ) as dep_name from employees as emp
where (select department_name from departments as dep where dep.id=emp.department_id and dep.department_name='Sales') is not null






CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);


select * from customers
select * from orders


select *, (select count(ord.order_id) from Orders as ord where cust.customer_id=ord.order_id) as num_of_order from customers as cust
where (select count(ord.order_id) from Orders as ord where cust.customer_id=ord.order_id) =0




select * from customers
where customer_id not in (select distinct customer_id from orders)



drop table products


CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);


select *, (select max(price) from products as b where a.category_id=b.category_id) as max_price from products as a





drop table employees
drop table departments



CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);



select * from employees
select * from departments



select *, (select avg(salary) from employees as emp where dep.id=emp.department_id) as avg_salary from departments as dep





SELECT *
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);






select dep.department_name, avg(emp.salary) as avg_salary from employees as emp
join departments as dep
on emp.department_id=dep.id
group by dep.department_name




drop table employees




CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);



select * from employees as a
where salary>(select avg(salary) from employees as b where a.department_id=b.department_id)



drop table employees


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);



select * from students
select * from grades





select student_id, max(grade) from grades
where student_id in (select student_id from students)
group by student_id 




SELECT name, student_id,
	(SELECT max(grade) FROM grades
 	WHERE student_id = st.student_id) as max_sale_price
FROM students as st
 




drop table products




CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);


select * from products



select *, (select count(distinct price) from products as B where A.price<=B.price and A.category_id=B.category_id) as highest_ranking from products as A
where 3= (select count(distinct price) from products as B where A.price<=B.price)





drop table employees




CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);




select * from employees

SELECT *
FROM Employees as E1
WHERE Salary BETWEEN
    (SELECT AVG(Salary) FROM Employees) AND
    (SELECT MAX(Salary) 
     FROM Employees AS E2 
     WHERE E2.department_id = E2.department_id);
