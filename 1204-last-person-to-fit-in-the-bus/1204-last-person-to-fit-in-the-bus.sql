/* Write your T-SQL query statement below */
with cte_rolling_sum as (
	select
		turn as Trun,
		person_id as ID,
		person_name,
		Weight,
		SUM(weight) over (order by turn asc) as [Total Weight]
	from Queue	
)
select top 1 person_name from cte_rolling_sum
where [Total Weight] <=1000
order by [Total Weight] desc