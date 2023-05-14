Create table  Customer (customer_id int, product_key int)
Create table Product (product_key int)
drop table Customer
insert into Customer (customer_id, product_key) values ('1', '5')
insert into Customer (customer_id, product_key) values ('2', '6')
insert into Customer (customer_id, product_key) values ('3', '5')
insert into Customer (customer_id, product_key) values ('3', '6')
insert into Customer (customer_id, product_key) values ('1', '6')
Truncate table Product
insert into Product (product_key) values ('5')
insert into Product (product_key) values ('6')
---

with cte as (
select customer_id, count(1) as p_cnt
from(
	select distinct
		customer_id,
		product_key
	from Customer
	) sq group by customer_id
)
select customer_id from cte where p_cnt = (select count(1) from product)

-- Alternative
select
	customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select count(*) from Product)

	
