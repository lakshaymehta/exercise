CREATE SCHEMA employee_commission;
USE employee_commission;

CREATE TABLE departments 
(
id INT NOT NULL,
name VARCHAR(15),
PRIMARY KEY (id)
);
INSERT INTO departments (id, name) VALUES ('1', 'Banking'),
('2', 'Insurance'),
('3', 'Services');

CREATE TABLE employees 
(
id INT NOT NULL,
name VARCHAR(45) NULL,
salary INT NULL,
dept_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (dept_id) REFERENCES departments(id)
);
INSERT INTO employees (id, name, salary, dept_id) VALUES ('1', 'Chris Gayle', '1000000', '1'),
('2', 'Michael Clarke', '800000', '2'),
('3', 'Rahul Dravid ', '700000', '1'),
('4', 'Ricky Pointing', '600000', '2'),
('5', 'Albie Morkel', '650000', '2'),
('6', 'Wasim Akram', '750000', '3');

CREATE TABLE commissions 
(
id INT NOT NULL,
emp_id INT NOT NULL,
com_amount INT NULL,
PRIMARY KEY (id),
FOREIGN KEY (emp_id) REFERENCES employees(id)
);
INSERT INTO commissions (id, emp_id, com_amount) VALUES ('1', '1', '5000'),
('2', '2', '3000'),
('3', '3', '4000'),
('4', '1', '4000'),
('5', '2', '3000'),
('6', '4', '2000'),
('7', '5', '1000'),
('8', '6', '5000');

	-- Find the employee who gets the highest total commission --
CREATE INDEX employee_indx ON employees(id, name);
CREATE INDEX commission_indx ON commissions(emp_id, com_amount);

SELECT employees.name, SUM(commissions.com_amount) FROM employees USE INDEX(employee_indx) JOIN commissions USE INDEX(commission_indx)
ON employees.id=commissions.emp_id
GROUP BY employees.name
LIMIT 1;

	-- Find employee with 4th Highest salary from employee table --
SELECT name, salary FROM employees 
ORDER BY salary DESC 
LIMIT 3,1;

	-- Find department that is giving highest commission --
SELECT departments.name, SUM(commissions.com_amount) FROM employees, departments, commissions
WHERE departments.id=employees.dept_id AND employees.id=commissions.emp_id
GROUP BY departments.name
ORDER BY SUM(commissions.com_amount) DESC 
LIMIT 1;

	-- Find employees getting commission more than 3000 --
SELECT GROUP_CONCAT(employees.name), commissions.com_amount FROM employees INNER JOIN commissions
ON employees.id=commissions.emp_id
WHERE commissions.com_amount>3000
GROUP BY commissions.com_amount;