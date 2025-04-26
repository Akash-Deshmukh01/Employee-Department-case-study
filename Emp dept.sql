-- EMPLOYMENT DEPARTMENT ANALYSIS

create database Employee_Analysis;
use Employee_Analysis;

-- Q1. Create the Employee Table as per the Below Data Provided.

create table emp_info (
empno int not null unique,
ename varchar(50) not null,
job varchar(50) default 'Clerk',
mgr int,
hiredate date,
salary decimal(10,2) check (Salary > 0),
comm int,
deptno int,
primary key (empno),
foreign key (deptno) references Dept (deptno)
);

insert into emp_info ( empno, ename, job, mgr, hiredate, salary, comm, deptno) values
(7369, 'Smith', default, 7902, '1890-12-17', 800.00, null, 20),
(7499, 'Allen', 'Salesman', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'Ward', 'Salesman', 7698, '1981-02-20', 1250.00, 500.00, 30),
(7566, 'Jones', 'Manager', 7839, '1981-04-02', 2975.00, null, 20),
(7654, 'Martin', 'Salesman', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'Blake', 'Manager', 7839, '1981-05-01', 2850.00, null, 30),
(7782, 'Clark', 'Manager', 7839, '1981-06-09', 2450.00, null, 10),
(7788, 'Scott', 'Analyst', 7566, '1987-04-19', 3000.00, null, 20),
(7839, 'King', 'President', null, '1981-11-17', 5000.00, null, 10),
(7844, 'Turner', 'Salesman', 7698, '1981-09-08', 1500.00, 0.00, 30),
(7876, 'Adams', default	, 7788, '1987-05-23', 1100.00, null, 20),
(7900, 'James', default, 7698, '1981-12-03', 950.00, null, 30),
(7902, 'Ford', 'Analyst', 7566, '1981-12-03', 3000.00, null, 20),
(7934, 'Miller', 'Clerk', 7782, '1982-01-23', 1300.00, null, 10);


-- Q2. Create the Dept Table as below

create table Dept (
deptno int primary key,
dname varchar(50),
loc varchar(50)
);

insert into Dept (deptno, dname, loc) values
(10, 'Operations', 'Boston'),
(20, 'Research', 'Dallas'),
(30, 'Sales', 'Chicago'),
(40, 'Accounting', 'New york');

-- Q3. List the Names and salary of the employee whose salary is greater than 1000

select ename, salary from emp_info
where salary > 1000;

-- Q4. List the details of the employees who have joined before end of September 81.

select * from emp_info
where hiredate <= '1981-09-30';

-- Q5. List Employee Names having I as second character.

select ename from emp_info
where ename like '_i%';

-- Q6. List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns

select ename, salary,
salary * 0.40 as "Allowances",
salary * 0.10 as "P.F",
salary + (salary * 0.40) - (salary * 0.10) as "Net Salary"
from emp_info;

-- Q7. List Employee Names with designations who does not report to anybody

select ename, job
from emp_info
where mgr is null;

-- Q8. List Empno, Ename and Salary in the ascending order of salary.

select empno, ename, salary 
from emp_info
order by salary asc;

-- Q9. How many jobs are available in the Organization ?

select count(distinct job) as "Total Job Available"
from emp_info;

-- Q10. Determine total payable salary of salesman category

select sum(salary + ifnull(comm, 0)) as "Total Payable Salary"
from emp_info
where job = "salesman";

-- Q11. List average monthly salary for each job within each department   

select deptno, job,
Round(avg(salary), 2) as "Average Monthly Salary"
from emp_info
group by deptno, job
order by deptno, job;

-- Q12. Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.

select ename as empname,
salary as salary,
dname as deptname
from emp_info
join dept on emp_info.deptno = dept.deptno;


-- Q13. Create the Job Grades Table as below

create table Job_Grades ( 
grade varchar(10),
lowest_sal int,
highest_sal int);

insert into Job_Grades (grade, lowest_sal, highest_sal) values
('A', 0, 999),
('B', 1000, 1999),
('C', 2000, 2999),
('D', 3000, 3999),
('E', 4000, 5000);

select * from Job_Grades;

-- Q14. Display the last name, salary and  Corresponding Grade.

select 
ename as empname,
salary as salary,
Grade as Grade
from emp_info
join Job_Grades J
on salary between J.lowest_sal and J.highest_sal;

-- Q15. Display the Emp name and the Manager name under whom the Employee works in the below format .(Emp Report to Mgr)

 select 
 e.ename as employee,
 m.ename as manager,
 concat(e.ename, 'reports to', m.ename) as Report_line
 from emp_info e 
 join
 emp_info m on e.mgr = m.empno;

-- Q16. Display Empname and Total sal where Total Sal (sal + Comm)

select ename as empname,
salary + ifnull(comm,2) as Total_Sal
from emp_info;

-- Q17. 17.	Display Empname and Sal whose empno is a odd number

select ename, salary
from emp_info
where mod(empno,2) = 1;

-- Q18. Display Empname , Rank of sal in Organisation , Rank of Sal in their department

select ename, salary,
rank() over (order by salary desc) as 'Organization of Sal Rank',
rank() over (partition by deptno order by salary desc) as 'Department of Sal Rank'
from emp_info;

-- Q19. Display Top 3 Empnames based on their Salary

select ename, salary
from emp_info
order by salary desc
limit 3;

-- Q20. Display Empname who has highest Salary in Each Department. 

select ename, salary, deptno
from (
select ename, salary, deptno,
rank() over (partition by deptno order by salary desc) as Highest_Salary
from emp_info)
Ranked where Highest_salary = 1;















