/* Write your T-SQL query statement below */
with cte_salary_cnt as (
	select
		salary,
		count(1) as salary_cnt
	from Employees
	group by salary
), cte_emp_salary as (
	select
		E.*,
		salary_cnt
	from Employees E
	join cte_salary_cnt c on E.salary=c.salary
)
select 
	employee_id,
	name,
	salary,
	dense_rank() over (order by salary) as team_id
from cte_emp_salary 
where salary_cnt <> 1
order by team_id, employee_id