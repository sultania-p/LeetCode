/* Write your T-SQL query statement below */
with cte_logs as (
select
	log_id,
	log_id - ROW_NUMBER() over (order by log_id) as row_diff
from Logs
)
select min(log_id) as start_id,
		max(log_id) as end_id
from cte_logs
group by row_diff
order by min(log_id)