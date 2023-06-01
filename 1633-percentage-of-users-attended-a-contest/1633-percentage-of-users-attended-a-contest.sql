/* Write your T-SQL query statement below */
select
	contest_id,
	cast(ROUND((count(distinct user_id) * 1.00 * 100 / (select count(1) from Users)), 2) as decimal(5,2)) as percentage
from Register R
group by contest_id
order by 2 desc, 1 asc