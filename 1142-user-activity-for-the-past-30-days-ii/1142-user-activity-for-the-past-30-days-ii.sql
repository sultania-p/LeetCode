/* Write your T-SQL query statement below */
select cast((case when count(distinct user_id)=0 then 0.00 else cast(SUM(session_cnt) as decimal(10,2)) end / case when count(distinct user_id)=0 then 1 else count(distinct user_id) end) as decimal(10,2)) as average_sessions_per_user
from	
	(	select
			user_id,
			count(distinct session_id) as session_cnt
		from activity
		where datediff(day, activity_date, '2019-07-27') between 0 and 29
		group by user_id
	)sq 
