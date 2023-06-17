/* Write your T-SQL query statement below */
select
	U.name, 
	isnull(sq.travelled_distance, 0) as travelled_distance
from Users u 
left join 	(
				select 
					R.user_id,
					isnull(sum(R.distance), 0) as travelled_distance
				from Rides R
				group by R.user_id
			) sq on sq.user_id=U.id
order by 2 desc, 1 asc