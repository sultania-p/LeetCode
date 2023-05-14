/* Write your T-SQL query statement below */
with cte_user1_friends as (
	select user2_id as user_id from Friendship where user1_id=1
	UNION 
	select user1_id as user_id from Friendship where user2_id=1
)
select distinct page_id as recommended_page 
from likes l where l.user_id in (select user_id from cte_user1_friends)
and page_id in (
		select page_id from likes where page_id not in (select page_id from likes where user_id=1 ))