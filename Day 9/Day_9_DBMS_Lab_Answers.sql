/*
DAY 9 - DBMS LAB
Source sheet title: LAB Assignment-10
Topic: Retrieving Data from Multiple Tables
Dialect: Oracle SQL

Run this script in an Oracle schema where you have permission to create tables.
The source sheet has missing values for A05.PHONE and A06.LNAME; these are
stored as NULL. The Star value 'TC' is used for Tom Cruise in question 13.
*/

-- =========================================================
-- GROUP A: TABLE CREATION AND SAMPLE DATA
-- =========================================================

CREATE TABLE Customer (
    Cust_id VARCHAR2(3) CONSTRAINT pk_customer PRIMARY KEY,
    Fname   VARCHAR2(30) NOT NULL,
    Lname   VARCHAR2(30),
    Area    VARCHAR2(2) NOT NULL,
    Phone   VARCHAR2(15),
    CONSTRAINT chk_customer_id_prefix CHECK (Cust_id LIKE 'A%')
);

CREATE TABLE Movie (
    Mv_no  NUMBER(2) CONSTRAINT pk_movie PRIMARY KEY,
    Title  VARCHAR2(60) NOT NULL,
    Type   VARCHAR2(20) NOT NULL,
    Star   VARCHAR2(10) NOT NULL,
    Price  NUMBER(6,2) NOT NULL
);

CREATE TABLE Invoice (
    Inv_no      VARCHAR2(3) CONSTRAINT pk_invoice PRIMARY KEY,
    Mv_no       NUMBER(2),
    Cust_id     VARCHAR2(3),
    Issue_date  DATE NOT NULL,
    Return_date DATE NOT NULL,
    CONSTRAINT fk_invoice_movie FOREIGN KEY (Mv_no) REFERENCES Movie(Mv_no),
    CONSTRAINT fk_invoice_customer FOREIGN KEY (Cust_id) REFERENCES Customer(Cust_id),
    CONSTRAINT chk_invoice_id_prefix CHECK (Inv_no LIKE 'I%')
);

-- Customer records
INSERT INTO Customer VALUES ('A01', 'Ivan',    'Bayross',   'SA', '6125467');
INSERT INTO Customer VALUES ('A02', 'Vandana', 'Saiteal',   'MU', '5560379');
INSERT INTO Customer VALUES ('A03', 'Pramada', 'Jauguste',  'DA', '4560389');
INSERT INTO Customer VALUES ('A04', 'Basu',    'Navindi',   'BA', '6125401');
INSERT INTO Customer VALUES ('A05', 'Ravi',    'Shreedhar', 'NA', NULL);
INSERT INTO Customer VALUES ('A06', 'Rukmini', NULL,        'GH', '5125274');

-- Movie records
INSERT INTO Movie VALUES (1,  'Bloody',          'Action',   'JC', 181);
INSERT INTO Movie VALUES (2,  'The Firm',        'Thriller', 'TC', 200);
INSERT INTO Movie VALUES (3,  'Pretty Woman',    'Romance',  'RG', 151);
INSERT INTO Movie VALUES (4,  'Home Alone',      'Comedy',   'MC', 150);
INSERT INTO Movie VALUES (5,  'The Fugitive',    'Thriller', 'MF', 200);
INSERT INTO Movie VALUES (6,  'Coma',            'Suspense', 'MD', 100);
INSERT INTO Movie VALUES (7,  'Dracula',         'Horror',   'GO', 150);
INSERT INTO Movie VALUES (8,  'Quick Change',    'Comedy',   'BM', 100);
INSERT INTO Movie VALUES (9,  'Gone with the Wind', 'Action','CB', 200);
INSERT INTO Movie VALUES (10, 'Carry on Doctor', 'Comedy',   'LP', 100);

-- Invoice records (dates interpreted as 1993)
INSERT INTO Invoice VALUES ('I01', 4,  'A01', DATE '1993-07-23', DATE '1993-07-25');
INSERT INTO Invoice VALUES ('I02', 3,  'A02', DATE '1993-08-12', DATE '1993-08-15');
INSERT INTO Invoice VALUES ('I03', 1,  'A02', DATE '1993-08-15', DATE '1993-08-18');
INSERT INTO Invoice VALUES ('I04', 6,  'A03', DATE '1993-09-10', DATE '1993-09-13');
INSERT INTO Invoice VALUES ('I05', 7,  'A04', DATE '1993-08-05', DATE '1993-08-08');
INSERT INTO Invoice VALUES ('I06', 2,  'A06', DATE '1993-09-18', DATE '1993-09-21');
INSERT INTO Invoice VALUES ('I07', 9,  'A05', DATE '1993-07-07', DATE '1993-07-10');
INSERT INTO Invoice VALUES ('I08', 9,  'A01', DATE '1993-08-11', DATE '1993-08-14');
INSERT INTO Invoice VALUES ('I09', 5,  'A03', DATE '1993-07-06', DATE '1993-07-09');
INSERT INTO Invoice VALUES ('I10', 8,  'A06', DATE '1993-09-03', DATE '1993-09-06');

COMMIT;

-- =========================================================
-- GROUP A: QUERIES
-- =========================================================

-- 2. Customer names and movie numbers of all customers issued a movie.
SELECT c.Fname, c.Lname, i.Mv_no
FROM Customer c
JOIN Invoice i ON i.Cust_id = c.Cust_id;

