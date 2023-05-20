/* Write your T-SQL query statement below */
with cte_activity_stats as (
	select
		activity,
		count(1) as activity_cnt
	from Friends
group by activity 
), cte_max_min as (
	select activity 
	from cte_activity_stats 
	where activity_cnt = (select max(activity_cnt) from cte_activity_stats)
	UNION
	select activity 
	from cte_activity_stats 
	where activity_cnt = (select MIN(activity_cnt) from cte_activity_stats)
)
select activity
from cte_activity_stats where activity not in (select * from cte_max_min)
