/* Write your T-SQL query statement below */
select 
	name as warehouse_name,
	SUM(units * sq.volume) as volume
from Warehouse w join 
(
	select
		product_id,
		product_name,
		(width * length * height) as volume
	from Products
) sq on w.product_id= sq.product_id
group by name