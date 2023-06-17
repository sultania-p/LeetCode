/* Write your T-SQL query statement below */
with cte1 as (
	select
		P.id,
		C.name as country_name
	from Person P
	left join Country C on substring(P.phone_number, 1 , 3) = C.country_code
), cte2 as (
	select
		a.country_name,
		sum(duration) as call_duration,
		count(caller_id) as total_callers
	from Calls cr
	left join cte1 a on a.id = cr.caller_id
	group by a.country_name
	UNION ALL
	select
		b.country_name,
		sum(duration) as call_duration,
		count(caller_id) as total_callers
	from Calls cr
	left join cte1 b on b.id = cr.callee_id
	group by b.country_name
)
select 
	country_name as country
	--sum(call_duration * 1.00) / sum(total_callers) as avg
from cte2
group by country_name
having (sum(call_duration * 1.00) / sum(total_callers)) > (select avg(duration * 1.00) from Calls)