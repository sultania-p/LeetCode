/* Write your T-SQL query statement below */
select 
	P.product_name,
	sum(unit) as unit
from Orders O 
join Products P on O.product_id=P.product_id
where datepart(month, order_date) = 2 and datepart(year, order_date) = 2020
group by P.product_name
having sum(unit) >=100