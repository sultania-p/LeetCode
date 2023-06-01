/* Write your T-SQL query statement below */
select 
	name,
	sum(amount) as balance
from [transactions] T 
join Users A on T.account=A.account
group by name
having sum(amount) > 10000