/* DATA ANALYSIS */

SET datestyle to MDY, SQL;
select now()::date;

/* 
List the following details of each employee: 
employee number, last name, first name, sex, and salary.
*/

DROP VIEW IF EXISTS employee_details_and_salary;
CREATE VIEW employee_details_and_salary AS
SELECT emp.emp_no AS "employee number", 
emp.last_name "last name", emp.first_name AS "first name", emp.sex, sal.salary
FROM employees AS emp
LEFT JOIN salaries AS sal
ON emp.emp_no = sal.emp_no;

SELECT COUNT(*) FROM employee_details_and_salary;
SELECT * FROM employee_details_and_salary LIMIT 10;

/* List first name, last name, and hire date 
for employees who were hired in 1986. */
DROP VIEW IF EXISTS employees_hired_in_1986;
CREATE VIEW employees_hired_in_1986 AS  
SELECT first_name AS "first name", last_name AS "last name", hire_date AS "hire date"
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

SELECT COUNT(*) FROM employees_hired_in_1986;
SELECT * FROM employees_hired_in_1986 LIMIT 10;

/* List the manager of each department with the following 
information: department number, department name, 
the manager's employee number, last name, first name.*/
DROP VIEW IF EXISTS dept_manager_details;
CREATE VIEW dept_manager_details AS 
SELECT dep_mngr.dept_no AS "department number", 
depts.dept_name AS "department name",
dep_mngr.emp_no AS "manager's employee number", 
emp.last_name AS "manager's last name",
emp.first_name AS "manager's first name"
FROM dept_manager AS dep_mngr
LEFT JOIN departments AS depts ON dep_mngr.dept_no = depts.dept_no
LEFT JOIN employees AS emp ON dep_mngr.emp_no = emp.emp_no;

SELECT COUNT(*) FROM dept_manager_details;
SELECT * FROM dept_manager_details LIMIT 10;


/* List the department of each employee with the following information:
employee number, last name, first name, and department name.
*/
DROP VIEW IF EXISTS employee_dept_details;
CREATE VIEW employee_dept_details AS
SELECT emp.emp_no AS "employee number", 
emp.last_name AS "last name", 
emp.first_name AS "first name",
dept.dept_name AS "department name"
FROM employees as emp
LEFT JOIN dept_emp ON emp.emp_no = dept_emp.emp_no
LEFT JOIN departments AS dept ON dept_emp.dept_no = dept.dept_no;

SELECT COUNT(*) FROM employee_dept_details;
SELECT * FROM employee_dept_details LIMIT 10;


/*
List first name, last name, and sex for employees 
whose first name is "Hercules" and last names begin with "B."
*/

SELECT first_name AS "first name", last_name AS "last name", sex
FROM employees
WHERE LOWER(first_name) = 'hercules'
AND LOWER(last_name) LIKE 'b%';

/*List all employees in the Sales department, 
including their employee number, last name, first name, and department name.
*/

SELECT emp.emp_no AS "employee number", 
emp.last_name AS "last name",
emp.first_name AS "first name",
dept.dept_name AS "department name"
FROM employees as emp
LEFT JOIN dept_emp ON emp.emp_no = dept_emp.emp_no
LEFT JOIN departments AS dept ON dept_emp.dept_no = dept.dept_no
WHERE dept.dept_name ILIKE 'sales';

SELECT * FROM employee_dept_details
WHERE "department name" ILIKE 'sales';

/*List all employees in the Sales and Development departments,
including their employee number, last name, first name, and department name.
*/

SELECT emp.emp_no AS "employee number", 
emp.last_name AS "last name", 
emp.first_name AS "first name",
dept.dept_name AS "department name"
FROM employees as emp
LEFT JOIN dept_emp ON emp.emp_no = dept_emp.emp_no
LEFT JOIN departments AS dept ON dept_emp.dept_no = dept.dept_no
WHERE dept.dept_name ILIKE 'sales' OR dept.dept_name ILIKE 'development';

SELECT * FROM employee_dept_details
WHERE "department name" ILIKE 'sales' OR "department name" ILIKE 'development';

/*In descending order, list the frequency count of 
employee last names, i.e., 
how many employees share each last name.*/

SELECT last_name AS "last name", COUNT(*) AS "frequency count"
FROM employees
GROUP BY last_name
ORDER BY "frequency count" DESC;



