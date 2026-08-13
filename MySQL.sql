/* Database management */
/* Delete and create new database example */
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;

/* Viewing Databases */
SHOW DATABASES;

/* Selecting a Database */
USE example;

/* Deleting a Database */
DROP DATABASE example;

/* Rename a Database */
/* Create a new database */
DROP DATABASE example;
CREATE DATABASE example_new;

/* Take dump of old database using mysqldump */
/* mysqldump -u username -p example > backup.sql */

/* Restore it with mysql command with new database */
/* mysql -u username -p example_new < backup.sql */

DROP DATABASE old_database_name;

/* Table Management */
/* Create & Display all tables */

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) UNIQUE,
    Department VARCHAR(30),
    Salary DECIMAL(10, 2),
    City VARCHAR(30)
);

SHOW TABLES;

/* View table structure */
DESCRIBE Employee;

/* View create table statement */
SHOW CREATE TABLE Employee;

/* DDL (Data Definition Language) */
/* CREATE */
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (ID INT, Name VARCHAR(50));

/* ALTER */
ALTER TABLE Student ADD Age INT;
ALTER TABLE Student RENAME COLUMN Age to AgeValue;
ALTER TABLE Student DROP COLUMN AgeValue;

/* RENAME */
RENAME TABLE Student TO Students;

/* TRUNCATE */
TRUNCATE TABLE Students;

/* DROP */
DROP TABLE Students;

/* Create table with different data types */
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
    student_id INT,
    name VARCHAR(50),
    age TINYINT,
    marks DECIMAL(5,2),
    grade CHAR(1),
    dob DATE,
    login_time TIME,
    created_at DATETIME,
    last_updated TIMESTAMP,
    active BOOLEAN,
    gender ENUM('Male','Female'),
    hobbies SET('Reading','Sports','Music'),
    details TEXT
);

/* Add data into the table */
INSERT INTO Student (
    student_id, name, age, marks, grade, dob,
    login_time, created_at, active, gender,
    hobbies, details
)
VALUES (
    101,
    'Rahul',
    20,
    89.75,
    'A',
    '2006-05-15',
    '09:15:30',
    '2026-07-24 10:30:00',
    TRUE,
    'Male',
    'Reading,Music',
    '{"city":"Chennai","course":"BCA"}'
);
/* Check the data in the table */
SELECT * FROM Student;

/* Keys and Constraints */
/* UNIQUE CONSTRAINT */
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
	StudentID INT,
	Email VARCHAR(100) UNIQUE
);
/* Success */
INSERT INTO Student VALUES (101, 'john@gmail.com');
/* Error (Duplicate) */
INSERT INTO Student VALUES (102, 'john@gmail.com');
/* Allowed */
INSERT INTO Student VALUES (103, NULL);

/* NOT NULL CONSTRAINT */
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
	StudentID INT,
	Name VARCHAR(50) NOT NULL
);
 
/* Success */
INSERT INTO Student VALUES (101, 'John');
/* Error */
INSERT INTO Student VALUES (102, NULL);

/* CHECK CONSTRAINT */
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
	EmpID INT,
	Age INT CHECK (Age >= 18)
);
/* Success */
INSERT INTO Employee VALUES (101, 25);
/* Error */
INSERT INTO Employee VALUES (102, 16);

/* PRIMARY KEY Constraint */
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
	StudentID INT PRIMARY KEY,
	Name VARCHAR(50)
);
/* Success */
INSERT INTO Student VALUES (101, 'John');
/* Error (Duplicate) */
INSERT INTO Student VALUES (101, 'David');
/* Error (NULL not allowed) */
INSERT INTO Student VALUES (NULL, 'Alice');

/* COMPOSITE */
DROP TABLE IF EXISTS Enrollment;
CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    PRIMARY KEY (StudentID, CourseID)
);

INSERT INTO Enrollment (StudentID, CourseID, EnrollmentDate)
VALUES
(101, 201, '2025-01-10'),
(101, 202, '2025-01-12'),
(102, 201, '2025-01-15'),
(102, 203, '2025-01-18'),
(103, 202, '2025-01-20'),
(104, 201, '2025-01-22'),
(104, 204, '2025-01-25'),
(105, 203, '2025-01-28');

