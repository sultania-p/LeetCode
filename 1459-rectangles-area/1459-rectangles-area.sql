/* Write your T-SQL query statement below */
select * from (
select
	P1.id as P1,
	P2.id as P2,
	ABS(p2.x_value - p1.x_value) * ABS(p2.y_value - p1.y_value) as AREA
from Points P1
join Points P2 on p1.id<P2.id
and p1.x_value != p2.x_value
or p2.y_value != p2.y_value
) sq
where AREA !=0
order by 3 desc, 1 , 2