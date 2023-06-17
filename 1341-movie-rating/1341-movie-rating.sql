/* Write your T-SQL query statement below */
WITH cte_base as (
select
	u.name,
	M.title,
	mr.rating,
	mr.created_at
from MovieRating mr
left join Users u on mr.user_id=u.user_id
left join Movies M on mr.movie_id=M.movie_id
),
cte_max_rating as (
select top 1
	title as results
from cte_base
where datepart(month, created_at) = 2 and datepart(year, created_at) = 2020
group by title
order by avg(rating * 1.00) desc, title asc
),
cte_max_avg as (
select top 1 name  as results
from cte_base
group by name
order by count(1) desc, name asc
)
select * from cte_max_rating
UNION ALL
select * from cte_max_avg