/* ERROR 1062 (23000): Duplicate entry '101-201' for key 'enrollment.PRIMARY' */
INSERT INTO Enrollment (StudentID, CourseID, EnrollmentDate)
VALUES (101, 201, '2025-02-01');

/* FOREIGN KEY Constraint */
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DeptID INT PRIMARY KEY,
	DeptName VARCHAR(50)
);
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
	EmpID INT PRIMARY KEY,
	EmpName VARCHAR(50),
	DeptID INT,
	FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);
 
INSERT INTO Department VALUES (10, 'HR');
INSERT INTO Department VALUES (20, 'Finance');

/* Success */
INSERT INTO Employee VALUES (101, 'John', 10);
/* Error */
INSERT INTO Employee VALUES (102, 'David', 30);

/* DEFAULT Constraint */
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    city VARCHAR(30) DEFAULT 'Chennai'
);

INSERT INTO Employee (emp_id)
VALUES (1), (3);

INSERT INTO Employee (emp_id, city)
VALUES (2, 'Delhi');

INSERT INTO Employee (emp_id, city)
VALUES
(10, DEFAULT),
(20, 'Delhi'),
(30, DEFAULT);

/* AUTO_INCREMENT Constraint */
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50)
);

INSERT INTO Employee (emp_name) VALUE ("Name1");
INSERT INTO Employee (emp_name) VALUE ("Name2");

/* Example of using all constraints */
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DeptID INT PRIMARY KEY,
	DeptName VARCHAR(50)
);
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
	EmpID INT AUTO_INCREMENT PRIMARY KEY,
	EmpName VARCHAR(50) NOT NULL,
	Email VARCHAR(100) UNIQUE,
	Age INT CHECK (Age >= 18),
	DeptID INT,
	city VARCHAR(30) DEFAULT 'Chennai',
	FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

INSERT INTO Department
VALUES
(101, 'HR'),
(102, 'IT');

INSERT INTO Employee (EmpName, Email, Age, DeptID)
VALUES
('Rahul', 'rahul@gmail.com', 22, 101),
('Priya', 'priya@gmail.com', 25, 102);

/* DML (Data Manipulation Language) */
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
	ID INT PRIMARY KEY,
	Name VARCHAR(50),
    Age INT
);
/* Insert */
INSERT INTO Student (ID, Name, Age) VALUES (1, 'John', 20);

/* Update */
UPDATE Student SET Age = 21 WHERE ID = 1;

/* Delete */
DELETE FROM Student WHERE ID = 1;

/* DQL (Data Query Language) */
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DeptID INT PRIMARY KEY,
	DeptName VARCHAR(50)
);
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
	EmpID INT AUTO_INCREMENT PRIMARY KEY,
	EmpName VARCHAR(50) NOT NULL,
	Email VARCHAR(100) UNIQUE,
	Age INT CHECK (Age >= 18),
	DeptID INT,
	city VARCHAR(30) DEFAULT 'Chennai',
	FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

INSERT INTO Employee (EmpName, Email, Age, DeptID, City)
VALUES
('Rahul', 'rahul@gmail.com', 22, 101, 'Chennai'),
('Priya', 'priya@gmail.com', 25, 102, 'Delhi'),
('Amit', 'amit@gmail.com', 28, 101, 'Mumbai'),
('Anitha', 'anitha@gmail.com', 24, 103, 'Chennai'),
('Raj', 'raj@gmail.com', 30, 102, 'Delhi'),
('Ravi', 'ravi@gmail.com', 27, 101, 'Mumbai'),
('Sneha', 'sneha@gmail.com', 21, 103, 'Chennai'),
('Vijay', 'vijay@gmail.com', 35, 102, 'Delhi'),
('Kiran', 'kiran@gmail.com', 26, 101, 'Mumbai'),
('Meena', 'meena@gmail.com', 29, 103, 'Chennai');

/* FILTERING DATA */
/* Merge from other system */

/* MySQL Functions and Expressions */
/* Numeric functions */
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2)
);

INSERT INTO products (id, product_name, price, quantity, discount)
VALUES
(1, 'Laptop', 54999.75, 5, 10.50),
(2, 'Mouse', 799.40, 12, 5.25),
(3, 'Keyboard', 1499.60, 7, 7.75),
(4, 'Monitor', 12999.90, 3, 12.50),
(5, 'Headphones', 2499.25, 8, 15.00);

