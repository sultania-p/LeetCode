/* Write your T-SQL query statement below */

with cte_order as (
	select
		name as customer_name,
		O.customer_id,
		order_id,
		order_date,
		ROW_NUMBER() over (partition by O.customer_id order by order_date desc) rn
	from Orders O
	join Customers c on o.customer_id=c.customer_id
)
select
	customer_name, ct.customer_id, order_id, order_date
from cte_order ct
where rn <= 3
order by customer_name, ct.customer_id, order_date desc