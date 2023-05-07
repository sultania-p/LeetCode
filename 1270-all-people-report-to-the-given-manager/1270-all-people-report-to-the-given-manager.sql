/* Write your T-SQL query statement below */

with cte_managers as (
select
	e.employee_id,
	e.manager_id as m1,
	m2.manager_id as m2,
	m3.manager_id as m3
from Employees e
left join Employees m2 on e.manager_id=m2.employee_id
left join Employees m3 on m2.manager_id=m3.employee_id
where e.employee_id<>e.manager_id
)
select employee_id
from cte_managers
where m1=1 or m2=1 or m3=1