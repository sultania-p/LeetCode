/* Write your T-SQL query statement below */
select 
	product_name,
	sale_date,
	count(1) as total
from
(
	select
		sale_id,
		trim(lower(product_name)) as product_name,
		format(sale_date, 'yyyy-MM') as sale_date
	from Sales
) sq group by product_name, sale_date
	order by product_name, sale_date