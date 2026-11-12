-- ============================================================
-- DBMS LAB ASSIGNMENT - 6
-- Complete Oracle SQL solutions (Questions 1-30)
--
-- Run in Oracle SQL Developer / SQL*Plus.
-- Questions 28-30 change or remove the table, so execute them
-- only after completing Questions 1-27.
--
-- Assumptions:
-- 1. Q9: The supplied table has no MANAGER_ID column. The query
--    counts rows whose JOB_ID contains 'MGR'.
-- 2. Q11: The supplied data has IT_PROG but no ENGINEER job title.
--    IT_PROG is treated as the engineer designation.
-- ============================================================


-- Q1. Create EMP table

CREATE TABLE EMP (
    E_ID       NUMBER,
    FNAME      VARCHAR2(30) NOT NULL,
    LNAME      VARCHAR2(30) NOT NULL,
    HIRE_DATE  DATE NOT NULL,
    JOB_ID     VARCHAR2(20) NOT NULL,
    SAL        NUMBER NOT NULL,
    DEPT_ID    NUMBER,
    CONSTRAINT EMP_PK PRIMARY KEY (E_ID),
    CONSTRAINT EMP_DEPT_CK CHECK (DEPT_ID >= 10)
);


-- Insert the given employee records

INSERT INTO EMP VALUES
(198, 'Donald', 'Connell', TO_DATE('21-Jun-99', 'DD-Mon-RR'), 'SH_CLERK', 2600, 50);

INSERT INTO EMP VALUES
(199, 'Douglas', 'Grant', TO_DATE('13-Jan-98', 'DD-Mon-RR'), 'SH_CLERK', 3000, 50);

INSERT INTO EMP VALUES
(200, 'Jennifer', 'Whalen', TO_DATE('17-Sep-87', 'DD-Mon-RR'), 'AD_ASST', 4400, 10);

INSERT INTO EMP VALUES
(201, 'Michael', 'Hartstein', TO_DATE('19-Jan-99', 'DD-Mon-RR'), 'IT_PROG', 6000, 20);

INSERT INTO EMP VALUES
(202, 'Pat', 'Fay', TO_DATE('25-Oct-89', 'DD-Mon-RR'), 'AC_MGR', 6500, 20);

INSERT INTO EMP VALUES
(203, 'Susan', 'Mavris', TO_DATE('26-Nov-76', 'DD-Mon-RR'), 'AD_VP', 7500, 40);

INSERT INTO EMP VALUES
(204, 'Hermann', 'Baer', TO_DATE('23-Aug-95', 'DD-Mon-RR'), 'AD_PRES', 9500, 90);

INSERT INTO EMP VALUES
(205, 'Shelley', 'Higgins', TO_DATE('24-Feb-98', 'DD-Mon-RR'), 'AC_MGR', 2300, 60);

INSERT INTO EMP VALUES
(206, 'William', 'Gitz', TO_DATE('12-Mar-01', 'DD-Mon-RR'), 'IT_PROG', 5000, 60);

INSERT INTO EMP VALUES
(100, 'Steven', 'King', TO_DATE('15-Jun-02', 'DD-Mon-RR'), 'AD_ASST', 8956, 100);

INSERT INTO EMP VALUES
(101, 'Neena', 'Kochar', TO_DATE('10-Jul-03', 'DD-Mon-RR'), 'SH_CLERK', 3400, 30);

COMMIT;


-- Q2. Display first names in ascending order with an alias

SELECT FNAME AS Employee_Name
FROM EMP
ORDER BY FNAME ASC;


-- Q3. Display first names in descending order with an alias

SELECT FNAME AS Employee_Name
FROM EMP
ORDER BY FNAME DESC;


-- Q4. Display hire dates in ascending order

SELECT HIRE_DATE
FROM EMP
ORDER BY HIRE_DATE ASC;


-- Q5. Display employees whose first name starts with J or M,
--     sorted by last name

SELECT *
FROM EMP
WHERE FNAME LIKE 'J%'
   OR FNAME LIKE 'M%'
ORDER BY LNAME ASC;


-- Q6. Highest, lowest, average and total salary of all employees

SELECT
    MAX(SAL) AS "Max",
    MIN(SAL) AS "Min",
    AVG(SAL) AS "Avg",
    SUM(SAL) AS "Sum"
FROM EMP;


-- Q7. Highest, lowest, average and total salary for each job type

SELECT
    JOB_ID,
    MAX(SAL) AS "Max",
    MIN(SAL) AS "Min",
    AVG(SAL) AS "Avg",
    SUM(SAL) AS "Sum"
FROM EMP
GROUP BY JOB_ID;


-- Q8. Number of employees under each job

SELECT JOB_ID, COUNT(*) AS Number_Of_Employees
FROM EMP
GROUP BY JOB_ID;


-- Q9. Number of employees with manager designations.
--     The assignment table has no MANAGER_ID column.

SELECT COUNT(*) AS Number_Of_Managers
FROM EMP
WHERE JOB_ID LIKE '%MGR%';


