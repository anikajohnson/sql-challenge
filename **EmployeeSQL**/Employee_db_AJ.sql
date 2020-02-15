-- Create a table of employees
CREATE TABLE employees (
	emp_no_id INTEGER NOT NULL PRIMARY KEY,
	birth_date VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date VARCHAR NOT NULL
);

-- Create a table of departments
CREATE TABLE departments (
	dept_no_id VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL
);

-- Create a table of dept_emp
CREATE TABLE dept_emp (
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no_id),
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no_id),
	from_date VARCHAR NOT NULL,
	to_date VARCHAR NOT NULL
);

-- Create a table of titles
CREATE TABLE titles (
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no_id),
	title VARCHAR NOT NULL,
	from_date VARCHAR NOT NULL,
	to_date VARCHAR NOT NULL
);

-- Create a table of salaries
CREATE TABLE salaries (
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no_id),
	salary INTEGER NOT NULL,
	from_date VARCHAR NOT NULL,
	to_date VARCHAR NOT NULL
);

-- Create a table of dept_manager
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no_id),
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no_id),
	from_date VARCHAR NOT NULL,
	to_date VARCHAR NOT NULL
);

--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select employees.emp_no_id, last_name, first_name, gender, salaries.salary
from employees
join salaries on employees.emp_no_id = salaries.emp_no;

--2. List employees who were hired in 1986.
select employees.emp_no_id, last_name, first_name, hire_date
from employees
where hire_date like '1986-%';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

select dept_manager.emp_no, dept_no, departments.dept_name,  from_date, to_date, employees.last_name, first_name 
from dept_manager
inner join departments on departments.dept_no_id = dept_manager.dept_no
inner join employees on dept_manager.emp_no = employees.emp_no_id;

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select employees.emp_no_id, last_name, first_name, departments.dept_name
from employees
inner join dept_emp on employees.emp_no_id = dept_emp.emp_no
inner join departments on departments.dept_no_id = dept_emp.dept_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."

select employees.emp_no_id, last_name, first_name
from employees
where first_name = 'Hercules' and last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select employees.emp_no_id, last_name, first_name, dept_name
from employees
inner join dept_emp on employees.emp_no_id = dept_emp.emp_no
inner join departments on departments.dept_no_id = dept_emp.dept_no
where dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select employees.emp_no_id, last_name, first_name, dept_name
from employees
inner join dept_emp on employees.emp_no_id = dept_emp.emp_no
inner join departments on departments.dept_no_id = dept_emp.dept_no
where dept_name = 'Sales' or dept_name = 'Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) as "Last Name Count"
from employees
group by last_name
order by last_name desc;


