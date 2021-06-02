-- 1 SELECT FROM
-- select all colmuns/rows from table
SELECT
    *
FROM DEPARTMENTS;

-- select specific colmuns from table
SELECT
    DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS;

-- 2 Arithmetic Expressions
SELECT
    EMPLOYEE_ID, FIRST_NAME, SALARY
FROM employees;

SELECT
    EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY+100, SALARY+(SALARY*.10)
FROM employees;

-- 3 Null values , null is not same as 0 or blank
SELECT
    last_name, job_id, salary, commission_pct
FROM employees;

-- null has no affect with arithmetic expressions
SELECT
    last_name, job_id, salary, commission_pct, commission_pct+10
FROM employees;

-- 4 Column Alias
SELECT LAST_NAME, LAST_NAME AS NAME, LAST_NAME LNAME, LAST_NAME "LAST nAME"
FROM employees;

-- 5 Concatenation operator || links columns or char strings
SELECT
    FIRST_NAME, LAST_NAME, FIRST_NAME||LAST_NAME "full name",
    FIRST_NAME||' '||LAST_NAME "full name with space" -- using literal char strings
FROM employees;

SELECT
    FIRST_NAME || ' works in department '|| DEPARTMENT_ID
FROM employees;

-- using q for extra apostrophes
SELECT
    FIRST_NAME || q'[ works in department ]'|| DEPARTMENT_ID
FROM employees;

-- 8 Distinct

SELECT -- Before distinct, shows actual column
    DEPARTMENT_ID
FROM EMPLOYEES;

SELECT DISTINCT -- after distinct
    DEPARTMENT_ID
FROM EMPLOYEES;

SELECT DISTINCT -- distinct example 2
    DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES;

-- 9 Describe , displays the structure of a table
DESCRIBE EMPLOYEES;
DESC EMPLOYEES;




-- Operators, Where, and order by
select * from employees;

select * from employees where DEPARTMENT_ID=90;

select * from employees where salary=24000;

select employee_id, first_name, last_name, job_id
from employees
where first_name='Steven';

select * from employees where salary>=10000;

select * from employees where hire_date>'17-oct-03';

select employee_id, first_name, last_name, job_id
from employees
where first_name>'Alberto';

select employee_id, first_name, last_name, job_id
from employees
where first_name>'Alberto'
order by first_name;


-- Between and in operator
select * from employees where first_name between 'A' and 'C'
order by first_name;

select * from EMPLOYEES
where salary in (10000, 25000, 17000);

-- like operator % is zero or more chars, and _ is one char
select * from employees where first_name like 'S%'; -- start with s
select * from employees where first_name like '%s'; -- end with s
select * from employees where first_name like '%am%'; -- contains am

select * from employees where first_name like '_d%'; -- second letter is d
select * from employees where first_name like '__s%'; -- third letter is s

select job_id from jobs where job_id like 'SA/_%' escape '/'; -- like operatot using Escape, third letter is space after sa




-- IS NULL
select first_name, commission_pct
from employees;

select * from employees where commission_pct is null;

-- not operator
select * from employees where employee_id not in (100, 101);
select * from employees where commission_pct is not null;

select * from employees where first_name not like 'S%'; -- names that dont start with s

select * from employees where department_id !=50; -- can also use <> for not !=



-- Logical operators and or not
select employee_id, LAST_NAME, JOB_ID, SALARY, DEPARTMENT_id
from   employees
where salary >= 10000
and department_id=90;

select employee_id, LAST_NAME, JOB_ID, SALARY, DEPARTMENT_id
from   employees
where salary >= 10000
or department_id=90;

-- and is prioritized over or
select last_name, job_id, salary from employees
where job_id = 'SA_REP' or job_id='AD_PRESS' and salary >15000;


-- order by clause by default asc for ascending or desc for descending 
select * from employees
where department_id = 90
order by employee_id desc;

select * from employees order by commission_pct desc; -- null first
select * from employees order by commission_pct;

select first_name n -- name alias ordering
from employees
order by n;

select department_id, first_name, salary  -- order first column, then order within that column sorting
from employees order by department_id,first_name;

select department_id, first_name, salary  -- order first column, then order within that column sorting
from employees order by 1,3; -- use numbers from selected columns


-- Fetch clause

select employee_id, first_name
from employees
order by employee_id
fetch first 5 rows only;

select employee_id, first_name
from employees
order by employee_id
fetch first 50 percent rows only;

select employee_id, first_name -- fectch after n rows of n rows
from employees
order by employee_id
offset 5 rows fetch next 5 rows only;

select employee_id, first_name --fectch after n rows of n rows using %
from employees
order by employee_id
offset 4 rows fetch next 50 percent rows only;

select employee_id, first_name, salary --fectch after n rows of n rows using %
from employees
order by salary desc
fetch first 2 rows with ties; -- with ties is to return all records of same value




-- Substitution variable using & or &&
Select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num;

-- use '' for varchar
Select employee_id, first_name, last_name, salary, department_id
from employees
where first_name = '&ename'
order by 2;

--specifying column name, expression, and text
--colm name = salary, condition = salary>10000, &order_column=employee_id
Select employee_id, last_name, job_id, &column_name
from employees
where &condition
order by &order_column;

-- define and undefine
DEFINE employee_num = 200;

Select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num;

undefine employee_num;

-- Accept/prompt
accept dept_id prompt 'please enter dept id;
select * from Employees
where department_id = &dept_id;

undefine dept_id;

-- double amp && , doesnt prompt to define twice
select * from departments where department_id=&&p;
undefine p;


Select employee_id, last_name, job_id, &&column_name
from employees
order by &column_name;

undefine column_name;


-- set verify on
set verify on
select employee_id, last_name, salary
from employees
where employee_id = &e_num;


-- set define off
set define off;
select * from departments
where department_name like '%&t%'; -- &t is not a variable but char


