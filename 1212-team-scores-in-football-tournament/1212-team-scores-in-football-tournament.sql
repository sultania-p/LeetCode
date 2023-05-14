/* Write your T-SQL query statement below */
select t.team_id, t.team_name, isnull(sum(num_points), 0) as num_points
from  teams t
left join (
	select
		host_team as team_id,
		3 as num_points
	from matches where host_goals>guest_goals
	UNION  ALL
	select
		guest_team as team_id,
		3 as num_points
	from matches where host_goals<guest_goals
	UNION ALL
	select
		host_team as team_id,
		1 as num_points
	from matches where host_goals=guest_goals
	UNION ALL
	select
		guest_team as team_id,
		1 as num_points
	from matches where host_goals=guest_goals
) sq on sq.team_id=t.team_id 
group by t.team_id, t.team_name
order by num_points desc, t.team_id asc