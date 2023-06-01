/* Write your T-SQL query statement below */
-- create a table for all the months
with cte_month as (
	select
		1 as [month]
	UNION ALL
	select
		[month] + 1
	from cte_month
	where [month] < 12
), cte_ride_grp as (
	select 
		month(r.requested_at) as [month],
		isnull(SUM(ride_distance), 0) as ride_distance,
		isnull(sum(ride_duration), 0) as ride_duration
	from AcceptedRides  AR
	join Rides R on AR.ride_id=R.ride_id
	where year(R.requested_at) = 2020 and month(R.requested_at) between 1 and 12
	group by month(r.requested_at)
), cte_1 as (
	select
		c1.[month],
		isnull(ride_distance, 0) as ride_distance,
		isnull(ride_duration, 0) as ride_duration
	from cte_month c1
	left join cte_ride_grp c2 on c1.month=c2.month
), cte_rolling_avg as (
	select month,
		cast(round((sum(ride_distance) over (order by month rows between current row and 2 following) * 1.00 / 3), 2) as decimal(28,2)) as average_ride_distance,
		cast(round((sum(ride_duration) over (order by month rows between current row and 2 following) * 1.00 / 3), 2) as decimal(28,2)) as average_ride_duration  
	from cte_1
)
select
	*
from cte_rolling_avg
where month <= 10
order by 1