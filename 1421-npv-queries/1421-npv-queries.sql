/* Write your T-SQL query statement below */
select 
	Q.id,
	Q.year,
	isnull(N.npv, 0) as npv
from Queries Q
left join NPV N on Q.id=N.id and Q.year=N.year