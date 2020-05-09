-- create all tables needed for the CSVs
CREATE TABLE Departments
(
	department_No VARCHAR,
	department_name VARCHAR
);

CREATE TABLE Employee_Dept
(
	Employee_No VARCHAR,
	Department_No VARCHAR,
	Start_Date VARCHAR,
	End_Date VARCHAR
);

CREATE TABLE Manager_Info
(
	Department_No VARCHAR,
	Employee_No VARCHAR,
	Start_Date VARCHAR,
	End_Date VARCHAR
);

CREATE TABLE Employee_Info
(
	Employee_No  VARCHAR,
	Birthday VARCHAR,
	First_Name VARCHAR,
	Last_Name VARCHAR,
	Gender VARCHAR,
	Start_Date VARCHAR
);

CREATE TABLE Employment_Data
(
	Employee_No VARCHAR,
	Salary INTEGER,
	Start_Date VARCHAR,
	End_Date VARCHAR
);

CREATE TABLE Title
(
	Employee_No VARCHAR,
	Title VARCHAR,
	Start_Date VARCHAR,
	End_Date VARCHAR
);

-- get employee data including gender and salary, joining employee with
-- salary because employee has all info except for salary
SELECT e.Employee_No, e.First_Name, e.Last_Name, e.Gender, s.Salary
FROM Employee_Info AS e
LEFT JOIN Employment_Data as s
ON e.Employee_No = s.Employee_No;

-- get all employees hired in 1986, text uses single quote not double
SELECT *
FROM Employment_Data
WHERE Start_Date BETWEEN '1986-01-01' AND '1986-12-31';

--get manager info of every department. use department table, manager table and employee table
SELECT d.department_name, m.Department_No, e.Employee_No, e.Last_Name, e.First_Name, m.Start_Date, m.End_Date
FROM Manager_Info AS m
LEFT JOIN Departments AS d
ON d.department_No = m.Department_No
LEFT JOIN Employee_Info AS e
ON m.Employee_No = e.Employee_No;

-- get employee department so use department, employee dept and employee info
SELECT ed.Employee_No, e.First_Name, e.Last_Name, d.department_name
FROM Departments AS d 
RIGHT JOIN Employee_Dept AS ed
ON d.department_No = ed.Department_No
LEFT JOIN Employee_Info AS e
ON e.Employee_No = ed.Employee_No;

--get all emloyees whose first name is Hercules and last name starts with B, use % to get the rest of the name
SELECT *
FROM Employee_Info
WHERE First_Name = 'Hercules' AND Last_Name LIKE 'B%';

--filter and join employee info,employee department, departments to only get employees in sales
SELECT ed.Employee_No, e.Last_Name, e.First_Name, d.department_name
FROM Departments AS d
RIGHT JOIN Employee_Dept AS ed
ON d.department_No = ed.Department_No
RIGHT JOIN Employee_Info AS e
ON ed.Employee_No = e.Employee_No
WHERE d.department_name= 'Sales';

--filter and join employee info, employee department, and department to get sales and development
SELECT ed.Employee_No, e.Last_Name, e.First_Name, d.department_name
FROM Departments AS d
RIGHT JOIN Employee_Dept AS ed
ON d.department_No = ed.Department_No
RIGHT JOIN Employee_Info AS e
ON ed.Employee_No = e.Employee_No
WHERE d.department_name= 'Sales' OR d.department_name = 'Development';

-- get count of employees with same last name in descending order, use group by to group like last names
SELECT Last_Name, COUNT(Last_Name)
FROM Employee_Info
GROUP BY Last_Name 
ORDER BY Last_Name DESC;