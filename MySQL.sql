show databases;
use example;
show tables;


drop table students;
drop table marks;

/* SUBQUERIES */
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

DROP TABLE Students2024;
DROP TABLE Students2025;
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


