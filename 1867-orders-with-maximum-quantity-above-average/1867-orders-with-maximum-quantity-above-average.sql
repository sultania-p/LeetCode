/* Write your T-SQL query statement below */
/*
with cte_avg as (
	select
		order_id,
		count(distinct product_id) as unique_products,
		sum(quantity) * 1.00 / count(distinct product_id) as avg_quantity,
		max(quantity) as max_quantity
	from OrdersDetails
	group by order_id
)
select c1.order_id
from cte_avg c1
cross join cte_avg c2
where c1.max_quantity > c2.avg_quantity
group by c1.order_id
having count(c1.order_id) = (select count(distinct order_id) from OrdersDetails)
*/

-- Sol - 2 
with cte_avg as (
	select
		sum(quantity) * 1.00 / count(distinct product_id) as avg_quantity
	from OrdersDetails
	group by order_id
)
select distinct c1.order_id
from OrdersDetails c1
where c1.quantity > (select max(avg_quantity) from cte_avg)