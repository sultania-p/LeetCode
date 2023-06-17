/* Write your T-SQL query statement below */
with cte as (
	select
		to_id as person1 , from_id as person2,
		duration
	from Calls where from_id > to_id
	UNION ALL
	select
		from_id as person1 , to_id as person2,
		duration
	from Calls where from_id < to_id
)
select 
	person1, person2,
	count(1) as call_count,
	sum(duration) as total_duration
from cte
group by person1, person2