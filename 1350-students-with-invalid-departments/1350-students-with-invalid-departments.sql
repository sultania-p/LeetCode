/* Write your T-SQL query statement below */

select id, name from Students 
EXCEPT
select 
	S.id,
	S.name
from Students S
join Departments D on S.department_id = D.id