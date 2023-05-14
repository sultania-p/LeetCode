/* Write your T-SQL query statement below */
/*
select sq.seller_id from 
(
select
	s.seller_id,
	sum(s.price) as total_sales,
	rank() over (order by sum(s.price) desc) as rn
from sales s
group by s.seller_id
) sq where sq.rn=1
*/

select
	s.seller_id
from sales s
group by s.seller_id
having sum(s.price) = (select max(total_sales) as s_max from
							(
							select
								s.seller_id,
								sum(s.price) as total_sales
							from sales s
							group by s.seller_id
							) sq
						)