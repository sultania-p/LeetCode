/* Write your T-SQL query statement below */
select
	p.project_id,
	cast(sum(e.experience_years * 1.00) / count(p.employee_id) as decimal(10,2)) as average_years
from project p
join employee e on p.employee_id = e.employee_id
group by p.project_id