/* Write your T-SQL query statement below */
select 
	s.product_id,
	sum(s.quantity) as total_quantity
from Sales s
group by s.product_id