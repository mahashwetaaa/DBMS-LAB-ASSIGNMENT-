-- ============================================================
-- DBMS LAB ASSIGNMENT - 8
-- Complete Oracle SQL solutions (Questions 1-15)
--
-- Topic: SQL SET OPERATORS
--
-- IMPORTANT SOURCE NOTES:
-- 1. The assignment specifies the Sports_Stud fee must be >= 1000,
--    but the actual Sports_Stud fee values are not readable in the
--    uploaded document. This script uses 1000 as a sample value
--    for each sports student. Replace these values if you have
--    the original values from your printed assignment.
-- 2. Cultural_Stud data and fees are taken from the assignment.
-- 3. Birthday values in Q8 are sample dates, as the assignment
--    explicitly allows birthdays to be chosen by the student.
-- 4. Name is treated as UNIQUE in each table, and ROLL is the
--    PRIMARY KEY in each table, following the stated constraints.
--
-- Run in Oracle SQL Developer / SQL*Plus.
-- ============================================================


-- Q1. Create Sports_Stud and Cultural_Stud with constraints

CREATE TABLE Sports_Stud (
    ROLL       NUMBER,
    NAME       VARCHAR2(30),
    DEPT       VARCHAR2(10),
    SPORTS_FEE NUMBER,
    CONSTRAINT SPORTS_ROLL_PK PRIMARY KEY (ROLL),
    CONSTRAINT SPORTS_NAME_UK UNIQUE (NAME),
    CONSTRAINT SPORTS_DEPT_CK CHECK (DEPT IN ('IT', 'CS')),
    CONSTRAINT SPORTS_FEE_CK CHECK (SPORTS_FEE >= 1000)
);


CREATE TABLE Cultural_Stud (
    ROLL     NUMBER,
    NAME     VARCHAR2(30),
    DEPT     VARCHAR2(10),
    CUL_FEES NUMBER,
    CONSTRAINT CULTURAL_ROLL_PK PRIMARY KEY (ROLL),
    CONSTRAINT CULTURAL_NAME_UK UNIQUE (NAME),
    CONSTRAINT CULTURAL_DEPT_CK CHECK (DEPT IN ('IT', 'CS')),
    CONSTRAINT CULTURAL_FEE_CK CHECK (CUL_FEES >= 600)
);


-- Insert Sports_Stud records.
-- Sports fee values are sample values of 1000 because the
-- assignment's extracted text does not show the actual amounts.

INSERT INTO Sports_Stud VALUES (1, 'Aman',    'IT', 1000);
INSERT INTO Sports_Stud VALUES (2, 'Binay',   'IT', 1000);
INSERT INTO Sports_Stud VALUES (3, 'Bipul',   'CS', 1000);
INSERT INTO Sports_Stud VALUES (4, 'Joy',     'CS', 1000);
INSERT INTO Sports_Stud VALUES (5, 'Surojit', 'IT', 1000);
INSERT INTO Sports_Stud VALUES (6, 'Wasim',   'CS', 1000);


-- Insert Cultural_Stud records as shown in the assignment

INSERT INTO Cultural_Stud VALUES (1, 'Aman',  'IT', 700);
INSERT INTO Cultural_Stud VALUES (7, 'Binay', 'IT', 700);
INSERT INTO Cultural_Stud VALUES (2, 'Bipul', 'CS', 600);
INSERT INTO Cultural_Stud VALUES (8, 'Joy',   'CS', 600);

COMMIT;


-- Q2. Display all distinct students in the organization
--     UNION removes duplicate rows.

SELECT ROLL, NAME, DEPT
FROM Sports_Stud
UNION
SELECT ROLL, NAME, DEPT
FROM Cultural_Stud;


-- Q3. Display all students, including duplicate rows
--     UNION ALL keeps duplicate rows.

SELECT ROLL, NAME, DEPT
FROM Sports_Stud
UNION ALL
SELECT ROLL, NAME, DEPT
FROM Cultural_Stud;


-- Q4. Display students working in both cultural and sports groups
--     INTERSECT returns rows common to both query results.

SELECT ROLL, NAME, DEPT
FROM Sports_Stud
INTERSECT
SELECT ROLL, NAME, DEPT
FROM Cultural_Stud;


-- Q5. Display students working only in the sports group

SELECT ROLL, NAME, DEPT
FROM Sports_Stud
MINUS
SELECT ROLL, NAME, DEPT
FROM Cultural_Stud;


-- Q6. Display students working only in the cultural group

SELECT ROLL, NAME, DEPT
FROM Cultural_Stud
MINUS
SELECT ROLL, NAME, DEPT
FROM Sports_Stud;


-- Q7. Display roll number, sports fee and cultural fee of students
--     working in both groups. Match records using ROLL.

