/* Write your T-SQL query statement below */
with cte1 as (
	select
		customer_id,
		product_id,
		count(1) as prod_order_count
	from Orders O
	group by customer_id, product_id
), cte2 as (
	select customer_id,
			product_id,
			prod_order_count,
			DENSE_RANK() over (partition by  customer_id order by prod_order_count desc) as rn
	from cte1
)
select 
	cte2.customer_id,
	cte2.product_id,
	P.product_name
from cte2
left join products P on cte2.product_id=P.product_id
left join Customers C on cte2.customer_id=C.customer_id
where rn = 1