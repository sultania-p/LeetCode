/* Write your T-SQL query statement below */
select distinct
	c1.user_id
	--c1.time_stamp as time1,
	--c2.time_stamp as time2,
	--ABS(DATEDIFF(s, c1.time_stamp, c2.time_stamp)) as timediff
from Confirmations C1 
join Confirmations C2 on C1.user_id = c2.user_id and c1.time_stamp < c2.time_stamp
where ABS(DATEDIFF(s, c1.time_stamp, c2.time_stamp)) <= 86400