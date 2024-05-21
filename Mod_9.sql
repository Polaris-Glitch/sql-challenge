-- create departments table
CREATE TABLE departments (
  dept_no VARCHAR PRIMARY KEY,
  dept_name VARCHAR NOT NULL
);

-- create titles table
CREATE TABLE titles (
  title_id VARCHAR PRIMARY KEY,
  title VARCHAR NOT NULL
);

-- create employees table
CREATE TABLE employees (
  emp_no SERIAL PRIMARY KEY,
  emp_title_id VARCHAR NOT NULL,
  birth_date VARCHAR NOT NULL,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  sex VARCHAR NOT NULL,
  hire_date VARCHAR NOT NULL,
  FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- create dept_emp table
CREATE TABLE dept_emp (
  emp_no INTEGER NOT NULL,
  dept_no VARCHAR NOT NULL,
  PRIMARY KEY (emp_no, dept_no),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- create dept_managers table with composite primary key
CREATE TABLE dept_managers (
  dept_no VARCHAR NOT NULL,
  emp_no INTEGER NOT NULL,
  PRIMARY KEY (dept_no, emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- create salaries table
CREATE TABLE salaries (
  emp_no INTEGER PRIMARY KEY,
  salary INTEGER NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


--List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT e.first_name, e.last_name, e.emp_no, dm.dept_no, d.dept_name
FROM employees e
JOIN dept_managers dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_no = 'd007';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_no = 'd007'
OR d.dept_no = 'd005'

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;