/* ABS() — Absolute value (Returns the positive value of a number.) */
SELECT product_name, ABS(price - 3000) AS price_difference
FROM products;

/* CEIL() — Round up (Returns the smallest integer greater than or equal to the number.) */
SELECT product_name, price, CEIL(price) AS rounded_price
FROM products;

/* FLOOR() — Round down (Returns the largest integer less than or equal to the number.) */
SELECT product_name, price, FLOOR(price) AS rounded_price
FROM products;

/* ROUND() — Round to specified decimal places */
SELECT
    product_name,
    price,
    discount,
    ROUND(price - (price * discount / 100), 2) AS final_price
FROM products;

/* MOD() — Remainder */
/* Check whether product quantity is even or odd. */
SELECT
    product_name,
    quantity,
    CASE
        WHEN MOD(quantity, 2) = 0 THEN 'Even'
        ELSE 'Odd'
    END AS quantity_type
FROM products;

/* POWER() — Raise a number to a power */
SELECT
    product_name,
    quantity,
    POWER(quantity, 2) AS quantity_squared
FROM products;

/* SQRT() — Square root */
SELECT
    product_name,
    quantity,
    SQRT(quantity) AS quantity_square_root
FROM products;

/* RAND() — Random number */
/* Generate a random number for every product */
SELECT
    product_name,
    FLOOR(1 + RAND() * 100) AS random_number
FROM products;

/* String functions */
/* UPPER  -  to be merged from other system */
/* LOWER — Convert text to lowercase */
SELECT EmpName, LOWER(EmpName) AS LowerName
FROM Employee;

/* LENGTH() — Find the length of employee names */
SELECT EmpName, LENGTH(EmpName) AS NameLength
FROM Employee;

/* CONCAT() — Combine strings */
SELECT EmpName,
       CONCAT(EmpName, ' lives in ', City) AS EmployeeDetails
FROM Employee;

/* SUBSTRING() — Extract part of the name */
SELECT EmpName,
       SUBSTRING(EmpName, 1, 3) AS FirstThree
FROM Employee;

/* REPLACE() — Replace text  */
SELECT Email,
       REPLACE(Email, '@gmail.com', '@company.com') AS CompanyEmail
FROM Employee;

/* TRIM() — Remove extra spaces */
SELECT EmpName,
       TRIM(EmpName) AS TrimmedName
FROM Employee;

/* LEFT() — Get characters from the beginning */
SELECT EmpName,
       LEFT(EmpName, 2) AS FirstTwo
FROM Employee;

/* RIGHT() — Get characters from the end */
SELECT EmpName,
       RIGHT(EmpName, 2) AS LastTwo
FROM Employee;

/* Date and Time Functions */


/* NULL Functions */

/* MySQL Expressions Examples */
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employee (EmpID, EmpName, Salary)
VALUES
(101, 'Alice',   45000),
(102, 'Bob',     55000),
(103, 'Charlie', 70000),
(104, 'David',   48000),
(105, 'Emma',    62000);

/* Display existing and new salary */
SELECT
    EmpName,
    Salary,
    Salary * 1.10 AS NewSalary
FROM Employee;

SELECT
EmpName,
Salary,
CASE
    WHEN Salary>=50000 THEN 'High'
    ELSE 'Normal'
END AS Category
FROM Employee;


/* Aggregate Functions and Grouping (DQL) */
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(30),
    Designation VARCHAR(30),
    Salary DECIMAL(10,2),
    HireDate DATE
);

INSERT INTO Employee (EmpID, EmpName, Department, Designation, Salary, HireDate)
VALUES
(101, 'John',    'IT',      'Developer', 55000.00, '2022-01-15'),
(102, 'Mary',    'HR',      'HR Manager', 60000.00, '2021-03-20'),
(103, 'David',   'Finance', 'Accountant', 48000.00, '2020-07-10'),
(104, 'Sarah',   'IT',      'Team Lead', 75000.00, '2019-11-05'),
(105, 'James',   'Sales',   'Sales Executive', 42000.00, '2023-02-18'),
(106, 'Priya',   'IT',      'Developer', 58000.00, '2022-09-01'),
(107, 'Rahul',   'Finance', 'Financial Analyst', 52000.00, '2021-12-12'),
(108, 'Anita',   'HR',      'Recruiter', 45000.00, '2023-06-25'),
(109, 'Karthik', 'Sales',   'Sales Manager', 68000.00, '2020-04-08'),
(110, 'Neha',    'Marketing', 'Marketing Executive', 50000.00, '2024-01-10');

