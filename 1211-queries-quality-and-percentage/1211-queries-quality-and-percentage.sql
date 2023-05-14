/* Write your T-SQL query statement below */
with cte_query as (
	select *
			,(rating * 1.00 / position)  as ind_quality
	from queries q
)
select query_name,
		case when count(1)=0 then 0.00 else cast(sum(ind_quality) / count(1) as decimal(5,2)) end as quality,
		case when count(1) =0 then 0.00 else cast(sum(case when rating<3 then 1 else 0 end) * 1.00 / count(1) * 100 as decimal(5,2)) end as poor_query_percentage 
from cte_query
group by query_name