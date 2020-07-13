-- Clear Table data (if any)
TRUNCATE TABLE  titles CASCADE;
TRUNCATE TABLE employees CASCADE;
TRUNCATE TABLE salaries CASCADE;
TRUNCATE TABLE departments CASCADE;
TRUNCATE TABLE dept_emp CASCADE;
TRUNCATE TABLE dept_manager CASCADE;

--Before the next step, ensure the data to be copies to /tmp
COPY titles FROM '/tmp/titles.csv' DELIMITER ',' CSV HEADER;
select pg_sleep(1);
COPY employees FROM '/tmp/employees.csv' DELIMITER ',' CSV HEADER;
select pg_sleep(1);
COPY salaries FROM '/tmp/salaries.csv' DELIMITER ',' CSV HEADER;
select pg_sleep(1);
COPY departments FROM '/tmp/departments.csv' DELIMITER ',' CSV HEADER;
select pg_sleep(1);
COPY dept_emp FROM '/tmp/dept_emp.csv' DELIMITER ',' CSV HEADER;
select pg_sleep(1);
COPY dept_manager FROM '/tmp/dept_manager.csv' DELIMITER ',' CSV HEADER;
select pg_sleep(1);

