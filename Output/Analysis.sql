/* DATA ANALYSIS */

SET datestyle to MDY, SQL;
select now()::date;

/* 
List the following details of each employee: 
employee number, last name, first name, sex, and salary.
*/

DROP VIEW IF EXISTS employee_details_and_salary;
CREATE VIEW employee_details_and_salary AS
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM employees AS emp
LEFT JOIN salaries AS sal
ON emp.emp_no = sal.emp_no;

SELECT COUNT(*) FROM employee_details_and_salary;
SELECT * FROM employee_details_and_salary LIMIT 10;

/* List first name, last name, and hire date 
for employees who were hired in 1986. */

CREATE VIEW employees_hired_in_1986 AS  
SELECT emp.first_name, emp.last_name, emp.hire_date
FROM employees as emp
WHERE EXTRACT(YEAR FROM emp.hire_date) = 1986;

SELECT COUNT(*) FROM employees_hired_in_1986;
SELECT * FROM employees_hired_in_1986 LIMIT 10;

/* List the manager of each department with the following 
information: department number, department name, 
the manager's employee number, last name, first name.*/

CREATE VIEW dept_manager_details AS 
SELECT dep_mngr.dept_no, depts.dept_name, dep_mngr.emp_no, emp.last_name, emp.first_name 
FROM dept_manager AS dep_mngr
LEFT JOIN departments AS depts ON dep_mngr.dept_no = depts.dept_no
LEFT JOIN employees AS emp ON dep_mngr.emp_no = emp.emp_no;

SELECT COUNT(*) FROM dept_manager_details;
SELECT * FROM dept_manager_details LIMIT 10;

/* List the department of each employee with the following information:
employee number, last name, first name, and department name.
*/
CREATE VIEW employee_dept_details AS
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees as emp
LEFT JOIN dept_emp ON emp.emp_no = dept_emp.emp_no
LEFT JOIN departments AS dept ON dept_emp.dept_no = dept.dept_no;

SELECT COUNT(*) FROM employee_dept_details;
SELECT * FROM employee_dept_details LIMIT 10;


/*
List first name, last name, and sex for employees 
whose first name is "Hercules" and last names begin with "B."
*/

SELECT emp.first_name, emp.last_name, emp.sex
FROM employees as emp
WHERE LOWER(emp.first_name) = 'hercules'
AND emp.last_name LIKE 'B%';

/*List all employees in the Sales department, 
including their employee number, last name, first name, and department name.
*/

SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees as emp
LEFT JOIN dept_emp ON emp.emp_no = dept_emp.emp_no
LEFT JOIN departments AS dept ON dept_emp.dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales';

SELECT * FROM employee_dept_details
WHERE dept_name = 'Sales';

/*List all employees in the Sales and Development departments,
including their employee number, last name, first name, and department name.
*/

SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees as emp
LEFT JOIN dept_emp ON emp.emp_no = dept_emp.emp_no
LEFT JOIN departments AS dept ON dept_emp.dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales' OR dept.dept_name = 'Development';

SELECT * FROM employee_dept_details
WHERE dept_name = 'Sales' OR dept_name = 'Development';

/*In descending order, list the frequency count of 
employee last names, i.e., 
how many employees share each last name.*/

SELECT last_name, COUNT(*) AS freqency_count
FROM employees
GROUP BY last_name
ORDER BY freqency_count DESC;



