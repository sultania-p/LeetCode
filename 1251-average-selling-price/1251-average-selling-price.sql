/* Write your T-SQL query statement below */
with cte_prod as (
	select 
		p.product_id,
		price, units
	from prices p 
	join UnitsSold u on p.product_id=u.product_id and u.purchase_date between p.start_date and p.end_date
)
select 
	product_id,
	case when sum(units)=0 then 0.00 else cast(sum(price * units) * 1.00 / sum(units) as decimal(10,2)) end as average_price 
from cte_prod
group by product_id