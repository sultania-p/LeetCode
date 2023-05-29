/* Write your T-SQL query statement below */
with cte1 as (
	select
		max(customer_id) as maxid
	from Customers
), cte2 as 
(
	select 1 as ids
	UNION all
	select ids + 1 from cte2 where ids < (select maxid from cte1)
)
select ids from cte2 where ids not in (select customer_id from Customers)
order by 1