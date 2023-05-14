/* Write your T-SQL query statement below */
select 
	month, country,
	count(1) as trans_count,
	sum(case when state='approved' then 1 else 0 end) as approved_count,
	sum(amount) as trans_total_amount,
	sum(case when state='approved' then amount else 0 end) as approved_total_amount
from (
	select
		left(convert(varchar(10), trans_date),7) as month,
		country,
		state, amount
	from Transactions
) sq group by month, country