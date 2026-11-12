-- ============================================================
-- DBMS LAB ASSIGNMENT - 7
-- Complete Oracle SQL solutions (Questions 1-25)
--
-- Table: EMPLOYEE_DETAILS
--
-- IMPORTANT:
-- The extracted assignment text does not expose the full table
-- definition or its original data. This script assumes the
-- standard HR-style columns listed below. No employee records
-- have been invented or inserted.
--
-- If EMPLOYEE_DETAILS already exists, skip the CREATE TABLE
-- statement and verify that its column names match these queries.
--
-- Assumed columns:
-- EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID,
-- SALARY, COMMISSION_PCT, DEPARTMENT_ID.
-- ============================================================


-- TABLE CREATION
-- Employee_id is the primary key, as specified in the assignment.

CREATE TABLE Employee_Details (
    employee_id    NUMBER,
    first_name     VARCHAR2(30),
    last_name      VARCHAR2(30),
    hire_date      DATE,
    job_id         VARCHAR2(20),
    salary         NUMBER(10, 2),
    commission_pct NUMBER(5, 2),
    department_id  NUMBER,
    CONSTRAINT employee_details_pk PRIMARY KEY (employee_id)
);


-- Q1. First names in lowercase for departments 20, 50 or 80

SELECT LOWER(first_name) AS First_Name
FROM Employee_Details
WHERE department_id IN (20, 50, 80);


-- Q2. Last names in uppercase for departments 10, 110 or 60

SELECT UPPER(last_name) AS Last_Name
FROM Employee_Details
WHERE department_id IN (10, 110, 60);


-- Q3. Display all JOB_ID values in the format Sa_Rep

SELECT INITCAP(job_id) AS Job_ID
FROM Employee_Details;


-- Q4. Display full employee name using a function

SELECT CONCAT(CONCAT(first_name, ' '), last_name) AS Employee_Name
FROM Employee_Details;


-- Q5. Length of last names of employees receiving commission

SELECT
    last_name,
    LENGTH(last_name) AS Name_Length
FROM Employee_Details
WHERE commission_pct IS NOT NULL;


-- Q6. Numeric position of the letter 'a' in each first name

SELECT
    first_name,
    INSTR(LOWER(first_name), 'a') AS Position
FROM Employee_Details;


-- Q7. Concatenated name, last-name length and position of 'a'
--     in last name for employees whose JOB_ID contains CLERK

SELECT
    CONCAT(CONCAT(first_name, ' '), last_name) AS Employee_Name,
    LENGTH(last_name) AS Name_Length,
    INSTR(LOWER(last_name), 'a') AS Position
FROM Employee_Details
WHERE job_id LIKE '%CLERK%';


-- Q8. Display salary padded to 10 characters with '$' on the left

SELECT LPAD(TO_CHAR(salary), 10, '$') AS Salary
FROM Employee_Details;

-- Alternative: pad on the right
-- SELECT RPAD(TO_CHAR(salary), 10, '$') AS Salary
-- FROM Employee_Details;


-- Q9. Trim 'e' from the beginning/end of first names containing 'e'

SELECT TRIM('e' FROM LOWER(first_name)) AS "Trimmed"
FROM Employee_Details
WHERE LOWER(first_name) LIKE '%e%';


-- Q10. Department ID, salary and hire date for first names
--      containing exactly 6 characters

SELECT
    department_id,
    salary,
    hire_date
FROM Employee_Details
WHERE LENGTH(first_name) = 6;


-- Q11. JOB_ID and position of 'e' in first name,
--      for employees whose first name contains 'e'

SELECT
    job_id,
    INSTR(LOWER(first_name), 'e') AS Position
FROM Employee_Details
WHERE INSTR(LOWER(first_name), 'e') > 0;


-- Q12. Last names where REP occurs in JOB_ID starting at position 4

SELECT last_name
FROM Employee_Details
WHERE INSTR(job_id, 'REP', 4) > 0;


-- Q13. Remainder of salary divided by 3000 for sales representatives

SELECT
    salary,
    MOD(salary, 3000) AS Remainder
FROM Employee_Details
WHERE job_id = 'SA_REP';


-- Q14. Display salary in the format $7,000.00

SELECT TO_CHAR(salary, '$9,999,999.00') AS Salary
FROM Employee_Details;


-- Q15. Display salary in the format $7000 for departments
--      60, 90 or 110

SELECT TO_CHAR(salary, '$9999999') AS Salary
FROM Employee_Details
WHERE department_id IN (60, 90, 110);


-- Q16. Last name and commission; show 'No Commission' for NULL

SELECT
    last_name,
    NVL(TO_CHAR(commission_pct), 'No Commission') AS COMM
FROM Employee_Details;


-- Q17. Number of days elapsed between today and hire date,
--      rounded to the nearest whole day

SELECT
    last_name,
    ROUND(SYSDATE - hire_date) AS Days_Elapsed
FROM Employee_Details;


-- Q18. Number of weeks elapsed between today and hire date

SELECT
    last_name,
    ROUND((SYSDATE - hire_date) / 7) AS Weeks_Elapsed
FROM Employee_Details;


-- Q19. Number of years elapsed between today and hire date,
--      rounded to the nearest whole year

SELECT
    last_name,
    ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) AS Years_Elapsed
FROM Employee_Details;


-- Q20. Employee name and months between today and hire date

SELECT
    CONCAT(CONCAT(first_name, ' '), last_name) AS Employee_Name,
    ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS MONTHS_WORKED
FROM Employee_Details;


-- Q21. Employee name and last day of the month in which hired

SELECT
    CONCAT(CONCAT(first_name, ' '), last_name) AS Employee_Name,
    LAST_DAY(hire_date) AS Last_Day
FROM Employee_Details;


-- Q22. Employee name and hire year in words

SELECT
    CONCAT(CONCAT(first_name, ' '), last_name) AS Employee_Name,
    TO_CHAR(hire_date, 'YEAR') AS Hire_Year
FROM Employee_Details;


-- Q23. Date five months after today's date

SELECT ADD_MONTHS(SYSDATE, 5) AS "FUTURE DATE"
FROM DUAL;


-- Q24. Employee name, day and date of joining

SELECT
    CONCAT(CONCAT(first_name, ' '), last_name) AS Employee_Name,
    TO_CHAR(hire_date, 'DAY') AS Joining_Day,
    TO_CHAR(hire_date, 'DD-MON-YYYY') AS Joining_Date
FROM Employee_Details;


-- Q25. Annual salary using the assignment's stated formula:
--      (salary * 12) + commission_pct.
--      NULL commission_pct is treated as zero.

SELECT
    first_name,
    (salary * 12) + NVL(commission_pct, 0) AS Annual_Salary,
    ROUND((salary * 12) + NVL(commission_pct, 0), 2)
        AS Rounded_Annual_Salary
FROM Employee_Details;


-- END OF ASSIGNMENT 7
