--To disable NOTICES in psql output
SET client_min_messages TO WARNING;

--To handle the DATE in MDY format in the data, change the Date format to MDY (By default, it is YMD(Depends on the location))
SET datestyle to MDY, SQL;
select now()::date; -- to check

--Drop the tables if they exist
DROP TABLE IF EXISTS "employees" CASCADE;
DROP TABLE IF EXISTS "salaries" CASCADE;
DROP TABLE IF EXISTS "titles" CASCADE;
DROP TABLE IF EXISTS "dept_emp" CASCADE;
DROP TABLE IF EXISTS "departments" CASCADE;
DROP TABLE IF EXISTS "dept_manager" CASCADE;

CREATE TABLE "titles" (
    "title_id" VARCHAR(5)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "title_id" PRIMARY KEY (
        "title_id"
    ),
    CONSTRAINT "title" UNIQUE (
        "title"
    )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER  NOT NULL,
    "emp_title_id" VARCHAR(5)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "sex" VARCHAR(1), --By default NULL
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "emp_no" PRIMARY KEY (
        "emp_no"
    ),
    CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id") REFERENCES "titles" ("title_id")
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL PRIMARY KEY REFERENCES "employees" ("emp_no"),
    "salary" INTEGER   NOT NULL
	-- https://dba.stackexchange.com/questions/253429/when-the-primary-key-is-also-the-foreign-key-in-postgres
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "dept_no" PRIMARY KEY (
        "dept_no"
    ),
    CONSTRAINT "dept_name" UNIQUE (
        "dept_name"
    )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL,
     -- Compsite, also Compound key
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     ),
    CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
    CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no") REFERENCES "departments" ("dept_no")
);


CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "emp_no" int PRIMARY KEY REFERENCES "employees" ("emp_no"),
    CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no") REFERENCES "departments" ("dept_no")
);
