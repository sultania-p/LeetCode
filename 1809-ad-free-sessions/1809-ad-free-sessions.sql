/* Write your T-SQL query statement below */
with cte_ads as (
	select distinct
		session_id
	from Playback P
	join Ads A on P.customer_id=A.customer_id
	where timestamp between start_time and end_time
)
select session_id from Playback where session_id not in (select session_id from cte_ads)