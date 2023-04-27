
select 
	s.buyer_id
from sales s
join product p on s.product_id = p.product_id
where p.product_name='S8'
except
select 
	s.buyer_id
from sales s
join product p on s.product_id = p.product_id
where p.product_name='iPhone'
