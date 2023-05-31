/* Write your T-SQL query statement below */

select
	user_id,
	upper(LEFT(name, 1)) + lower(right(name, LEN(name) - 1)) as name
from Users
order by user_id