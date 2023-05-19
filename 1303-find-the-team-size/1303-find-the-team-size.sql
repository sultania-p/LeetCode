/* Write your T-SQL query statement below */
select 
	employee_id,
	sq.team_size
from employee e 
left join (
			select
				team_id,
				count(team_id) as team_size
			from Employee
			group by team_id
		) sq on e.team_id = sq.team_id