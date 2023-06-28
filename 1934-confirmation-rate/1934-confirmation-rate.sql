/* Write your T-SQL query statement below */
with cte_confirmation as (
	select
		user_id,
		sum(case when action = 'timeout' then 1 else 0 end) as timeout_cnt,
		sum(case when action = 'confirmed' then 1 else 0 end) as confirmed_cnt
	from Confirmations
	group by user_id
)
select 
	S.user_id,
	cast(isnull(case when confirmed_cnt + timeout_cnt = 0 then 1.00 else (confirmed_cnt * 1.00 / (confirmed_cnt + timeout_cnt)) end, 0.00) as decimal(5,2)) as  confirmation_rate
from Signups S
Left Join cte_confirmation C on S.user_id = C.user_id