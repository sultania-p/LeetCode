/* Write your T-SQL query statement below */
with cte_product_all as 
(select 
	s.product_id,
	s.year,
	RANK() over (partition by product_id order by year asc) rn
from Sales s
group by s.product_id, s.year
), cte_prod_first_year as 
(select product_id, year from cte_product_all where rn = 1)

select s.product_id, s.year as first_year, s.quantity, s.price
from Sales S 
join cte_prod_first_year c on s.product_id=c.product_id and s.year=c.year
