/* Write your T-SQL query statement below */
with cte_metrics as (
select
	ad_id,
	SUM(case when action='Clicked' then 1 else 0 end) as total_clicks,
	SUM(case when action='Viewed' then 1 else 0 end) as total_views
from Ads
group by ad_id
)
select ad_id,
		cast(ROUND(case when total_clicks + total_views = 0 then 0.00 else total_clicks * 1.00 / (total_clicks + total_views) end * 100, 2) as decimal(5,2)) as ctr
from cte_metrics
order by ctr desc, ad_id asc