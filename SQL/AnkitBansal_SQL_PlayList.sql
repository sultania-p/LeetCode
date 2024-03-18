/* 1. Derive Points table for ICC tournament */
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;
--------------------------
with cte_win as (
select winner, count(1) as no_of_wins
from icc_world_cup
group by Winner)

select team, no_of_matches_played, no_of_wins, (no_of_matches_played - no_of_wins) as no_of_losses
from
(
	select	team, 
			sum(n) as no_of_matches_played, 
			case when cte.no_of_wins is null then 0 else cte.no_of_wins end as no_of_wins
	from (
		select team_1 as team, count(1) as n
		from icc_world_cup
		group by team_1
		UNION ALL
		select team_2 as team , count(1) as n
		from icc_world_cup
		group by team_2
	) sq left join cte_win cte on sq.team = cte.Winner
	group by team, cte.no_of_wins
) sq1
order by 3 desc

---
/* find new and repeat customers */
create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from customer_orders
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;
-- Solution
with cte as (
select customer_id, min(order_date) as first_visit_date
from customer_orders group by customer_id
)

select order_date, sum(case when cust_type = 1 then 1 else 0 end) as cnt_new_customers,
					sum(case when cust_type = 0 then 1 else 0 end) as cnt_repeat_customers,
					sum(case when cust_type=1 then order_amount else 0 end) as amount_new_customers,
					sum(case when cust_type=0 then order_amount else 0 end) as amount_repeat_customers
from (
select *,
		case when order_date = first_visit_date then 1 else 0 end as cust_type
from (
select co.*, a.first_visit_date from customer_orders co
join cte a on co.customer_id=a.customer_id
) sq )sq1 group by order_date

select * from customer_orders

-----------------------------------------------------------------------
/* Scenario based Interviews Question for Product companies */
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')

select * from entries;

with cte_total_visit as ( 
	select name, count(1) as total_visits from entries group by name)
,cte_floor_visits as 
	( select name, [floor], count(1) as total_visit_floor from entries group by name, [floor])
,cte_resources_used as
	( select sq.name,STRING_AGG(sq.resources, ',') as resources_used from 
		(select name, resources from entries group by name, resources) sq group by name)

select s1.name, s1.total_visits, s2.most_visited_floor, s3.resources_used
from	cte_total_visit s1
join (
	select name, floor as most_visited_floor from cte_floor_visits c2
	where total_visit_floor >= (select max(total_visit_floor) from cte_floor_visits c3 where c2.name=c3.name group by name)
	group by name, floor 
	) s2 on s1.name = s2.name
join cte_resources_used s3 on s1.name = s3.name

-------------------------------------------------------------------------
-- Provide date for nth occurance of sunday in future form given date
-- Get 2nd Sunday from date 2022-01-01 (Saturday) -- Get first sunday and add 1 week ...

declare @today_date date;
declare @n int;
set @today_date = '2023-04-01';	--saturday
set @n=2;	--3rd sunday from @today_date

select dateadd(week, @n-1, dateadd(day, (8 - DATEPART(WEEKDAY, @today_date)), @today_date))
