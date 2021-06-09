
-- group functions sum, count, max,min, avg
select salary from employees order by salary desc;

select max(salary), min(salary)
from employees;

select max(first_name), min(first_name)
from employees;

select max(hire_date), min(hire_date)
from employees;

select sum(salary), avg(commission_pct)
from employees;

-- count
select count(*) from employees; -- null counted
select count(1) from employees; -- null counted, same as *
select count(commission_pct) from employees; -- null not counted

select count(department_id) from employees; -- null not counted
select count(distinct department_id) from employees; -- null not counted

-- use nvl to count nulls
select count(nvl(commission_pct,0)) from employees;
select count(department_id) from employees where department_id = 90; -- null not counted

-- LISTAGG func
select first_name from employees where department_id = 30 order by first_name;
-- listagg version
select LISTAGG(FIRST_NAME, ', ')
        within group(order by FIRST_NAME) "Emp_list"
    from employees
    where department_id = 30;



-- group by 
select department_id, job_id, sum(salary)
from employees 
group by department_id,job_id
order by 1,2;

select department_id, sum(salary)
from employees
group by department_id
having sum(salary)>150000
order by department_id;

select max(sum(salary))
from employees 
group by department_id
order by 1;




-- DIsplaying data - Joins

--cartesian product 107 employees, and 27 depts. So 2889 rows will be displayed
select 
employees.employee_id,
employees.first_name,
employees.department_id,
departments.department_name
from employees, departments
order by employee_id;

-- Old Joins: Equijoin or called simple or inner joins
select 
employees.employee_id,
employees.first_name,
employees.department_id,
departments.department_name
from employees, departments
where employees.department_id=departments.department_id 
and employees.department_id>40
order by employee_id;

-- using allias
select 
emp.employee_id,
emp.first_name,
emp.department_id,
dept.department_name
from employees EMP ,
departments DEPT
where emp.department_id=dept.department_id 
and emp.department_id>40
order by employee_id;

--equijoin 3 tables
select 
emp.employee_id,
emp.first_name,
emp.department_id,
dept.department_name,
dept.location_id,
loc.city
from employees EMP ,
departments DEPT,
locations loc
where emp.department_id=dept.department_id
and dept.location_id=loc.location_id
order by employee_id;



--Nonequijoins

-- CREATE TABLE
CREATE TABLE JOB_GRADES
(
    GRADE_LEVEL VARCHAR2(3),
    LOWEST_SAL NUMBER,
    HIGHEST_SAL NUMBER
    
);

-- insert trecords into table
INSERT INTO JOB_GRADES(GRADE_LEVEL,LOWEST_SAL, HIGHEST_SAL)
VALUES ('A',1000,2999);
INSERT INTO JOB_GRADES(GRADE_LEVEL,LOWEST_SAL, HIGHEST_SAL)
VALUES ('B',3000,5999);
INSERT INTO JOB_GRADES(GRADE_LEVEL,LOWEST_SAL, HIGHEST_SAL)
VALUES ('C',6000,9999);
INSERT INTO JOB_GRADES(GRADE_LEVEL,LOWEST_SAL, HIGHEST_SAL)
VALUES ('D',10000,14999);
INSERT INTO JOB_GRADES(GRADE_LEVEL,LOWEST_SAL, HIGHEST_SAL)
VALUES ('E',15000,24999);
INSERT INTO JOB_GRADES(GRADE_LEVEL,LOWEST_SAL, HIGHEST_SAL)
VALUES ('F',25000,40000);
COMMIT;

SELECT * FROM JOB_GRADES;

SELECT E.EMPLOYEE_ID,E.FIRST_NAME, E.SALARY, J.GRADE_LEVEL
FROM EMPLOYEES E, JOB_GRADES J
WHERE E.SALARY BETWEEN J.LOWEST_SAL AND J.HIGHEST_SAL;

-- SUBQUERY EXAMPLE
SELECT E.EMPLOYEE_ID,E.FIRST_NAME, E.SALARY, J.GRADE_LEVEL
FROM EMPLOYEES E, JOB_GRADES J
WHERE E.SALARY >= J.LOWEST_SAL AND E.SALARY<=J.HIGHEST_SAL;



--Outer joins(+), displays rows with null values for one of the equijoin tables
select -- w/o outer joins
employees.employee_id,
employees.first_name,
employees.department_id,
departments.department_name
from employees, departments
where employees.department_id=departments.department_id(+) 
order by employee_id;

select 
employees.employee_id,
employees.first_name,
employees.department_id,
departments.department_name
from employees, departments
where employees.department_id=departments.department_id(+) 
order by employee_id;



--self join

select employee_id, first_name, manager_id --before
from employees;

select Worker.employee_id,  -- after, displays 106/107
Worker.first_name, 
Worker.manager_id, 
Manager.first_name
from employees Worker, employees Manager
where worker.manager_id = manager.employee_id;

-- with outer join
select Worker.employee_id,  -- after
Worker.first_name, 
Worker.manager_id, 
Manager.first_name
from employees Worker, employees Manager
where worker.manager_id = manager.employee_id(+);


-- example 2 w outer join
select count(1)
from employees
where salary>2500;

select emp.employee_id, emp.first_name, emp.department_id,
dept.department_name, dept.location_id,
loc.city, cont.country_name
from employees emp, departments dept, locations loc, countries cont
where emp.department_id = dept.department_id(+)
and dept.location_id = loc.location_id(+)
and  loc.country_id =  cont.country_id(+)
and salary>2500;




--1999 Syntax

--cross join (cortesian product)
select 
employees.employee_id,
employees.first_name,
departments.department_id,
departments.department_name
from employees cross join departments
order by employee_id;

-- natural join (equijoins)
select 
departments.department_id,
departments.department_name,
location_ID, -- NOTE Can not prefix table name in the mathing columns
locations.city
from departments natural join locations;


-- using join (mutually exclusive to natural join as column is specified,  equijoin) 
select 
employees.employee_id,
employees.first_name,
department_id, -- NOTE Can not prefix table name in the mathing columns
departments.department_name
from employees join departments
using (department_id)
order by employee_id;

-- on join clause (equijoins)
select
employees.employee_id,
employees.first_name,
departments.department_id, -- prefix is used
departments.department_name
from employees
join departments
on(employees.department_id=departments.department_id)
order by employee_id;


-- on join - nonequijoins
select emp.employee_id, emp.first_name, emp.salary, grades.grade_level
from employees emp join job_grades grades
on emp.salary between grades.lowest_sal and grades.highest_sal;


-- on join (self-join)
select worker.employee_id,
worker.first_name,
worker.manager_id,
manager.first_name
from employees worker join
employees manager
on (worker.manager_id = manager.employee_id);


-- left, right, full outerjoin
select emp.employee_id,
emp.first_name,
emp.department_id,
dept.department_name
from employees emp 
left outer join departments dept
on (emp.department_id = dept.department_id);

select emp.employee_id,
emp.first_name,
emp.department_id,
dept.department_name
from employees emp 
right outer join departments dept
on (emp.department_id = dept.department_id);

select emp.employee_id,
emp.first_name,
emp.department_id,
dept.department_name
from employees emp 
full outer join departments dept
on (emp.department_id = dept.department_id)
