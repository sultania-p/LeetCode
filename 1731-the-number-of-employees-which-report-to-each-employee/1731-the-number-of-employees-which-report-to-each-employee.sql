/* Write your T-SQL query statement below */
with cte as (
	select
		E.employee_id as  employee_id,
		E.name as employee_name,
		E.age as employee_age,
		M.employee_id as manager_id,
		M.name as manager_name
	from Employees E
	left join Employees M on M.employee_id = E.reports_to
)
select 
	manager_id as employee_id,
	manager_name as name,
	count(employee_id) as reports_count,
	cast(ROUND(avg(employee_age * 1.00), 0) as int) as average_age 
from cte
where manager_id is not null
group by manager_id, manager_name
order by manager_id