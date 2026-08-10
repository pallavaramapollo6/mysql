SHOW DATABASES;
/* Delete and create new database example */
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;

/* SUBQUERIES */
/* Delete and create new tables required */
SHOW TABLES;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS marks;
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(30)
);

INSERT INTO Students VALUES
(1, 'Alice', 'CSE'),
(2, 'Bob', 'ECE'),
(3, 'Charlie', 'EEE'),
(4, 'David', 'CSE'),
(5, 'Eva', 'IT');

CREATE TABLE Marks (
    StudentID INT,
    Marks INT
);

INSERT INTO Marks VALUES
(1, 90),
(2, 85),
(3, 75),
(6, 80);

/* Single row sub query */
SELECT Name
FROM Students
WHERE StudentID = (
    SELECT StudentID
    FROM Marks
    WHERE Marks = 90
);

/* Multiple-row sub query */
SELECT Name
FROM Students
WHERE StudentID IN (
    SELECT StudentID
    FROM Marks
    WHERE Marks > 80
);

/* Correlated sub query */
SELECT Name 
FROM Students S
WHERE EXISTS (
    SELECT *
    FROM Marks M
    WHERE S.StudentID = M.StudentID
); 

/* Subquery in FROM Clause */
SELECT AVG(Marks)
FROM (
    SELECT Marks
    FROM Marks
    WHERE Marks > 60
) AS Result;

/* SET Operations */
DROP TABLE IF EXISTS Students2024;
DROP TABLE IF EXISTS Students2025;
CREATE TABLE Students2024 (
    StudentID INT,
    Name VARCHAR(50)
);

INSERT INTO Students2024 VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

CREATE TABLE Students2025 (
    StudentID INT,
    Name VARCHAR(50)
);

INSERT INTO Students2025 VALUES
(3, 'Charlie'),
(4, 'David'),
(5, 'Eva'),
(6, 'Frank');

/* UNION */
SELECT Name FROM Students2024
UNION
SELECT Name FROM Students2025;

/* UNION ALL */
SELECT Name FROM Students2024
UNION ALL
SELECT Name FROM Students2025;

/* INTERSECT (Not supported in MYSQL, instead IN is used) */
SELECT DISTINCT Name
FROM Students2024
WHERE Name IN (
    SELECT Name
    FROM Students2025
);

/* EXCEPT (Not supported in MYSQL, instead NOT IN is used) */
SELECT DISTINCT Name
FROM Students2024
WHERE Name NOT IN (
    SELECT Name
    FROM Students2025
);

/* Common Table Expression (CTE) */
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(30),
    Salary DECIMAL(10,2)
);
INSERT INTO Employees (EmpID, Name, Department, Salary) VALUES
(101, 'John',   'HR',      50000),
(102, 'Alice',  'IT',      70000),
(103, 'Bob',    'IT',      65000),
(104, 'Emma',   'HR',      55000),
(105, 'David',  'Finance', 80000),
(106, 'Sophia', 'Finance', 75000),
(107, 'James',  'IT',      70000),
(108, 'Olivia', 'HR',      48000),
(109, 'Liam',   'Finance', 72000),
(110, 'Noah',   'IT',      62000);

/* To check the average salary */
/* IF MySQL version is 8.0+
SELECT VERSION();
WITH AvgSalary AS (
    SELECT AVG(Salary) AS Avg_Sal
    FROM Employees
) SELECT * FROM AvgSalary;
*/
/* IF MySQL version is 5.7 or older */
SELECT *
FROM (
    SELECT AVG(Salary) AS Avg_Sal
    FROM Employees
) AS AvgSalary;

/* Find employees earning more than the average salary  */
/* IF MySQL version is 8.0+
SELECT VERSION();
WITH AvgSalary AS
(
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT
    e.EmpID,
    e.Name,
    e.Department,
    e.Salary
FROM Employees e
CROSS JOIN AvgSalary a
WHERE e.Salary > a.AvgSalary;
*/
/* IF MySQL version is 5.7 or older */
SELECT
    e.EmpID,
    e.Name,
    e.Department,
    e.Salary
FROM Employees e
CROSS JOIN (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
) a
WHERE e.Salary > a.AvgSalary;

/* Window Functions */
/* ROW_NUMBER() - Assigns a unique sequential number. */
SELECT Name, Salary,
       ROW_NUMBER() OVER(ORDER BY Salary DESC) AS RowNum
FROM Employees;

/* RANK() - Gives the same rank to ties, leaving gaps. */
SELECT Name,
       Salary,
       RANK() OVER(ORDER BY Salary DESC) AS Ranks
FROM Employees;

/* DENSE_RANK() - Same rank for ties but no gaps. */
SELECT Name,
       Salary,
       DENSE_RANK() OVER(ORDER BY Salary DESC) AS DenseRank
