/* Write your T-SQL query statement below */


select
	activity_date as [day],
	count(distinct user_id) as active_users
from activity
where activity_type is not null
group by activity_date
having datediff(day, activity_date, '2019-07-27') between 0 and 29