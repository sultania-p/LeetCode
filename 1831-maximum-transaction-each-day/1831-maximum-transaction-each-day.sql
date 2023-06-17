/* Write your T-SQL query statement below */
with cte1 as (
	select
		transaction_id,
		convert(varchar(10), day, 121) as date,
		amount
	from Transactions
), cte2 as  (
	select 
		date,
		max(amount) as max_amount
	from cte1
	group by date
) 
select 
	transaction_id
from cte1 c1 where amount= (select max_amount from cte2  c2 where c1.date=c2.date) 
order by transaction_id