FROM Employees;

/* LAG() - Returns the previous row's value. */
SELECT
    Name,
    Salary,
    LAG(Salary) OVER(ORDER BY Salary) AS PreviousSalary
FROM Employees;

/* LEAD() - Returns the next row's value. */
SELECT
    Name,
    Salary,
    LEAD(Salary) OVER(ORDER BY Salary) AS NextSalary
FROM Employees;

/* SUM() OVER() - Calculates a running total. */
SELECT
    Name,
    Salary,
    SUM(Salary) OVER(ORDER BY Salary) AS RunningTotal
FROM Employees;

/* AVG() OVER() - Calculates a moving or partitioned average. */
SELECT
	Name,
    Department,
    Salary,
    AVG(Salary) OVER(ORDER BY Salary) AS AvgDeptSalary
FROM Employees;

SELECT
    Name,
    Department,
    Salary,
    AVG(Salary) OVER(PARTITION BY Department) AS AvgDeptSalary
FROM Employees;

/* Views */
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(30),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(101,'John','HR',50000),
(102,'Alice','IT',70000),
(103,'Bob','IT',65000),
(104,'Emma','HR',55000),
(105,'David','Finance',80000),
(106,'Sophia','Finance',75000);

/* Creating a view */
CREATE VIEW vw_ITEmployees
AS
SELECT EmpID, Name, Salary
FROM Employees
WHERE Department = 'IT';

/* Using a view */
SELECT *
FROM vw_ITEmployees;

/* Updating Through a View */
UPDATE vw_ITEmployees
SET Salary = 72000
WHERE EmpID = 102;

/* Note: The data in the Employees table is also updated. */
SELECT *
FROM vw_ITEmployees
WHERE EmpID = 102;

/* Dropping a View */
DROP VIEW vw_ITEmployees;

/* Indexes */
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO Customers VALUES
(1,'John','New York'),
(2,'Alice','Chicago'),
(3,'David','Boston'),
(4,'Emma','Chicago'),
(5,'Sophia','Seattle');

/* Create an index */
CREATE INDEX IX_Customers_City
ON Customers(City);

/* Query using the index */
SELECT *
FROM Customers
WHERE City = 'Chicago';

/* Drop an index */
DROP INDEX IX_Customers_City
ON Customers;

/* Query Performance Basics */
/* 1. Use Index properly */
CREATE INDEX idx_employee_name
ON employees(name);

SELECT * FROM employees
WHERE name = 'John';

/* 2. Select Only Required Columns */
/* Avoid using, */
SELECT * FROM employees;
/* Instead */
SELECT EmpID, Name, Salary
FROM employees;

/* 3. Filter Data Efficiently */
/* Use WHERE clauses to reduce the number of rows processed. */
SELECT name
FROM employees
WHERE department = 'HR';

/* 4. Use EXPLAIN */
/* EXPLAIN shows how MySQL executes a query. */
EXPLAIN
SELECT *
FROM employees
WHERE department = 'Sales';

/* 5. Avoid Full Table Scans */
/* (type = ALL, key=null, rows=6) */
EXPLAIN
SELECT *
FROM Employees
WHERE Salary > 50000;

/* create an index */
CREATE INDEX idx_salary
ON employees(salary);

/* Check (type = range, key=idx_salary, rows=5) */
EXPLAIN
SELECT *
FROM Employees
WHERE Salary > 50000;

/* 6. Use LIMIT When Appropriate */
/* Instead of
 * SELECT * FROM employees;
 */
SELECT *
FROM employees
LIMIT 10;

/* 7. Optimize JOINs */
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (id, department_name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT
);

INSERT INTO employees (id, name, department_id)
VALUES
(101, 'Arun', 1),
(102, 'Priya', 2),
(103, 'Ravi', 1),
(104, 'Sneha', 3),
(105, 'Kiran', 4);

/* Create an index for department_id */
CREATE INDEX idx_employees_department_id
ON employees(department_id);

/* Join Query */
SELECT e.name, d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.id;

/* Check with EXPLAIN */
EXPLAIN
SELECT e.name, d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.id;

/* 8. Avoid functions on indexed columns */
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE,
    salary DECIMAL(10,2)
);

INSERT INTO employees (id, name, join_date, salary)
VALUES
(101, 'Arun',  '2023-05-15', 45000),
(102, 'Priya', '2024-01-10', 55000),
(103, 'Ravi',  '2024-03-25', 60000),
(104, 'Sneha', '2024-07-18', 52000),
(105, 'Kiran', '2024-12-31', 65000),
(106, 'Meena', '2025-01-05', 58000),
(107, 'Vijay', '2025-06-20', 62000);

CREATE INDEX idx_employees_join_date
ON employees(join_date);

