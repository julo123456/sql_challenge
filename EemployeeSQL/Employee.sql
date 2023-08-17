-- create query to drop tables if exsits to avoid errors if needed
drop table if exists departments, titles, employees;

-- create departments table
create table departments(
	dept_no varchar(10) not null primary key, 
	dept_name varchar(30) not null
);

-- create titles table
create table titles(
	title_id varchar(10) not null primary key,
	title varchar(25) not null
);

-- drop tables if needed
drop table if exists employees, dept_emp, dept_manager, salaries;

-- create emplyees table
create table employees(
	emp_no int not null,
	emp_title_id varchar(10) not null,
	birth_date date not null,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	sex varchar(3) not null,
	hire_date date not null,
	primary key (emp_no),
	foreign key (emp_title_id) references titles(title_id)
);

-- create dept_emp table
create table dept_emp(
	emp_no int not null,
	dept_no varchar(10) not null,
	primary key (emp_no, dept_no),
	foreign key (emp_no) references employees(emp_no),
	foreign key (dept_no) references departments(dept_no)
);


-- create dept manager table
create table dept_manager(
	dept_no varchar(10) not null,
	emp_no int not null,
	primary key(dept_no, emp_no),
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
);


-- create salaries table
create table salaries(
	emp_no int not null primary key,
	salary int not null,
	foreign key (emp_no) references employees(emp_no)
);

select * from departments;
select * from titles;
select * from employees;
select * from dept_emp;
select * from dept_manager;
select * from salaries;


-- start making lists
-- 1. list the employee number, last name, first name, sex and salary of each employee.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
from employees as e
join salaries as s on 
s.emp_no = e.emp_no;

-- 2. list the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where hire_date between '1/1/1986' and '12/31/1986';


-- 3. list the manager of each department along with their department number, department name, 
-- employee number, last name, and first name.
select d.dept_no, d.dept_name,  e.emp_no, e.last_name, e.first_name
from employees as e
join dept_manager as dm on
dm.emp_no = e.emp_no
join departments as d on
dm.dept_no = d.dept_no;



-- 4. List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de 
on de.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no;


-- 5. List first name, last name, and sex of each employee whose first name is Hercules and 
-- whose last name begins with the letter B
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and last_name like 'B%';



-- 6. List each employee in the Sales department, including their employee number, last name,
-- and first name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de 
on de.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no
where dept_name = 'Sales';


-- 7. List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees as e
join dept_emp as de 
on de.emp_no = e.emp_no
join departments as d
on d.dept_no = de.dept_no
where dept_name = 'Sales' or dept_name = 'Development';


-- 8. List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name)
select last_name, count(last_name) as "frequency_last_name"
from employees
group by last_name
order by "frequency_last_name";

