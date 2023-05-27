/* Write your T-SQL query statement below */
with cte_tran as 
(
	select
		paid_by as user_id,
		-1 * amount as amount
	from Transactions D
	UNION ALL
	select
		paid_to as user_id,
		amount
	from Transactions C
), cte_total as 
(
	select
		user_id,
		sum(amount) as tran_amount
	from cte_tran
	group by user_id
)
select
	U.user_id,
	U.user_name,
	U.credit + isnull(C.tran_amount, 0) as credit,
	case when U.credit + isnull(C.tran_amount, 0) < 0 then 'Yes' else 'No' end as credit_limit_breached
from Users U
left join cte_total c on u.user_id=c.user_id