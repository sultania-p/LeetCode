/* Write your T-SQL query statement below */
with cte_price as (
select
	customer_id,
	product_name,
	case	when product_name = 'A' then 10 
			when product_name = 'B' then 20
			when product_name = 'C' then -1
			else 0 end as grp
from Orders O
)
select cte.customer_id, customer_name
from cte_price cte
join Customers C on cte.customer_id=c.customer_id
group by cte.customer_id, customer_name
having sum(distinct grp) = 30
order by cte.customer_id
