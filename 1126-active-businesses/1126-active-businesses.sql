/* Write your T-SQL query statement below */

with cte_avg_activity as (
	select event_type,
				cast(avg(occurences * 1.00) as decimal(10,2)) as avg_occurences
		from Events
		group by event_type
)

select 
	business_id
from Events e
where event_type in (select event_type from cte_avg_activity c where e.event_type=c.event_type and e.occurences > c.avg_occurences)
group by e.business_id
having count(1) > 1