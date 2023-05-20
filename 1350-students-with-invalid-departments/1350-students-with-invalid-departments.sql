/* Write your T-SQL query statement below */
select 
	S.id,
	S.name
from Students S
where s.department_id not in (select id from Departments)