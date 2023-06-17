/* Write your T-SQL query statement below */
select
	datename(weekday, day) + ', ' + 
	datename(month, day) + ' ' + 
	cast(day(day) as varchar(3)) + ', ' + 
	cast(year(day) as varchar(5)) as day
from days