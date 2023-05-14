/* Write your T-SQL query statement below */

select sq.product_id, p.product_name
from (
select distinct
	s.product_id
from sales s
where s.sale_date between ('2019-01-01') and ('2019-03-31')
except
select distinct
	s.product_id
from sales s
where s.sale_date not between ('2019-01-01') and ('2019-03-31')
) sq join product p on sq.product_id=p.product_id