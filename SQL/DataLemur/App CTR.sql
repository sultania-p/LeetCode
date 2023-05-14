
/*
Assume you have an events table on app analytics. Write a query to get the app’s click-through rate (CTR %) in 2022. Output the results in percentages rounded to 2 decimal places.

Notes:

Percentage of click-through rate = 100.0 * Number of clicks / Number of impressions
To avoid integer division, you should multiply the click-through rate by 100.0, not 100.
*/


with cte_ctr as 
(SELECT
  app_id,
  SUM(case WHEN event_type='impression' then 1 else 0 end) as impression_c,
  SUM(case WHEN event_type='click' then 1 else 0 end) as click_c
FROM events
where EXTRACT(year from timestamp)=2022
group by app_id
)
select app_id, ROUND((100.0 * click_c / impression_c), 2) as ctr from cte_ctr