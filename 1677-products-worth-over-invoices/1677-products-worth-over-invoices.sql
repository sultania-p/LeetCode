/* Write your T-SQL query statement below */

select
	p.name,
	sum(isnull(rest, 0)) as rest,
	sum(isnull(paid, 0)) as paid,
	sum(isnull(canceled, 0)) as canceled,
	sum(isnull(refunded, 0)) as refunded
from Product P
left join Invoice I  on I.product_id=P.product_id
group by p.name
order by name