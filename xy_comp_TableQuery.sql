/* SQL Practice using the MySQL Workbench. 
-- Note: if error showing sql_safe_updates ON. Turn it off by SET SQL_SAFE_UPDATES = 0 ;
-- SHOW VARIABLES like 'sql_safe_updates'*/

USE xy_company;

-----------------------------------------------------------------------------------
/* Query Statements */

-- Query Statement. Print out the employees name, position and birthday.
	-- Concate the first and last name and output as name field.
    -- Change the date_of_Birth datatype from DATETIME to DATE.
    -- Join the employeePosition to show out the jobTitle of each employee
    
SELECT jobTitle AS Title, 
	CONCAT(firstName,' ', lastName) AS Employee, 
	CAST(date_Of_Birth as DATE) AS Birthday 
FROM employee AS emp
JOIN employeePosition AS empP ON emp.position_ID = empP.position_ID
ORDER BY jobTitle;


-----------------------------------------------------------------------------------
-- Create a CTE to combine employee, employeePosition and employeesalary
-----------------------------------------------------------------------------------
WITH empCTE AS (
SELECT 
    emp.employeeID, 
    emp.position_ID, 
    empP.jobTitle, 
    emp.firstName, 
    emp.lastName, 
    emp.date_Of_Birth, 
    empS.salary_Per_Month
FROM employee AS emp
    JOIN employeePosition AS empP 
	ON emp.position_ID = empP.position_ID
    JOIN employeeSalary AS empS 
	ON emp.employeeID = empS.employeeID )

SELECT * FROM empCTE;


-----------------------------------------------------------------------------------
-- Create a VIEW to combine employee, employeePosition and employeesalary
-----------------------------------------------------------------------------------
CREATE VIEW empView AS 
SELECT 
    emp.employeeID, 
    emp.position_ID, 
    empP.jobTitle, 
    emp.firstName, 
    emp.lastName, 
    emp.date_Of_Birth, 
    empS.salary_Per_Month
FROM employee AS emp
JOIN employeePosition AS empP 
    ON emp.position_ID = empP.position_ID
JOIN employeeSalary AS empS 
    ON emp.employeeID = empS.employeeID;

SELECT * FROM empView;

-- Show job title, count the total employee at each job title, sum of salary of each job title
SELECT 
    position_ID, jobTitle, 
    COUNT(employeeID) AS TotalEmployees,
    SUM(salary_Per_Month) AS TotalSalary,
    AVG(salary_Per_Month) AS AverageSalary,
    MIN(salary_Per_Month) AS MinSalary, 
    MAX(salary_Per_Month) AS MaxSalary
FROM empView
GROUP BY jobTitle
ORDER BY jobTitle;

-- Non-aggregated values (jobTitle and Salary) in the report along with the aggregated values 
-- partition by each job title.
SELECT 
    jobTitle, lastName, 
    salary_Per_Month,
    COUNT(employeeID) OVER(PARTITION BY jobTitle) AS TotalEmployees,
    SUM(salary_Per_Month) OVER(PARTITION BY jobTitle) AS TotalSalary,
    AVG(salary_Per_Month) OVER(PARTITION BY jobTitle) AS AverageSalary,
    MIN(salary_Per_Month) OVER(PARTITION BY jobTitle) AS MinSalary,
    MAX(salary_Per_Month) OVER(PARTITION BY jobTitle) AS MaxSalary
FROM empView;


SHOW WARNINGS;

SELECT * FROM employeeSalary;
SELECT * FROM employee;
SELECT * FROM empSalary;
SELECT * FROM employee;

SELECT * FROM employee;
SELECT * FROM employeePosition;

SHOW VARIABLES LIKE 'sql_safe_updates';









