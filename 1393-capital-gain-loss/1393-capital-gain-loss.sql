/* Write your T-SQL query statement below */
with cte_price as (
select 
	stock_name,
	case when operation='Buy' then price * -1 else price end as price
from Stocks
)
select 
	stock_name,
	sum(price) as capital_gain_loss
from cte_price
group by stock_name