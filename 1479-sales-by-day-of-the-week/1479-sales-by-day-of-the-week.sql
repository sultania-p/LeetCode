/* Write your T-SQL query statement below */
with cte1 as (
	SELECT
		*,datename(weekday, order_date) as week_day
	FROM ORDERS
), cte2 as 
(
	select
		item_id,week_day,sum(quantity) as total_quantity
	from cte1
	group by item_id, week_day
) , cte3 as 
(
select
	i.item_category as Category,c.week_day,sum(c.total_quantity) as total_quantity
from items i
left join cte2 c on c.item_id = i.item_id
group by i.item_category, c.week_day
)
select  
	Category,
	SUM(case when week_day='Monday' then total_quantity else 0 end)  as 'Monday',
	SUM(case when week_day='Tuesday' then total_quantity else 0 end)  as 'Tuesday',
	SUM(case when week_day='Wednesday' then total_quantity else 0 end)  as 'Wednesday',
	SUM(case when week_day='Thursday' then total_quantity else 0 end)  as 'Thursday',
	SUM(case when week_day='Friday' then total_quantity else 0 end)  as 'Friday',
	SUM(case when week_day='Saturday' then total_quantity else 0 end)  as 'Saturday',
	SUM(case when week_day='Sunday' then total_quantity else 0 end)  as 'Sunday'
from 
cte3
group by category
order by Category