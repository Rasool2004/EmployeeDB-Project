CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Departments (
	department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE Employees (
	emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    hire_date DATE,
    salary DECIMAL(10, 2),
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(emp_id)
);

CREATE TABLE Projects (
	project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Employee_project (
	emp_id INT,
    project_id INT,
	assigned_date DATE,
    role VARCHAR(50),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES Employees (emp_id),
    FOREIGN KEY (project_id) REFERENCES Projects (project_id)
);
    
CREATE TABLE Clients(
	client_id INT PRIMARY KEY,
    client_name VARCHAR(100),
    contact_email VARCHAR(100),
    country VARCHAR(50)
);

INSERT INTO Departments (department_id, department_name, location) VALUES
(1, 'IT', 'Bengaluru'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'Delhi'),
(4, 'Marketing', 'Hyderabad'),
(5, 'Operations', 'Chennai');

INSERT INTO Employees (emp_id, first_name, last_name, email, phone, hire_date, salary, department_id, manager_id) VALUES
(101, 'Amit', 'Sharma', 'amit.sharma@company.in', '9876543210', '2018-05-12', 90000.00, 1, NULL),  -- Manager IT
(102, 'Priya', 'Verma', 'priya.verma@company.in', '9876501234', '2019-07-23', 75000.00, 2, 101),   -- HR Head under Amit
(103, 'Rohit', 'Mehta', 'rohit.mehta@comapany.in', '9876512345', '2020-01-15', 60000.00, 1, 101),  -- IT Dev under Amit
(104, 'Sneha', 'Iyer', 'sneha.iyer@company.in', '9876523456', '2021-03-10', 55000.00, 3, 101),     -- Finance under Amit
(105, 'Vikram', 'Reddy', 'vikram.reddy@company.in', '9876534567', '2017-11-05', 85000.00, 4, 101),  -- Marketing under Amit
(106, 'Ananya', 'Das', 'ananya.das@company.in', '9876545678', '2022-06-20', 50000.00, 5, 105),    -- Operations under Vikram
(107, 'Karan', 'Singh', 'karan.singh@company.in', '9876556789', '2023-01-05', 45000.00, 2, 102),    -- HR under Priya
(108, 'Meera', 'Nair', 'meera.nair@company.in', '9876567890', '2020-08-30', 65000.00, 3, 104);      -- Finance under Sneha

INSERT INTO Projects (project_id, project_name, start_date, end_date, budget, department_id) VALUES
(201, 'E-Commerce Website', '2023-01-10', '2023-06-30', 1500000.00, 1),
(202, 'Campus Recruitment Drive', '2023-02-15', '2023-04-30', 400000.00, 2),
(203, 'Annual Financial Audit', '2023-03-01', '2023-05-15', 800000.00, 3),
(204, 'Digital Marketing Campaign', '2023-04-01', '2023-07-15', 600000.00, 4),
(205, 'Supply Chain Optimization', '2023-05-20', '2023-09-30', 1200000.00, 5);

INSERT INTO Employee_project (emp_id, project_id, assigned_date, role) VALUES 
(101, 201, '2023-01-10', 'Project Manager'),
(103, 201, '2023-01-12', 'Backend Developer'),
(102, 202, '2023-02-15', 'HR Lead'),
(107, 202, '2023-02-20', 'Recruiter'),
(104, 203, '2023-03-01', 'Finance Lead'),
(108, 203, '2023-03-05', 'Financial Analyst'),
(105, 204, '2023-04-01', 'Marketing Lead'),
(106, 205, '2023-05-20', 'Operations Specialist');

INSERT INTO Clients (client_id, client_name, contact_email, country) VALUES
(301, 'Tata Consultancy Services', 'contact@tcs.com', 'India'),
(302, 'Infosys', 'connect@infosys.com', 'India'),
(303, 'Wipro', 'business@wipro.com', 'India'),
(304, 'HDFC Bank', 'support@hdfcbank.com', 'India'),
(305, 'Reliance Industries', 'info@ril.com', 'India');

-- QUERIES

-- View all employees
SELECT * FROM Employees;

-- Show only first_name, last_name, salary
SELECT first_name, last_name, salary FROM Employees;

-- Employees with salary greater than 60,000
SELECT * FROM Employees
WHERE salary > 60000;

-- Employees in the HR department
SELECT first_name, last_name FROM Employees
WHERE department_id = 2;

-- Employees hired after 2020
SELECT first_name, hire_date FROM Employees
WHERE hire_date > '2020-01-01';

-- IT employees with salary between 50,000 and 80,000
SELECT * FROM Employees
WHERE department_id = 1 AND salary BETWEEN 50000 AND 80000;

-- Marketing OR Operations employees
SELECT * FROM Employees
WHERE department_id IN (4, 5);

-- Employees whose name starts with 'A'
SELECT * FROM Employees
WHERE first_name LIKE 'A%';

-- Emails containing 'company.in'
SELECT * FROM Employees
WHERE email LIKE '%company.in';

-- Employees sorted by salary descending
SELECT first_name, last_name, salary
FROM Employees
ORDER BY salary DESC;

-- Employees sorted by department then salary
SELECT first_name, last_name, department_id, salary
FROM Employees
ORDER BY department_id, salary DESC;

-- Top 3 highest paid employees
SELECT first_name, last_name, salary
FROM Employees
ORDER BY salary DESC
LIMIT 3;

-- Average salary in each department
SELECT department_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id;

-- Total employees in each department
SELECT department_id, COUNT(*) AS emp_count
FROM Employees
GROUP BY department_id;

-- Highest salary in the company
SELECT MAX(salary) AS max_salary
FROM Employees;

-- Departments with average salary above 70,000
SELECT department_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id
HAVING AVG(salary) > 70000;

-- Employee names with their department names
SELECT e.first_name, e.last_name, d.department_name
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id;

-- Employees with project names
SELECT e.first_name, e.last_name, p.project_name
FROM Employees e
JOIN Employee_project ep ON e.emp_id = ep.emp_id
JOIN Projects p ON ep.project_id = p.project_id;


-- Employees earning more than company average
SELECT * FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- Employees working on 'E-Commerce Website' project
SELECT first_name, last_name
FROM Employees
WHERE emp_id IN (
    SELECT emp_id FROM Employee_project
    WHERE project_id = (SELECT project_id FROM Projects WHERE project_name = 'E-Commerce Website')
);


-- Example – List employees with their department names
SELECT e.first_name, e.last_name, d.department_name
FROM Employees AS e
INNER JOIN Departments AS d
    ON e.department_id = d.department_id;


-- Find employees and projects they are working on.
SELECT e.first_name, e.last_name, p.project_name
FROM Employees e
INNER JOIN Employee_project ep
    ON e.emp_id = ep.emp_id
INNER JOIN Projects p
    ON ep.project_id = p.project_id;


-- Example – All employees and their department names (even if dept not assigned)
SELECT e.first_name, e.last_name, d.department_name
FROM Employees e
LEFT JOIN Departments d
    ON e.department_id = d.department_id;


-- Find employees not assigned to any project.
SELECT e.emp_id, e.first_name, e.last_name
FROM Employees e
LEFT JOIN Employee_project ep
    ON e.emp_id = ep.emp_id
WHERE ep.project_id IS NULL;


-- Example – All departments and employees in them
SELECT e.first_name, e.last_name, d.department_name
FROM Employees e
RIGHT JOIN Departments d
    ON e.department_id = d.department_id;


-- Departments without employees.
SELECT d.department_name
FROM Employees e
RIGHT JOIN Departments d
    ON e.department_id = d.department_id
WHERE e.emp_id IS NULL;


-- Example – All employees and all departments

SELECT e.first_name, e.last_name, d.department_name
FROM Employees e
LEFT JOIN Departments d
    ON e.department_id = d.department_id
UNION
SELECT e.first_name, e.last_name, d.department_name
FROM Employees e
RIGHT JOIN Departments d
    ON e.department_id = d.department_id;


-- Example – Employees without a department

SELECT e.*
FROM Employees e
LEFT JOIN Departments d
    ON e.department_id = d.department_id
WHERE d.department_id IS NULL;


-- Example – Departments without employees

SELECT d.*
FROM Employees e
RIGHT JOIN Departments d
    ON e.department_id = d.department_id
WHERE e.emp_id IS NULL;


-- Example – Employees and their managers

SELECT e.first_name AS Employee, m.first_name AS Manager
FROM Employees e
LEFT JOIN Employees m
    ON e.manager_id = m.emp_id;


-- Example – Employees with their department and project

SELECT e.first_name, e.last_name, d.department_name, p.project_name
FROM Employees e
JOIN Departments d
    ON e.department_id = d.department_id
JOIN Employee_project ep
    ON e.emp_id = ep.emp_id
JOIN Projects p
    ON ep.project_id = p.project_id;


-- List all projects with their department and the employees working on them.

-- ANSWER
SELECT p.project_name, d.department_name, e.first_name, e.last_name
FROM Projects p
LEFT JOIN Departments d
    ON p.department_id = d.department_id
LEFT JOIN Employee_project ep
    ON p.project_id = ep.project_id
LEFT JOIN Employees e
    ON ep.emp_id = e.emp_id;


-- List employees working in the same department as ‘Amit Sharma’.
-- ANSWER
SELECT e.first_name, e.last_name
FROM Employees e
INNER JOIN Employees a
    ON e.department_id = a.department_id
WHERE a.first_name = 'Amit' AND a.last_name = 'Sharma'
AND e.emp_id <> a.emp_id;


-- List all employees and projects, including:
-- 1.employees without projects
-- 2.projects without employees

SELECT e.first_name, p.project_name
FROM Employees e
LEFT JOIN Employee_project ep
    ON e.emp_id = ep.emp_id
LEFT JOIN Projects p
    ON ep.project_id = p.project_id
UNION
SELECT e.first_name, p.project_name
FROM Employees e
RIGHT JOIN Employee_project ep
    ON e.emp_id = ep.emp_id
RIGHT JOIN Projects p
    ON ep.project_id = p.project_id;