-- 3. Movie number and title issued to Ivan.
SELECT m.Mv_no, m.Title
FROM Movie m
JOIN Invoice i ON i.Mv_no = m.Mv_no
JOIN Customer c ON c.Cust_id = i.Cust_id
WHERE c.Fname = 'Ivan';

-- 4. Title, customer id and movie number for all issued movies.
SELECT m.Title, i.Cust_id, i.Mv_no
FROM Invoice i
JOIN Movie m ON m.Mv_no = i.Mv_no;

-- 5. Title and type of movies issued to Vandana.
SELECT m.Title, m.Type
FROM Movie m
JOIN Invoice i ON i.Mv_no = m.Mv_no
JOIN Customer c ON c.Cust_id = i.Cust_id
WHERE c.Fname = 'Vandana';

-- 6. Names of customers issued an Action movie.
SELECT DISTINCT c.Fname, c.Lname
FROM Customer c
JOIN Invoice i ON i.Cust_id = c.Cust_id
JOIN Movie m ON m.Mv_no = i.Mv_no
WHERE UPPER(m.Type) = 'ACTION';

-- 7. Movie title, last name, first name in the requested sentence format,
--    for movie numbers >= 3.
SELECT 'The movie taken by ' || c.Fname || ' ' ||
       NVL(c.Lname, '') || ' is ' || m.Title || '.' AS Movie_Taken
FROM Customer c
JOIN Invoice i ON i.Cust_id = c.Cust_id
JOIN Movie m ON m.Mv_no = i.Mv_no
WHERE i.Mv_no >= 3;

-- 8. Customer issued the movie in invoice I10.
SELECT c.*
FROM Customer c
JOIN Invoice i ON i.Cust_id = c.Cust_id
WHERE i.Inv_no = 'I10';

-- 9. Customer name, phone and area for movies issued before August 1993.
SELECT DISTINCT c.Fname, c.Lname, c.Phone, c.Area
FROM Customer c
JOIN Invoice i ON i.Cust_id = c.Cust_id
WHERE i.Issue_date < DATE '1993-08-01';

-- 10. Movie number and title issued to Ivan, Vandana and Ravi.
SELECT DISTINCT m.Mv_no, m.Title
FROM Movie m
JOIN Invoice i ON i.Mv_no = m.Mv_no
JOIN Customer c ON c.Cust_id = i.Cust_id
WHERE c.Fname IN ('Ivan', 'Vandana', 'Ravi');

-- 11. Movie number and movie name issued to customers.
SELECT DISTINCT m.Mv_no, m.Title
FROM Movie m
JOIN Invoice i ON i.Mv_no = m.Mv_no
ORDER BY m.Mv_no;

-- 12. Type and movie numbers issued to customer IDs A01 and A02.
SELECT DISTINCT m.Type, m.Mv_no
FROM Movie m
JOIN Invoice i ON i.Mv_no = m.Mv_no
WHERE i.Cust_id IN ('A01', 'A02')
ORDER BY m.Mv_no;

-- 13. Check whether the movie whose star is Tom Cruise was issued;
--     the source data represents Tom Cruise with Star = 'TC'.
SELECT i.Cust_id
FROM Movie m
JOIN Invoice i ON i.Mv_no = m.Mv_no
WHERE UPPER(m.Star) = 'TC';

-- 14. First and last names of customers who have been issued a movie.
SELECT DISTINCT c.Fname, c.Lname
FROM Customer c
JOIN Invoice i ON i.Cust_id = c.Cust_id;

-- 15. Movie number never issued to any customer.
SELECT m.Mv_no
FROM Movie m
WHERE NOT EXISTS (
    SELECT 1
    FROM Invoice i
    WHERE i.Mv_no = m.Mv_no
);

-- =========================================================
-- GROUP B: ORACLE EMPLOYEES TABLE
-- Assumption: the Oracle HR-style EMPLOYEES table is available,
-- with EMPLOYEE_ID, FIRST_NAME, LAST_NAME and MANAGER_ID columns.
-- =========================================================

-- 16. Employee ID, employee name, manager ID and manager name.
SELECT e.EMPLOYEE_ID,
       e.FIRST_NAME || ' ' || e.LAST_NAME AS EMPLOYEE_NAME,
       e.MANAGER_ID,
       m.FIRST_NAME || ' ' || m.LAST_NAME AS MANAGER_NAME
FROM EMPLOYEES e
LEFT JOIN EMPLOYEES m ON e.MANAGER_ID = m.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID;

-- 17. Employee name, manager ID, manager name and manager's manager name.
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME AS EMPLOYEE_NAME,
       e.MANAGER_ID,
       m.FIRST_NAME || ' ' || m.LAST_NAME AS MANAGER_NAME,
       mm.FIRST_NAME || ' ' || mm.LAST_NAME AS MANAGERS_MANAGER_NAME
FROM EMPLOYEES e
LEFT JOIN EMPLOYEES m  ON e.MANAGER_ID = m.EMPLOYEE_ID
LEFT JOIN EMPLOYEES mm ON m.MANAGER_ID = mm.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID;

-- Note for question 16-17:
-- If your lab's table is literally named EMP and uses the classic
-- SCOTT schema (EMPNO, ENAME, MGR), replace EMPLOYEES with EMP,
-- EMPLOYEE_ID with EMPNO, FIRST_NAME || ' ' || LAST_NAME with ENAME,
-- and MANAGER_ID with MGR.
