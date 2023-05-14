/* Write your T-SQL query statement below */
select
	case when count(1) =0 then 0.00 else 
		cast(sum(case when order_date=customer_pref_delivery_date then 1.00 else 0 end) / count(1) * 100 as decimal(5,2)) 
	end as immediate_percentage 
from Delivery