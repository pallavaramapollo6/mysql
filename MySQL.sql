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
SELECT Name, Salary,
       ROW_NUMBER() OVER(ORDER BY Salary DESC) AS RowNum
FROM Employees;
