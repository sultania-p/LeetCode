/* Write your T-SQL query statement below */
with cte_activity as (
select
	username,
	activity,
	startDate,
	endDate,
	dense_rank() over (partition by username order by startDate desc) rn
from UserActivity
), cte_numactivity as 
(select username, count(activity) as activityCnt from UserActivity group by username)

select
	ca.username,
	activity,
	startDate,
	endDate
from cte_activity ca
left join cte_numactivity cn on ca.username=cn.username
where rn = case when cn.activityCnt >1 then 2 else 1 end