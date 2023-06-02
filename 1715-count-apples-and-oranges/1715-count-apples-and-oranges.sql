/* Write your T-SQL query statement below */
select sum(apple_count) as apple_count, sum(orange_count) as orange_count
from (
	select
		isnull(b.apple_count, 0) + isnull(c.apple_count, 0) as apple_count,
		isnull(b.orange_count, 0) + isnull(c.orange_count, 0) as orange_count
	from Boxes B
	left join Chests C on B.chest_id=C.chest_id
) sq 
