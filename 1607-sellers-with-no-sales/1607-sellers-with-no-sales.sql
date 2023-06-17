/* Write your T-SQL query statement below */
select seller_name
from Seller where 
seller_id not in (
					select
						seller_id
					from Orders O
					where year(sale_date) = 2020
					group by seller_id
			)
order by 1