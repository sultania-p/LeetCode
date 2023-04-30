/* Write your T-SQL query statement below */
with cte_prod as (
	select *,
			rank() over (partition by product_id order by change_date desc) rn
	from Products
	where change_date <= '2019-08-16'
)
select distinct p.product_id, isnull(sq.new_price, 10) as price 
from products p 
left join ( select product_id, new_price from cte_prod where rn=1) sq
		on p.product_id=sq.product_id
order by 2 desc