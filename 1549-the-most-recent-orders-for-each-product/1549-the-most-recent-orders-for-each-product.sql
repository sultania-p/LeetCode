/* Write your T-SQL query statement below */
with cte_orders as 
(
	select
		o.product_id,
		o.order_id,
		o.order_date,
		dense_rank() over(partition by o.product_id order by order_date desc) rn
	from Orders O
)
select
	p.product_name,
	o.product_id,
	order_id,
	order_date
from cte_orders o
join Products P on o.product_id=p.product_id
where rn = 1
order by p.product_name, o.product_id, o.order_id 