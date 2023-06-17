/* Write your T-SQL query statement below */
select
	user_id,
	count(follower_id) as followers_count
from Followers F
group by user_id
order by 1