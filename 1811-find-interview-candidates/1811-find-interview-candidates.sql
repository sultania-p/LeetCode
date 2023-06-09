/* Write your T-SQL query statement below */
with cte1 as (
	select
		contest_id,
		medals,
		user_id
	from Contests
	unpivot (user_id for medals in (gold_medal, silver_medal, bronze_medal)) as unpvt
), cte2 as (
	select
		*,
		contest_id - LAG(contest_id, 2) over (partition by user_id order by contest_id) as diff
	from cte1
), cte3 as (
	select user_id
	from cte2
	where diff = 2
	UNION
	select user_id
	from cte1
	group by user_id, medals
	having count(user_id) >= 3 and  medals= 'gold_medal'
)
select name, mail
from cte3 c join users u on c.user_id=u.user_id