SELECT
COUNT(*) AS Employees,
SUM(Salary) AS TotalSalary,
AVG(Salary) AS AverageSalary,
MIN(Salary) AS LowestSalary,
MAX(Salary) AS HighestSalary
FROM Employee;

SELECT
Department,
COUNT(*) AS Employees,
SUM(Salary) AS TotalSalary,
AVG(Salary) AS AverageSalary,
MIN(Salary) AS LowestSalary,
MAX(Salary) AS HighestSalary
FROM Employee
GROUP BY Department;

/* GROUP BY Clause */
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2)
);

INSERT INTO employees (emp_id, emp_name, department, salary) VALUES
(101, 'John',   'HR',       40000.00),
(102, 'Priya',  'IT',       60000.00),
(103, 'Rahul',  'HR',       45000.00),
(104, 'Anita',  'IT',       70000.00),
(105, 'Kiran',  'Sales',    50000.00),
(106, 'David',  'Finance',  55000.00),
(107, 'Meena',  'Sales',    48000.00),
(108, 'Arun',   'IT',       65000.00),
(109, 'Suresh', 'Finance',  52000.00),
(110, 'Divya',  'HR',       42000.00);

/* Count employees in each department */
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

/* Total salary by department */
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

/* Average salary by department */
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

/* Using HAVING with GROUP BY */
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;


/* JOINS */
DROP TABLE IF EXISTS Student;
CREATE TABLE Student(
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50)
);

INSERT INTO Student(StudentID, StudentName)
VALUES (1,  'Alice'),
(2, 'Bob'),
(3,  'Charlie'),
(4,  'David');

SELECT * FROM student;

CREATE TABLE Enrollment (
    StudentID INT,
    Course VARCHAR(50)
);

INSERT INTO Enrollment (StudentID, Course)
VALUES (1,  'Math'),
(2, 'Science'),
(5,  'English');

SELECT * FROM Enrollment;

/* INNER JOIN */
SELECT Student.StudentID, Student.StudentName, Enrollment.Course
FROM Student
INNER JOIN Enrollment
ON Student.StudentID = Enrollment.StudentID;

/* LEFT JOIN */
SELECT Student.StudentID, Student.StudentName, Enrollment.Course
FROM Student
LEFT JOIN Enrollment
ON Student.StudentID = Enrollment.StudentID;

/* RIGHT JOIN */
SELECT Student.StudentID, Student.StudentName, Enrollment.Course
FROM Student
RIGHT JOIN Enrollment
ON Student.StudentID = Enrollment.StudentID;

/* FULL OUTER JOIN */
SELECT Student.StudentID, Student.StudentName, Enrollment.Course
FROM Student
LEFT JOIN Enrollment
ON Student.StudentID = Enrollment.StudentID

UNION

SELECT Student.StudentID, Student.StudentName, Enrollment.Course
FROM Student
RIGHT JOIN Enrollment
ON Student.StudentID = Enrollment.StudentID;

/* CROSS JOIN */
SELECT Student.StudentName, Enrollment.Course
FROM Student
CROSS JOIN Enrollment;

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
/*
 * Changes up to SAVEPOINT sp1
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

/* Data Control Language */
CREATE USER 'john'@'localhost'
IDENTIFIED BY 'password123';

SELECT User, Host FROM mysql.user;

DROP TABLE IF EXISTS Student;
CREATE TABLE Student
(
    ID INT PRIMARY KEY,
    NAME VARCHAR(30),
    Age INT
);

INSERT INTO Student (ID, Name, Age)
VALUES (102, 'Bob', 21),
(103, 'Charlie', 22);

GRANT SELECT
ON example.Student
TO 'john'@'localhost';

/*
 * Use select/update query from user john
 * create another session with username = "john"
 * and password = "password123"
 */
SELECT * FROM Student;

UPDATE Student SET Age = 21 WHERE ID = 101;

/* Revoke SELECT access for john */
REVOKE SELECT
ON example.Student
FROM 'john'@'localhost';

/* use select query from user john */
SELECT * FROM Student;
