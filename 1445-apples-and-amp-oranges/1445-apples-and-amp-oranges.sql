/* Write your T-SQL query statement below */
with cte_apples as (
	select
		sale_date,
		sold_num
	from Sales S1
	where fruit = 'apples'
), cte_oranges as (
	select
		sale_date,
		sold_num
	from Sales S1
	where fruit = 'oranges'
), cte_sale_date as (
	select distinct sale_date
	from Sales
)
select 
	s.sale_date,
	a.sold_num - o.sold_num as diff
from cte_sale_date s
join cte_apples a on s.sale_date=a.sale_date
join cte_oranges o on s.sale_date=o.sale_date
order by s.sale_date