USE PROJECT;
  -- Q1 
  SELECT * FROM EMP WHERE SALARY >=2500 AND DEPT_NO= 20;
-- Q2 
SELECT * FROM EMP WHERE JOB ="MANAGER" AND DEPT_NO =20 AND 30;
              
-- Q3 
SELECT * FROM EMP WHERE MGR IS NULL;
-- Q4 
SELECT ENAME FROM EMP 
WHERE JOB="ANALYST" AND ENAME  NOT regexp 'S$';
-- Q5 
SELECT * FROM EMP WHERE COMM IS NOT NULL
AND JOB NOT IN ("ANALYST",'MANAGER');
-- Q6 
SELECT * FROM EMP 
WHERE ENAME regexp 'E${1}';
-- Q7
SELECT EMP_ID,ENAME,SALARY,COMM,
SUM(SALARY+COMM) OVER( partition by EMP_ID) AS TOTAL_SAL FROM EMP
   group by EMP_ID
	HAVING SUM(SALARY+COMM)>2000;
-- Q8
SELECT * FROM EMP 
WHERE COMM IS NOT NULL 
AND DEPT_NO IN(20,30);
-- Q9 
SELECT * FROM EMP 
WHERE JOB ='MANAGER' AND ENAME  NOT REGEXP '^[AS]';
-- Q10
SELECT * FROM EMP 
WHERE SALARY between 2500 AND 5000 AND DEPT_NO IN(10,20);
-- Q11
SELECT  JOB,MAX(SALARY) AS MAX_SALARY FROM EMP
	group by JOB
	order by  MAX_Salary asc;
-- q12
select job,count(*) as no from emp
   group by job
	having no>=3;
	-- q13
    select  job,emp_id,
	avg(salary) over(partition by job) as avgsal  from emp 
	group by job ,emp_id 
      having  emp_id not between 7788 and 7790;  
-- q14 

select emp_id,ename,job,salary, dept_no,
sum(salary)over(partition by dept_no) as total_sal from emp
where job in('manager','analyst');
-- q15
-- assignment  on sub queries 
select ename from emp 
where salary> all(select salary from emp where job ='manager');
-- q16
select ename from emp 
where salary> any(select salary from emp where job ='manager');
-- q17
select emp_id,ename,job from emp 
where  job ='analyst' and salary> any(select salary from emp where job ='manager');
-- q18
select* from emp where dept_no in(select dept_no from department where loc='dallas');
-- q19
select dname,loc from department where dept_no in(select  dept_no
 from emp where job='clerk');
-- Q20
select* from emp where  job ='manager' and dept_no in(select  dept_no from department);
-- Q21
select max(salary)as max_salary from emp;
-- q22
 select * from emp 
 group by emp_id
  order by salary desc limit 1 offset 1;
  -- Q23
   select * from emp 
 group by emp_id
  order by salary desc limit 1 offset 2;
  
 -- Q24
 select * from emp where job in('manager','clerk') and dept_no in(select  dept_no from department where dname='accounting');
 -- Q25
 select * from emp where job='SALESMAN' and dept_no in(select  dept_no from department where loc!='dallas');
 -- Q26
  select * from emp 
   where dept_no in ( select dept_no from emp 
   where ename ='scott');
-- Q27
select * from emp
where salary in( select salary from emp where ename="smith");
-- Q28
select * from emp 
where salary>(select avg(salary) from emp);

-- 29
select emp_id,ename,dname  from emp a 
inner join department b
on a .dept_no=b.dept_no
 where job in ('manager','clerk')
 and dname in('sales','accounting');
 -- 30
 select emp_id,ename,dname,loc  from emp a 
inner join department b
on a .dept_no=b.dept_no
 where
 dname ='sales' and loc !='dallas';
-- 31
 select  emp_id,ename, job,dname,loc 
 from department a 
 inner join emp b
 on a.dept_no=b.dept_no
 where b.job='clerk';
 -- 32
 select * from department a 
 inner join emp b
 on a.dept_no=b.dept_no
 where job='manager';
 -- Q33
 select * from emp a
 inner join department b
 on a.dept_no=b.dept_no
 where  loc='dallas';
 -- Q34
 delete from  department
 where dept_no not in(select distinct dept_no from emp);
 /* 35 Display all the departmental information for all the existing employees and if 
a department has no employees display it as “No employees”. */
 select dname,a.dept_no ,
 coalesce(ename,emp_id ) as empl_name from department a
 left join emp b
 on a.dept_no=b.dept_no;
 
 /* 36 Get all the matching & non-matching records from both the tables. */
 select * from emp a
 left join department b
 on a.dept_no=b.dept_no
 ;
 /* 37 Get only the non-matching records from DEPT table (matching records 
shouldn’t be selected). */
select * from emp a 
left join department b
on a.dept_no=b.dept_no
 where b.dept_no is null;
 /*38) Select all the employees name along with their manager names, and if an 
employee does not have a manager, display him as “CEO”. */
select e1.ename as employee_name ,e2.ename as manger_name ,
    case
    when  e2.ename is null then "ceo"
    ELSE E2.ENAME
    end as "manager_name"
    from emp e1
 left join emp e2 
  on e1.mgr=e2.emp_id;
-- 39 Get all the employees who work in the same departments as of SCOTT
select * from  emp a
join emp b
on a.dept_no=b.dept_no
where b.ename ='scott';
--  40 Display all the employees who have joined before their managers.
 select  a.ename,a.hiredate ,b.ename as manager_name,b.hiredate 
 from emp a 
join emp b
on a.mgr=b.emp_id 
where a.hiredate<b.hiredate;
-- 41  List all the employees who are earning more than their managers.
 select  a.ename,a.salary ,b.ename as manager_name,b.salary 
 from emp a 
join emp b
on a.mgr=b.emp_id 
where a.salary>b.salary;
-- 42 Fetch all the employees who are earning same salaries
 select e1.emp_id, e1.ename as emp_name,e1.salary as salary ,e2.emp_id,  e2.ename as emp_name ,e2.salary as salary
from emp e1 
  join emp e2 
  on e1.salary=e2.salary
  where e1.emp_id!=e2.emp_id
  ;
  -- 43
  select ename,salary from emp 
  where salary in(select salary from emp where ename='smith');
  
  select  * from emp e1 
 inner join emp e2 
  on e1.salary=e2.salary
   where e2.ename="smith"
    ;
    -- 44 Display employee name , his date of joining, his manager name & his manager's date of joining.
select  a.ename as employee_name,a.hiredate ,b.ename as manager_name,b.hiredate as manager_hiredate
 from emp a 
join emp b
on a.mgr=b.emp_id 
;