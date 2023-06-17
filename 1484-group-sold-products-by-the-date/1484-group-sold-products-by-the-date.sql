/* Write your T-SQL query statement below */
with cte1 as 
	(select distinct * 
	from Activities
), cte2 as (
	select
		sell_date,
		count(distinct product) as num_sold,
		STRING_AGG(product, ',') within group (order by product asc)  as products
	from cte1
	group by sell_date
) select * from cte2
