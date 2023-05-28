/* Write your T-SQL query statement below */
with cte as (
select
	V.visit_id,
	customer_id,
	transaction_id
from Visits V
left join Transactions T on V.visit_id=T.visit_id
)
select customer_id, count(1) as count_no_trans
from cte 
where transaction_id is null
group by customer_id
order by 2 desc