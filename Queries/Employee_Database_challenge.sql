-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees ( emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_employees (
  emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

DROP TABLE titles CASCADE
CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR(60) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no, from_date)
);

SELECT * FROM titles 

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

DROP TABLE retirement_info

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_employees.emp_no;

SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_employees.to_date
INTO current_employees
FROM retirement_info
LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_employees.emp_no
WHERE dept_employees.to_date = ('9999-01-01');

DROP TABLE dpet_retirement_info CASCADE

-- Employee count by department number
SELECT COUNT(current_employees.emp_no), dept_employees.dept_no
INTO dept_retirement_info
FROM current_employees
LEFT JOIN dept_employees
ON current_employees.emp_no = dept_employees.emp_no
GROUP BY dept_employees.dept_no
ORDER BY dept_employees.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name, gender
INTO employee_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT employees.emp_no,
    employees.first_name,
employees.last_name,
    employees.gender,
    salaries.salary,
    dept_employees.to_date
INTO employee_info
FROM employees
INNER JOIN salaries
ON (employees.emp_no = salaries.emp_no)
INNER JOIN dept_employees
ON (employees.emp_no = dept_employees.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (employees.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (dept_employees.to_date = '9999-01-01');
	 
-- List of managers per department
SELECT  dept_manager.dept_no,
        departments.dept_name,
        dept_manager.emp_no,
        current_employees.last_name,
        current_employees.first_name,
        dept_manager.from_date,
        dept_manager.to_date
INTO manager_info
FROM dept_manager
    INNER JOIN departments
        ON (dept_manager.dept_no = departments.dept_no)
    INNER JOIN current_employees
        ON (dept_manager.emp_no = current_employees.emp_no);
		
SELECT current_employees.emp_no,
current_employees.first_name,
current_employees.last_name,
departments.dept_name
INTO dept_info
FROM current_employees
INNER JOIN dept_employees
ON (current_employees.emp_no = dept_employees.emp_no)
INNER JOIN departments
ON (dept_employees.dept_no = departments.dept_no);

--

-- Create Retirement Tiels table that holds
-- titles of employees ready for retirement.

select employees.emp_no,
employees.first_name,
employees.last_name,
titles.title,
titles.from_date,
titles.to_date
into retirement_titles
from employees
inner join titles
on (employees.emp_no = titles.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

select * From retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) retirement_titles.emp_no,
retirement_titles.first_name,
retirement_titles.last_name,
retirement_titles.title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, title DESC;

select * from unique_titles

-- Create Retiring titles  table with total number of retirement-age
-- employess by job title

select count(unique_titles.emp_no),
unique_titles.title
into retiring_titles
from unique_titles
group by title
order by count(title) desc;

select * from retiring_titles

-- Mentorship eligibility for employees born in 1965
select distinct on(employees.emp_no) employees.emp_no, 
    employees.first_name, 
    employees.last_name, 
    employees.birth_date,
    dept_employees.from_date,
    dept_employees.to_date,
    titles.title
into mentorship_eligibility
from employees
left outer join dept_employees 
on (employees.emp_no = dept_employees.emp_no)
left outer join titles 
on (employees.emp_no = titles.emp_no)
where (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by employees.emp_no;

select * from mentorship_eligibility
