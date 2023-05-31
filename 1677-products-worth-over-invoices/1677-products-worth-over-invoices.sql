/* Write your T-SQL query statement below */

select
	p.name,
	isnull(sum(rest), 0) as rest,
	isnull(sum(paid), 0) as paid,
	isnull(sum(canceled), 0) as canceled,
	isnull(sum(refunded), 0) as refunded
from Product P
left join Invoice I  on I.product_id=P.product_id
group by p.name
order by name