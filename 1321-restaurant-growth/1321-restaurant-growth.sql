/* Write your T-SQL query statement below */

with cte1 as (
select
	visited_on,
	sum(amount) as total_amount
FROM customer 
group by visited_on ),

cte2 as (
select
	visited_on,
	sum(total_amount) over(order by visited_on rows between 6 preceding and current row) as amount,
	cast(ROUND(avg(total_amount * 1.00) over(order by visited_on rows between 6 preceding and current row), 2) as decimal(8,2)) as average_amount
from cte1 )

select 
	*
from cte2
where datediff(day, (select min(visited_on) from cte2), visited_on) >= 6