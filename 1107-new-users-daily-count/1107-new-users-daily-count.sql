/* Write your T-SQL query statement below */
with cte_earliest_login as 
(select user_id, min(activity_date) as earliest_login from traffic where activity = 'login' group by user_id)

select 
	earliest_login as login_date,
	count(1) as user_count
from cte_earliest_login
where datediff(day, earliest_login, '2019-06-30') <= 90
group by earliest_login