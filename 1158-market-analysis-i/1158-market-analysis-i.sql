/* Write your T-SQL query statement below */
select u.user_id as buyer_id,
		u.join_date,
		isnull(sq.orders_in_2019, 0) as orders_in_2019
from Users u left join (select
						o.buyer_id as buyer_id,
						count(o.order_id) as orders_in_2019 
					from orders o
					where year(order_date) =2019
					group by o.buyer_id
			) sq on u.user_id = sq.buyer_id