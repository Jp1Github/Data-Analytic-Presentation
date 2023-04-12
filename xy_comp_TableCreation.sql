/* SQL Practice using the MySQL Workbench. Created a fictional table for practice */

USE xy_company;

-- Create a table employee
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    employeeID MEDIUMINT,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    date_Of_Birth DATE,
    gender VARCHAR (10),
    position_ID MEDIUMINT
);
    
SELECT * 
FROM Employee;

-- Creating table employee and job title
DROP TABLE IF EXISTS employeePosition;
CREATE TABLE employeePosition (
             position_ID MEDIUMINT,
             jobTitle VARCHAR(50)
);
    
SELECT *
FROM employeePosition;

-- Creating table for employee ID, position ID and monthly salary
DROP TABLE IF EXISTS employeeSalary;
CREATE TABLE employeeSalary (
	     employeeID MEDIUMINT,
             position_ID MEDIUMINT,
             salary_Per_Month INT
);

SELECT * 
FROM employeeSalary;

/* Populate the  following Tables. Using INSERT INTO table_name VALUES.
Wrote insert into statement all the column name to be explicit!. This can be omitted but not a good practice!
-- Employee Table */
INSERT INTO Employee (
	employeeID,
   	firstName,
    	lastName,
    	date_Of_Birth,
    	gender,
	position_ID 
)
VALUES
(1, 'Jaycee', 'Hall', '2001-01-28', 'Female', 2),
(2, 'Sue', 'Matterson', '2000-04-12', 'Female', 1),
(3, 'Chris', 'Faber', '1999-11-16', 'Male', 1),
(4, 'Peggy', 'Anderson', '2000-06-27', 'Female', 3),
(5, 'Liz', 'Benson', '2002-05-10', 'Female', 3),
(6, 'Nicole', 'Summers', '2003-02-14', 'Female', 4),
(7, 'Matthew', 'McIntyre', '2001-08-05', 'Male', 5),
(8, 'Maggie', 'Potter', '2002-07-07', 'Female', 6),
(9, 'Ravi', 'Singh', '1998-09-11', 'Male', 7),
(10, 'Raji', 'Sumas', '1995-01-12', 'Male', 8),
(11, 'Annie', 'Ross', '1998-12-23', 'Male', 9),
(12, 'Steve', 'Parker', '1994-10-10', 'Male', 9),
(13, 'Cristina', 'Castillo', '1999-04-15', 'Female', 12),
(14, 'Xavier', 'Cheng', '1988-06-06', 'Male', 13),
(15, 'Larry', 'Sim', '1997-03-03', 'Male', 14),
(16, 'Donnie', 'Bankers', '1990-07-28', 'Male', 15);


-- employeePosition Table.
INSERT INTO employeePosition (
	position_ID,
	jobTitle
)
VALUES
(1, 'Assembler'),
(3, 'Office Staff'),
(4, 'Receptionist'),
(5, 'HR'),
(6, 'Accountant'),
(7, 'Jr. Salesman'),
(8, 'Sr. Salesman'),
(9, 'Manager'),
(10, 'Sr. Manager'),
(11, 'Regional Manager'),
(12, 'Consultant'),
(13, 'Gen. Mgr'),
(14, 'Vice Pres'),
(15, 'CEO');

-- employeeSalary Table.
INSERT INTO employeeSalary (
	employeeID,
    	position_ID,
    	salary_Per_Month
)
VALUES
(1, 2, 3200),
(2, 1, 2800),
(3, 1, 2800),
(4, 3, 2900),
(5, 3, 3000),
(6, 4, 2700),
(7, 5, 3300),
(8, 6, 3800),
(9, 7, 3600),
(10, 8, 4500),
(11, 9, 6800),
(12, 10, 8000),
(13, 12, 10000),
(14, 13, 35000),
(15, 14, 53000),
(16, 15, 75000);

-----------------------------------------------------------------------------------
SHOW DATABASES; -- Shows the databases in the current server.
SHOW TABLES FROM xy_company; -- Show all the tables in that particular database (schema)
-----------------------------------------------------------------------------------
/* Show the information or schema about a table column */
SHOW COLUMNS FROM employeePosition;
DESCRIBE xy_company.employeePosition;
DESCRIBE employeePosition;
-----------------------------------------------------------------------------------
SELECT * FROM employee;
SELECT * FROM employeePosition;
SELECT * FROM employeeSalary;







