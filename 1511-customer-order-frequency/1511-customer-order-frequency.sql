/* Write your T-SQL query statement below */
with cte as (
	select 
		O.customer_id,
		month(order_date) as order_month,
		year(order_date) as order_year,
		sum(price*quantity) as sales
	from Orders O
	join product P on O.product_id=p.product_id
	--where order_date between '2020-06-01' and '2020-07-31'
	group by O.customer_id, month(order_date), year(order_date)
)
select 
	c.customer_id,
	cust.name
from cte c 
join customers cust on c.customer_id=cust.customer_id
where (order_year = 2020 and sales >=100 and order_month in (6,7))
group by c.customer_id, cust.name
having count(1) >= 2