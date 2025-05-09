create database Class_2


create table Employees(EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))
select * from Employees
insert into Employees(EmpID, Name, Salary) values
(10, 'Bekzod', 5000), 
(11, 'Sherzod', 6000), 
(12, 'Dilshod', 4000)

select * from Employees
update Employees
set Salary=7000
where EmpID=10

select * from Employees
delete from Employees
where EmpID=11

/*5. delete- is used to delete selected information in the table.
truncate- is used to delete all the information in the table while keeping the structure of table.
drop - is used to delete the whole table and information in it.*/
 
alter table Employees
alter column Name varchar(100)

alter table Employees
add Department varchar(50)
select * from Employees
alter table Employees
alter column Salary float

create table Departments(DepartmentID int, DepartmentName varchar(50))
select* from Departments

truncate table Employees

select * from Employees

alter table Departments
add Salary float
select* from Departments

insert into Departments(DepartmentID, DepartmentName, Salary) values
(1, 'Management', 4000),
(2, 'HR', 3500),
(3, 'Accountancy', 5200),
(4, 'Producing', 4700),
(5, 'Marketing', 6000)
select* from Departments

update Departments
set DepartmentName='Management'
where Salary>5000
select* from Departments

truncate table Employees
select * from Employees

alter table Employees
drop column Department
select * from Employees

sp_rename 'Employees','StaffMembers';  
select * from StaffMembers
drop table Departments
select * from Departments

create table Products(ProductID int, ProductName VARCHAR(50), Category VARCHAR(50), Price DECIMAL(10,2), ProducedCountry varchar(30))
select * from Products

ALTER TABLE Products ADD CONSTRAINT CHK_Price CHECK (Price > 0)

alter table Products
add StockQuantity float
alter table Products
alter column StockQuantity int
ALTER TABLE Products
ADD CONSTRAINT CHK_Price
DEFAULT {50} FOR StockQuantity

exec sp_rename 'Products.Category', 'ProductCategory', 'column'
select * from Products
insert into Products(ProductID, ProductName, ProductCategory, Price, ProducedCountry, StockQuantity) values
(1, 'phone', 'technology', 1000, 'USA', 20),
(2, 'car', 'transport', 50000, 'Japan', 30),
(3, 'vacumcleaner', 'householding', 500, 'China', 5),
(4, 'coffee', 'foods', 100, 'Brasil', 3),
(5, 'computor', 'technology', 2000, 'Germany', 25)
select * from Products

select * into Products_Backup from Products
select * from Products_Backup

sp_rename 'Products','Inventory';

select * from Inventory
alter table Inventory
alter column Price float;


