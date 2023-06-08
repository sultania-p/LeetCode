/* Write your T-SQL query statement below */
with cte_products as (
	select 
		product_id,
		'store1' as store,
		store1 as price
	from Products
	UNION ALL
	select 
		product_id,
		'store2' as store,
		store2 as price
	from Products
	UNION ALL
	select 
		product_id,
		'store3' as store,
		store3 as price
	from Products
) select * from cte_products where price is not null order by 1, 2