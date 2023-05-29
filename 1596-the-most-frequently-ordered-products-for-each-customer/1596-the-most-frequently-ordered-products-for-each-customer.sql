/* Write your T-SQL query statement below */
with cte1 as (
	select
		customer_id,
		product_id,
		count(1) as prod_order_count
	from Orders O
	group by customer_id, product_id
), cte2 as (
	select cte1.customer_id,
			cte1.product_id,
			P.product_name,
			DENSE_RANK() over (partition by  cte1.customer_id order by prod_order_count desc) as rn
	from cte1
	left join products P on cte1.product_id=P.product_id
	left join Customers C on cte1.customer_id=C.customer_id
)
select 
	customer_id,
	product_id,
	product_name
from cte2
where rn = 1