EXPLAIN SELECT *
FROM employees
WHERE YEAR(join_date) = 2024;

EXPLAIN SELECT *
FROM employees
WHERE join_date >= '2024-01-01'
  AND join_date < '2025-01-01';

/* 9. Use Appropriate Data Types */
/* POOR CHOICE */
CREATE TABLE employees (
    id CHAR(10),
    age INT,
    join_date VARCHAR(20),
    salary VARCHAR(20)
);

/* BETTER CHOICE */
CREATE TABLE employees (
    id INT PRIMARY KEY,
    age TINYINT,
    join_date DATE,
    salary DECIMAL(10,2)
);

/* 10. Avoid Unnecessary DISTINCT */
/* POOR */
SELECT DISTINCT id
FROM employees;

/* BETTER */
SELECT id
FROM employees;

/* Stored Procedures */
DELIMITER //

CREATE PROCEDURE GetEmployees()
BEGIN
    SELECT * FROM employees;
END //

DELIMITER ;

/* Calling the procedure */
CALL GetEmployees();

/* Procedure with Parameters */
DELIMITER //

CREATE PROCEDURE GetEmployeeByDept(IN dept VARCHAR(50))
BEGIN
    SELECT *
    FROM employees
    WHERE department = dept;
END //

DELIMITER ;
/* Execute */
CALL GetEmployeeByDept('HR');

/* FUNCTIONS */
DELIMITER //

CREATE FUNCTION AnnualSalary(monthly_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END //

DELIMITER ;

/* Using the function */
SELECT
    name,
    AnnualSalary(salary) AS annual_salary
FROM employees;

/* Trigger */
/* BEFORE INSERT Trigger */
DELIMITER //

CREATE TRIGGER check_salary
BEFORE INSERT
ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 0 THEN
        SET NEW.salary = 0;
    END IF;
END //

DELIMITER ;

/* If someone inserts, */
INSERT INTO employees(EmpId, name, salary)
VALUES (111, 'John', -5000);

/* Example 2: AFTER INSERT Trigger */
/* Create an audit table, */
CREATE TABLE employee_log
(
    emp_id INT,
    action_time DATETIME
);
/* TRIGGER */
DELIMITER //

CREATE TRIGGER log_employee
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_log
    VALUES (NEW.EmpId, NOW());
END //

DELIMITER ;

/* If someone inserts, */
INSERT INTO employees(EmpId, name, salary)
VALUES (112, 'John', -5000);

/* Check the audit log */
SELECT * FROM employee_log;

/* Another Example */
/* Create an audit table for salary history */
CREATE TABLE salary_history
(
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10, 2)
);

/* Trigger for table update */
DELIMITER //
CREATE TRIGGER salary_update
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_history(emp_id, old_salary, new_salary)
    VALUES (OLD.EmpId, OLD.salary, NEW.salary);
END //

DELIMITER ;

/* Update the table */
UPDATE employees
SET salary = 10000
WHERE EmpId = 111;

/* Check the salary_history audit table */
SELECT * FROM salary_history;

/* Transaction Control Language */

/* Create a table */
DROP TABLE IF EXISTS Student;
CREATE TABLE Student
(
    ID INT PRIMARY KEY,
    NAME VARCHAR(30),
    Age INT
);
/* COMMIT EXAMPLE */
START TRANSACTION;

INSERT INTO Student (ID, Name, Age)
VALUES (101, 'Alice', 20);
 
INSERT INTO Student (ID, Name, Age)
VALUES (102, 'Bob', 21);
 
SAVEPOINT sp1;
 
INSERT INTO Student (ID, Name, Age)
VALUES (103, 'Charlie', 22);
/* Check the table for entries */
SELECT * FROM Student;
/*
 * Records 101 and 102 remain.
 * Record 103 is undone.
 */
ROLLBACK TO sp1;
/* Check the table for entries */
SELECT * FROM Student;
/* Changes up to SAVEPOINT sp1
 * (records 101 and 102) are permanently saved.
 */
COMMIT;

/* UPDATE & ROLLBACK Example */
START TRANSACTION;
 
UPDATE Student
SET Age = 25
WHERE ID = 101;

/* Check the table for entries */
SELECT * FROM Student;

/* The update is canceled, and the original data is restored */
ROLLBACK;

/* Check the table for entries */
SELECT * FROM Student;

/* UPDATE & COMMIT & ROLLBACK Example*/
START TRANSACTION;
 
UPDATE Student
SET Age = 25
WHERE ID = 101;

/*
 * Once a transaction is committed,
 * the changes cannot be undone using ROLLBACK
 */
COMMIT;

/* Check the table for entries */
SELECT * FROM Student;

ROLLBACK;
/* Check the table for entries */
SELECT * FROM Student;