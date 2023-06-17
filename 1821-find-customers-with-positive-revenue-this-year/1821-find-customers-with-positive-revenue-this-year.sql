/* Write your T-SQL query statement below */
with cte as (
select
	customer_id,
	revenue
from Customers
where year= 2021
)
select customer_id from cte where revenue > 0