SELECT
    S.ROLL,
    S.SPORTS_FEE,
    C.CUL_FEES
FROM Sports_Stud S
INNER JOIN Cultural_Stud C
    ON S.ROLL = C.ROLL;


-- Q8. Add BIRTHDAY to both tables and enter sample birthday data

ALTER TABLE Sports_Stud
ADD BIRTHDAY DATE;

ALTER TABLE Cultural_Stud
ADD BIRTHDAY DATE;


-- Sample birthdays for Sports_Stud

UPDATE Sports_Stud
SET BIRTHDAY = DATE '2004-05-12'
WHERE ROLL = 1;

UPDATE Sports_Stud
SET BIRTHDAY = DATE '2003-08-20'
WHERE ROLL = 2;

UPDATE Sports_Stud
SET BIRTHDAY = DATE '2004-01-15'
WHERE ROLL = 3;

UPDATE Sports_Stud
SET BIRTHDAY = DATE '2003-11-25'
WHERE ROLL = 4;

UPDATE Sports_Stud
SET BIRTHDAY = DATE '2004-03-10'
WHERE ROLL = 5;

UPDATE Sports_Stud
SET BIRTHDAY = DATE '2003-07-18'
WHERE ROLL = 6;


-- Sample birthdays for Cultural_Stud

UPDATE Cultural_Stud
SET BIRTHDAY = DATE '2004-05-12'
WHERE ROLL = 1;

UPDATE Cultural_Stud
SET BIRTHDAY = DATE '2003-09-14'
WHERE ROLL = 7;

UPDATE Cultural_Stud
SET BIRTHDAY = DATE '2004-01-15'
WHERE ROLL = 2;

UPDATE Cultural_Stud
SET BIRTHDAY = DATE '2003-12-05'
WHERE ROLL = 8;

COMMIT;


-- Q9. Display student name, age and birth month for all distinct
--     students in the organization.

SELECT
    NAME,
    TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTHDAY) / 12) AS AGE,
    TO_CHAR(BIRTHDAY, 'MONTH') AS BIRTH_MONTH
FROM Sports_Stud
UNION
SELECT
    NAME,
    TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTHDAY) / 12) AS AGE,
    TO_CHAR(BIRTHDAY, 'MONTH') AS BIRTH_MONTH
FROM Cultural_Stud;


-- Q10. Display the last day of the birth month for all students.
--      UNION is used as requested in the assignment.

SELECT LAST_DAY(BIRTHDAY) AS Last_Day_Of_Birth_Month
FROM Sports_Stud
UNION
SELECT LAST_DAY(BIRTHDAY) AS Last_Day_Of_Birth_Month
FROM Cultural_Stud;


-- Q11. Display Sports_Stud details in the required sentence format

SELECT
    NAME || ' who studies in ' ||
    DEPT || ' dept pays Rs' ||
    SPORTS_FEE || ' for sports.' AS DETAILS
FROM Sports_Stud;


-- Q12. Display all IT department students from both groups

SELECT ROLL, NAME, DEPT
FROM Sports_Stud
WHERE DEPT = 'IT'
UNION
SELECT ROLL, NAME, DEPT
FROM Cultural_Stud
WHERE DEPT = 'IT';


-- Q12 (continued). Total money earned from sports fees

SELECT SUM(SPORTS_FEE) AS Total_Sports_Income
FROM Sports_Stud;


-- Q12 (continued). Total money earned from cultural fees

SELECT SUM(CUL_FEES) AS Total_Cultural_Income
FROM Cultural_Stud;


-- Q13. Display all student names in descending order

SELECT NAME
FROM (
    SELECT NAME FROM Sports_Stud
    UNION
    SELECT NAME FROM Cultural_Stud
)
ORDER BY NAME DESC;


-- Q14. Drop all domain constraints (CHECK constraints)
--      Primary-key and UNIQUE constraints are retained.

ALTER TABLE Sports_Stud
DROP CONSTRAINT SPORTS_DEPT_CK;

ALTER TABLE Sports_Stud
DROP CONSTRAINT SPORTS_FEE_CK;

ALTER TABLE Cultural_Stud
DROP CONSTRAINT CULTURAL_DEPT_CK;

ALTER TABLE Cultural_Stud
DROP CONSTRAINT CULTURAL_FEE_CK;


-- Q15. Display maximum, minimum and average sports fee

SELECT
    MAX(SPORTS_FEE) AS Maximum_Fee,
    MIN(SPORTS_FEE) AS Minimum_Fee,
    AVG(SPORTS_FEE) AS Average_Fee
FROM Sports_Stud;


-- END OF ASSIGNMENT 8
--
-- The assignment does not ask to drop the tables.
-- Sports_Stud and Cultural_Stud are therefore left in place.
