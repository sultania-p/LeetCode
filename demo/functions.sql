select @@VERSION


select top 1 salary from 
(
select top 3 salary
from tbl_employees
order by salary desc
) sq order by salary asc

select STUFF('Elephant', 1, 3, 'Bele')
select CHARINDEX('l', 'Elephant', 1)

select *
	,LAG(Salary, 1, 0) over (order by EmpID) as SalaryLead
from tbl_Employees 


select FIRST_VALUE(EmpID) over (partition by Department order by Salary desc) from tbl_Employees
select LAST_VALUE(EmpID) over (partition by Department order by Salary desc) from tbl_Employees

select * from tbl_employees
select sum(salary) over (partition by department order by EmpID asc) as totSal from tbl_employees

declare @name varchar(50) = 'Piyush Kumar Sultania'
select @name, substring(@name, 1, CHARINDEX(' ', @name, 1)-1)

--temp table
create table #employee (empid int, empname varchar(20))

select * from #employee