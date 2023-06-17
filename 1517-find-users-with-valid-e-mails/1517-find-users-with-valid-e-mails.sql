/* Write your T-SQL query statement below */

select
	user_id,
	name,
	mail
from Users
where	mail like '[a-zA-Z]%@leetcode.com'
	and left(mail, len(mail) - 13) not like '%[^a-zA-Z0-9._-]%'