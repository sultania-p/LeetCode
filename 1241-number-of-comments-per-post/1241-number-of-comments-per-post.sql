/* Write your T-SQL query statement below */

select 
	distinct sub_id as post_id, isnull(sq1.number_of_comments, 0) as number_of_comments
from Submissions s
left join 
	(select parent_id, count(1)  as number_of_comments from (
		select distinct
			sub_id,
			parent_id
		from Submissions where parent_id is not null
	) sq group by parent_id
) sq1 on s.sub_id=sq1.parent_id
where s.parent_id is null
order by 1

