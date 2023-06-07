/* Write your T-SQL query statement below */
select
	distinct product_id,
	(select price from products sq1 where store='store1' and sq1.product_id = p.product_id) as store1,
	(select price from products sq1 where store='store2' and sq1.product_id = p.product_id) as store2,
	(select price from products sq1 where store='store3' and sq1.product_id = p.product_id) as store3
from Products P