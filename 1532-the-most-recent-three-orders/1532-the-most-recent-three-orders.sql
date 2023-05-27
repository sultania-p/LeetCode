/* Write your T-SQL query statement below */

with cte_order as (
	select
		customer_id,
		order_id,
		order_date,
		ROW_NUMBER() over (partition by customer_id order by order_date desc) rn
	from Orders
)
select
	name as customer_name, ct.customer_id, order_id, order_date
from cte_order ct
join Customers c on ct.customer_id=c.customer_id
where rn <= 3
order by name, ct.customer_id, order_date desc