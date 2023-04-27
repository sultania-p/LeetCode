# Write your MySQL query statement below
with cte_all_emp as (
	select 
		p.project_id,
		p.employee_id,
		e.experience_years
	from project p
	join employee e on p.employee_id=e.employee_id
), cte_exp_max as 
(
	select project_id, max(experience_years) as exp_max from cte_all_emp group by project_id
)
select 
	p.project_id, p.employee_id
from cte_all_emp p join cte_exp_max c on p.project_id=c.project_id and p.experience_years=exp_max