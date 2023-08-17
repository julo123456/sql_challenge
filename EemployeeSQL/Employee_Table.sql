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