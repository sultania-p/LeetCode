/* Write your T-SQL query statement below */
with cte_actions as 
(
select
	*
from Actions
where datediff(day, action_date, '2019-07-05') =1 and action='report'
)
select
	extra as report_reason, 
	count(distinct post_id) as report_count
from cte_actions
group by extra
