/* Write your T-SQL query statement below */
with cte_interval as (
	select 
		user_id,
		visit_date,
		isnull(LEAD(visit_date, 1) over (partition by user_id order by visit_date), '2021-01-01') as nxt_date
	from UserVisits
) 
select 
	user_id, 
	max(DATEDIFF(day, visit_date, nxt_date)) as biggest_window
from cte_interval
group by user_id
order by user_id