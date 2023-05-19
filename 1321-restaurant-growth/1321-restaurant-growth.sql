/* Write your T-SQL query statement below */
select visited_on, amount, average_amount 
from 
(
	select 
	visited_on,
	sum(amount) over(order by visited_on rows between 6 preceding and current row) as amount,
	cast(round(sum(amount) over(order by visited_on rows between 6 preceding and current row) * 1.00 / 7, 2) as decimal(8,2)) as average_amount,
	rank() over (order by visited_on asc) rn
	from (
		select
			c1.visited_on,
			sum(amount) as amount
		from Customer c1
		group by visited_on
	) sq1
) sq2 where sq2.rn >=7
order by 1