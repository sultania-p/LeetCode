Create table If Not Exists MyNumbers (num int);
truncate table mynumbers;
insert into MyNumbers (num) values ('8');
insert into MyNumbers (num) values ('8');
insert into MyNumbers (num) values ('7');
insert into MyNumbers (num) values ('7');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('3');
insert into MyNumbers (num) values ('6');

select * from mynumbers;
# Solution
with cte as (
select 
	num, count(1) as num_cnt
from mynumbers
group by num
)
select ifNULL((select num 
from cte 
where num_cnt= 1 order by num desc limit 1), null) as num