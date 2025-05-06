   --- HOMEWORK---
	--EASY--
/*1. Data is a collection of facts, information, and statistics and this can be in various forms such as numbers, text, sound, images, or any other format.
A database is an organized collection of structured information, or data, typically stored electronically in a computer system.
A relational database is a type of database that stores and provides access to data points that are related to one another.
A table is a structured collection of data organized into rows and columns, much like a spreadsheet. Each row represents a unique record or entry, and each column represents a field or attribute associated with that record. 

2. Key features of SQL Server:

a) Data Retrieval: SQL Server allows users to query data from tables and perform aggregations, sorting, and filtering to extract specific information. 
b) Data Modification: Users can modify data within tables, including inserting, updating, and deleting records. 
c) Data Integrity: SQL Server enforces data integrity through constraints like primary keys, foreign keys, and unique constraints. 
d) Always On Availability Groups: This feature provides high availability and disaster recovery by creating replicas of databases on different servers. 
e) Data Warehousing: SQL Server can be used for data warehousing, allowing users to store and analyze large amounts of historical data. 

3. There are two possible modes: 
   --Windows Authentication mode 
   --Mixed mode.
   Windows Authentication mode enables Windows Authentication and disables SQL Server Authentication. Mixed mode enables both Windows Authentication and SQL Server Authentication.
   Windows Authentication is always available and can't be disabled.*/

            -- MEDIUM--

4. create database SchoolIDB
use SchoolIDB

5. create table Students(StudentID int, Name varchar(50), Age int)
select * from Students

--6. SQL Server and SQL Server Management Studio (SSMS) are two different things, although they are often confused with each other.

--SQL Server is a relational database management system (RDBMS) developed by Microsoft. It is used to store, manage, and retrieve data. SQL Server uses SQL (Structured Query Language) to interact with the database.
--SQL Server Management Studio (SSMS) is a graphical user interface (GUI) tool for managing Microsoft SQL Server. It allows you to create, manage, and administer SQL Server databases and objects. SSMS also includes a query editor that you can use to write and execute SQL queries.
--The main difference between SQL Server and SSMS is that SQL Server is a database management system, while SSMS is a GUI tool for managing a database management system. SQL Server can be used with any GUI tool, but SSMS is specifically designed for Microsoft SQL Server.
--Both SQL Server and MySQL include feature-rich client applications (SSMS and MySQL Workbench, respectively). However, SSMS comes with more features, including security, reporting, analysis, and a powerful execution plan visualizer to find and fix bottlenecks.

              --HARD--
/*7. The difference of DDL, DML, DCL, TCL, and DQL Commands

Category	                Full Form	                                               Common Commands
 DDL     	                Data Definition Language	                               CREATE, ALTER, DROP, TRUNCATE, RENAME
 DML	                    Data Manipulation Language	                               SELECT, INSERT, UPDATE, DELETE
 DCL	                    Data Control Language	                                   GRANT, REVOKE
 TCL	                    Transaction Control Language	                           COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION*/

 8. insert into Students(StudentID, Name, Age)
	values
	(1, 'Dilmurod', 33),
	(2, 'Abror', 23),
	(3, 'Axror', 21)
	select * from Students
	truncate table Students
	select * from Students
	insert into Students(StudentID, Name, Age)
	values
	(1, 'Dilmurod', 33),
	(2, 'Abror', 23),
	(3, 'Axror', 21)