-- Q10. Difference between highest and lowest salaries

SELECT MAX(SAL) - MIN(SAL) AS Salary_Difference
FROM EMP;


-- Q11. Maximum and average salary of engineers.
--      IT_PROG is used because it is the programmer/technical
--      job designation present in the supplied data.

SELECT
    MAX(SAL) AS Maximum_Salary,
    AVG(SAL) AS Average_Salary
FROM EMP
WHERE JOB_ID = 'IT_PROG';


-- Q12. First and last first-name alphabetically

SELECT
    MIN(FNAME) AS First_Name,
    MAX(FNAME) AS Last_Name
FROM EMP;


-- Q13. First and last hire dates

SELECT
    MIN(HIRE_DATE) AS "First Hire_Date",
    MAX(HIRE_DATE) AS "Last Hire_Date"
FROM EMP;


-- Q14. Maximum and average salary of clerks

SELECT
    MAX(SAL) AS Maximum_Salary,
    AVG(SAL) AS Average_Salary
FROM EMP
WHERE JOB_ID LIKE '%CLERK%';


-- Q15. Department number and minimum salary in each department

SELECT
    DEPT_ID,
    MIN(SAL) AS Minimum_Salary
FROM EMP
GROUP BY DEPT_ID;


-- Q16. Departments whose minimum salary is greater than 3000,
--      sorted by minimum salary in descending order

SELECT
    DEPT_ID,
    MIN(SAL) AS Minimum_Salary
FROM EMP
GROUP BY DEPT_ID
HAVING MIN(SAL) > 3000
ORDER BY Minimum_Salary DESC;


-- Q17. Display the required employee sentence

SELECT
    FNAME || ' whose designation is ' ||
    JOB_ID || ' gets ' ||
    SAL || ' but wants to earn ' ||
    (3 * SAL) AS Employee_Details
FROM EMP;


-- Q18. Display employee details in comma-separated format

SELECT
    E_ID || ', ' ||
    FNAME || ', ' ||
    LNAME || ', ' ||
    TO_CHAR(HIRE_DATE, 'DD-Mon-RR') || ', ' ||
    JOB_ID || ', ' ||
    SAL || ', ' ||
    DEPT_ID AS Employee_Details
FROM EMP;


-- Q19. Display today's date

SELECT SYSDATE AS TODAY
FROM DUAL;


-- Q20. Display employee ID, hire day and hire year

SELECT
    E_ID,
    TO_CHAR(HIRE_DATE, 'DD') AS Hire_Day,
    TO_CHAR(HIRE_DATE, 'YYYY') AS Hire_Year
FROM EMP;


-- Q21. Employee name and hire date in DD-MONTH-YY format

SELECT
    FNAME || ' ' || LNAME AS Employee_Name,
    TO_CHAR(HIRE_DATE, 'DD-MONTH-RR') AS Hire_Date
FROM EMP;


-- Q22. Employee ID and month of hiring

SELECT
    E_ID,
    TO_CHAR(HIRE_DATE, 'MONTH') AS Hire_Month
FROM EMP;


-- Q23. Employee name, ID and hire date in DD-MON-YYYY format

SELECT
    FNAME || ' ' || LNAME AS Employee_Name,
    E_ID,
    TO_CHAR(HIRE_DATE, 'DD-MON-YYYY') AS Hire_Date
FROM EMP;


-- Q24. Employee name, ID and hire date in MONTH-DD-YYYY format

SELECT
    FNAME || ' ' || LNAME AS Employee_Name,
    E_ID,
    TO_CHAR(HIRE_DATE, 'MONTH-DD-YYYY') AS Hire_Date
FROM EMP;


-- Q25. Display the current system year in words

SELECT TO_CHAR(SYSDATE, 'YEAR') AS System_Year
FROM DUAL;


-- Q26. Display today's date, 15 days after and 15 days before

SELECT
    SYSDATE AS Today,
    SYSDATE + 15 AS After_15_Days,
    SYSDATE - 15 AS Before_15_Days
FROM DUAL;


-- Q27. Ensure domain and entity integrity constraints.
--      These constraints were already created in Q1:
--      EMP_DEPT_CK enforces DEPT_ID >= 10.
--      EMP_PK enforces primary-key uniqueness and NOT NULL.
--
--      If the table was created without these constraints,
--      use the following statements instead:
--
-- ALTER TABLE EMP
-- ADD CONSTRAINT EMP_DEPT_CK CHECK (DEPT_ID >= 10);
--
-- ALTER TABLE EMP
-- ADD CONSTRAINT EMP_PK PRIMARY KEY (E_ID);


-- Q28. Drop the domain (CHECK) constraint

ALTER TABLE EMP
DROP CONSTRAINT EMP_DEPT_CK;


-- Q29. Drop the primary-key constraint

ALTER TABLE EMP
DROP CONSTRAINT EMP_PK;


-- Q30. Drop the EMP table (execute last)

DROP TABLE EMP;
