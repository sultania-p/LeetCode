/* Write your T-SQL query statement below */
with cte_avg_weather as 
(
select
	country_id,
	avg(weather_state * 1.00) as avg_weather
from Weather w
where [day] between '2019-11-01' and '2019-11-30'
group by country_id
)
select 
	c.country_name,
	case when avg_weather <= 15 then 'Cold'
		when avg_weather >= 25 then 'Hot'
		else 'Warm' end as weather_type
from cte_avg_weather  w
left join Countries c on w.country_id=c.country_id