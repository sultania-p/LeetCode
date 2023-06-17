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
),
-- get all the drivers or or before 2020
cte_driver as (
	select
		driver_id,
		case when year(join_date) < 2020 then 1 else month(join_date) end as month 	
	from drivers d
	where year(join_date) <= 2020
),
-- get all active drivers -- byp passing null drivers for any month not present
cte_driver_cnt as (
	select distinct
		c1.month,
		count(c2.driver_id) over(order by c1.month) as active_drivers
	from cte_month c1 left join cte_driver c2 on c1.month = c2.month
),
-- gett accepted rides (exclusive of month with no rides)
cte_accepted_rides as (
	select
		month(r.requested_at) as [month],
		count(1) as accepted_rides
	from AcceptedRides  AR
	join Rides R on AR.ride_id=R.ride_id
	where year(R.requested_at) = 2020 and month(R.requested_at) between 1 and 12
	group by month(r.requested_at)
)
select
	dc.[month],
	dc.active_drivers,
	isnull(accepted_rides, 0) as accepted_rides 
from cte_driver_cnt dc
left join cte_accepted_rides ar on dc.month=ar.month
order by dc.month
