/* Write your T-SQL query statement below */
select 
	project_id
from project p
group by project_id
having count(employee_id) = (select max(emp_count) from
								(select count(employee_id) as emp_count from project group by project_id) sq
							)
