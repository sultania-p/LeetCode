/* Write your T-SQL query statement below */
with cte as (
			select
				team_id,
				count(team_id) as team_size
			from Employee
			group by team_id
)
select 
	employee_id,
	sq.team_size
from employee e 
left join cte sq on e.team_id = sq.team_id