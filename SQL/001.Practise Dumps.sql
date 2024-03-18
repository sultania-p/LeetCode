/*
with cte_product_all as 
(select 
	s.product_id,
	s.year,
	RANK() over (partition by product_id order by year asc) rn
from Sales s
group by s.product_id, s.year
), cte_prod_first_year as 
(select product_id, year from cte_product_all where rn = 1)

select s.product_id, s.year as first_year, s.quantity, s.price
from Sales S 
join cte_prod_first_year c on s.product_id=c.product_id and s.year=c.year



Create table  Project (project_id int, employee_id int)
Create table  Employee (employee_id int, name varchar(10), experience_years int)
Truncate table Project
insert into Project (project_id, employee_id) values ('1', '1')
insert into Project (project_id, employee_id) values ('1', '2')
insert into Project (project_id, employee_id) values ('1', '3')
insert into Project (project_id, employee_id) values ('2', '1')
insert into Project (project_id, employee_id) values ('2', '4')
truncate table Employee
insert into Employee (employee_id, name, experience_years) values ('1', 'Khaled', '3')
insert into Employee (employee_id, name, experience_years) values ('2', 'Ali', '2')
insert into Employee (employee_id, name, experience_years) values ('3', 'John', '3')
insert into Employee (employee_id, name, experience_years) values ('4', 'Doe', '2')



select
	p.project_id,
	cast(sum(e.experience_years * 1.00) / count(p.employee_id) as decimal(10,2)) as average_years
from project p
join employee e on p.employee_id = e.employee_id
group by p.project_id

select 
	project_id
from project p
group by project_id
having count(employee_id) = (select max(emp_count) from
								(select count(employee_id) as emp_count from project group by project_id) sq
							)


with cte_all_emp as (
	select 
		p.project_id,
		p.employee_id,
		e.experience_years
	from project p
	join employee e on p.employee_id=e.employee_id
), cte_exp_max as 
(
	select project_id, max(experience_years) as exp_max from cte_all_emp group by project_id
)
select 
	p.project_id, p.employee_id
from cte_all_emp p join cte_exp_max c on p.project_id=c.project_id and p.experience_years=exp_max

-- alternative
select sq.project_id, sq.employee_id
from (
	select 
		p.project_id,
		p.employee_id,
		e.experience_years,
		rank() over (partition by project_id order by experience_years desc) rn
	from project p
	join employee e on p.employee_id=e.employee_id
) sq where sq.rn=1


Create table Product (product_id int, product_name varchar(10), unit_price int)
Create table Sales (seller_id int, product_id int, buyer_id int, sale_date date, quantity int, price int)
drop table Product
insert into Product (product_id, product_name, unit_price) values ('1', 'S8', '1000')
insert into Product (product_id, product_name, unit_price) values ('2', 'G4', '800')
insert into Product (product_id, product_name, unit_price) values ('3', 'iPhone', '1400')
drop table Sales
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '1', '1', '2019-01-21', '2', '2000')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '2', '2', '2019-02-17', '1', '800')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('2', '2', '3', '2019-06-02', '1', '800')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('3', '3', '4', '2019-05-13', '2', '2800')

select sq.seller_id from 
(
select
	s.seller_id,
	sum(s.price) as total_sales,
	rank() over (order by sum(s.price) desc) as rn
from sales s
group by s.seller_id
) sq where sq.rn=1


select
	s.seller_id
from sales s
group by s.seller_id
having sum(s.price) = (select max(total_sales) as s_max from
							(
							select
								s.seller_id,
								sum(s.price) as total_sales
							from sales s
							group by s.seller_id
							) sq
						)


select * from sales
truncate table Product
insert into Product (product_id, product_name, unit_price) values ('1', 'S8', '1000')
insert into Product (product_id, product_name, unit_price) values ('2', 'G4', '800')
insert into Product (product_id, product_name, unit_price) values ('3', 'iPhone', '1400')
truncate  table Sales
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '1', '1', '2019-01-21', '2', '2000')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '2', '2', '2019-02-17', '1', '800')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('2', '2', '3', '2019-06-02', '1', '800')
insert into Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('3', '3', '4', '2019-05-13', '2', '2800')
select * from sales

--solution


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

*/


Create table  Books (book_id int, name varchar(50), available_from date)
Create table Orders (order_id int, book_id int, quantity int, dispatch_date date)
Truncate table Books
insert into Books (book_id, name, available_from) values ('1', 'Kalila And Demna', '2010-01-01')
insert into Books (book_id, name, available_from) values ('2', '28 Letters', '2012-05-12')
insert into Books (book_id, name, available_from) values ('3', 'The Hobbit', '2019-06-10')
insert into Books (book_id, name, available_from) values ('4', '13 Reasons Why', '2019-06-01')
insert into Books (book_id, name, available_from) values ('5', 'The Hunger Games', '2008-09-21')
drop table Orders
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('1', '1', '2', '2018-07-26')
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('2', '1', '1', '2018-11-05')
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('3', '3', '8', '2019-06-11')
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('4', '4', '6', '2019-06-05')
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('5', '4', '5', '2019-06-20')
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('6', '5', '9', '2009-02-02')
insert into Orders (order_id, book_id, quantity, dispatch_date) values ('7', '5', '8', '2010-04-13')


select 
	b.book_id,
	b.name,
	b.available_from,
	year(dispatch_date) as sold_year,
	sum(quantity) as qty_sold
from books b
left join orders o on b.book_id=o.book_id
where datediff(month, b.available_from, '2019-06-23') >=1
group by 	b.book_id,
			b.name,
			b.available_from,
			year(dispatch_date)

select book_id, name
from books 
where datediff(month, available_from, '2019-06-23') >1 
and book_id not in (
	select 
		book_id
	from orders o
	where dispatch_date between dateadd(year, -1, '2019-06-23') and '2019-06-23'
	group by book_id
	having sum(quantity) >= 10
)

/*
Create table Traffic (user_id int, activity varchar(100), activity_date date)
Truncate table Traffic
insert into Traffic (user_id, activity, activity_date) values ('1', 'login', '2019-05-01')
insert into Traffic (user_id, activity, activity_date) values ('1', 'homepage', '2019-05-01')
insert into Traffic (user_id, activity, activity_date) values ('1', 'logout', '2019-05-01')
insert into Traffic (user_id, activity, activity_date) values ('2', 'login', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('2', 'logout', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('3', 'login', '2019-01-01')
insert into Traffic (user_id, activity, activity_date) values ('3', 'jobs', '2019-01-01')
insert into Traffic (user_id, activity, activity_date) values ('3', 'logout', '2019-01-01')
insert into Traffic (user_id, activity, activity_date) values ('4', 'login', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('4', 'groups', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('4', 'logout', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('5', 'login', '2019-03-01')
insert into Traffic (user_id, activity, activity_date) values ('5', 'logout', '2019-03-01')
insert into Traffic (user_id, activity, activity_date) values ('5', 'login', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('5', 'logout', '2019-06-21')
*/
with cte_earliest_login as 
(select user_id, min(activity_date) as earliest_login from traffic where activity = 'login' group by user_id)

select activity_date as login_date, count(1) as user_count from
(
select t.*, c.earliest_login
from Traffic t
join cte_earliest_login c on t.user_id = c.user_id
where activity='login' and activity_date = earliest_login
) sq where datediff(day, sq.activity_date, '2019-06-30') <= 90
group by sq.activity_date 

----
with cte_earliest_login as 
(select user_id, min(activity_date) as earliest_login from traffic where activity = 'login' group by user_id)

select 
	earliest_login as login_date,
	count(1) as user_count
from cte_earliest_login
where datediff(day, earliest_login, '2019-06-30') <= 90
group by earliest_login

Create table Enrollments (student_id int, course_id int, grade int)
Truncate table Enrollments
insert into Enrollments (student_id, course_id, grade) values ('2', '2', '95')
insert into Enrollments (student_id, course_id, grade) values ('2', '3', '95')
insert into Enrollments (student_id, course_id, grade) values ('1', '1', '90')
insert into Enrollments (student_id, course_id, grade) values ('1', '2', '99')
insert into Enrollments (student_id, course_id, grade) values ('3', '1', '80')
insert into Enrollments (student_id, course_id, grade) values ('3', '2', '75')
insert into Enrollments (student_id, course_id, grade) values ('3', '3', '82')
select * from Enrollments

select student_id, min(course_id) as course_id, grade
	from (
	select 
		student_id,
		course_id,
		grade,
		dense_rank() over (partition by student_id order by grade desc) rn
	from Enrollments e
	) sq where sq.rn=1 group by student_id, grade
	order by 1 asc


Create table Actions (user_id int, post_id int, action_date date, action varchar(100), extra varchar(10))
Truncate table Actions
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'like', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'share', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '4', '2019-07-04', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '4', '2019-07-04', 'report', 'spam')
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'report', 'spam')
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'report', 'spam')
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-04', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-04', 'report', 'racism')
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-04', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-04', 'report', 'racism')



with cte_actions as 
(
select
	*
from Actions
where datediff(day, action_date, '2019-07-05') =1 and action='report'
)
select
	extra as report_reason, 
	count(distinct post_id) as report_count
from cte_actions
group by extra


Create table Events (business_id int, event_type varchar(10), occurences int)
Truncate table Events
insert into Events (business_id, event_type, occurences) values ('1', 'reviews', '7')
insert into Events (business_id, event_type, occurences) values ('3', 'reviews', '3')
insert into Events (business_id, event_type, occurences) values ('1', 'ads', '11')
insert into Events (business_id, event_type, occurences) values ('2', 'ads', '7')
insert into Events (business_id, event_type, occurences) values ('3', 'ads', '6')
insert into Events (business_id, event_type, occurences) values ('1', 'page views', '3')
insert into Events (business_id, event_type, occurences) values ('2', 'page views', '12')

select * from Events;

with cte_avg_activity as (
	select event_type,
				cast(avg(occurences * 1.00) as decimal(10,2)) as avg_occurences
		from Events
		group by event_type
)

select 
	business_id
from Events e
where event_type in (select event_type from cte_avg_activity c where e.event_type=c.event_type and e.occurences > c.avg_occurences)
group by e.business_id
having count(1) > 1
	
from cte_avg_activity

Create table Actions (user_id int, post_id int, action_date date, action varchar(50), extra varchar(10))
create table Removals (post_id int, remove_date date)
drop table Actions
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'like', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('1', '1', '2019-07-01', 'share', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '2', '2019-07-04', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('2', '2', '2019-07-04', 'report', 'spam')
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('3', '4', '2019-07-04', 'report', 'spam')
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('4', '3', '2019-07-02', 'report', 'spam')
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-03', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '2', '2019-07-03', 'report', 'racism')
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-03', 'view', 'None')
insert into Actions (user_id, post_id, action_date, action, extra) values ('5', '5', '2019-07-03', 'report', 'racism')
Truncate table Removals
insert into Removals (post_id, remove_date) values ('2', '2019-07-20')
insert into Removals (post_id, remove_date) values ('3', '2019-07-18')

select * from actions;
select * from Removals;
----

with cte_spam as 
	(select post_id, action_date from Actions where extra = 'spam')
, cte_removed as (
	select action_date, 
			sum(case when removed_flag='Y' then 1 else 0 end) as cnt_removed,
			count(1) as total_posts from
	(
		select c.*,
				r.remove_date,
				case when remove_date is not null then 'Y' else 'N' end as removed_flag
		from cte_spam c
		left join Removals r on c.post_id = r.post_id and remove_date>=action_date
	) sq group by action_date
)
select cast(avg(percent_removed) as decimal(10,2)) as average_daily_percent from 
(
	select action_date, (cnt_removed * 1.00/total_posts) * 100 as percent_removed from cte_removed
) sq 


Create table Activity (user_id int, session_id int, activity_date date, activity_type varchar(20))
truncate table Activity
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'open_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'scroll_down')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'end_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-20', 'open_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'send_message')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'end_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'open_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'send_message')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'end_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '5', '2019-07-21', 'open_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '5', '2019-07-21', 'scroll_down')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '5', '2019-07-21', 'end_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'open_session')
insert into Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'end_session')

--
select * from activity

--select cast(ROUND((case when sum(session_cnt) is null then 0.00 else SUM(session_cnt) end) * 1.00 / ISNULL(count(user_id), 1),2) as decimal(10,2)) as average_sessions_per_user

select --cast((case when count(distinct user_id)=0 then 0.00 else cast(SUM(session_cnt) as decimal(10,2)) end / case when count(distinct user_id)=0 then 1 else count(distinct user_id) end) as decimal(10,2)) as average_sessions_per_user
	case when count(distinct user_id)=0 then 0.00
			else cast(cast(SUM(session_cnt) as decimal(10,2)) / count(distinct user_id) as decimal(10,2)) 
				end as average_sessions_per_user
from	
	(	select
			user_id,
			count(distinct session_id) as session_cnt
		from activity
		where datediff(day, activity_date, '2019-07-27') between 0 and 29
		group by user_id
	)sq 

Create table Views (article_id int, author_id int, viewer_id int, view_date date)
Truncate table Views
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '5', '2019-08-01')
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '5', '2019-08-01')
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '6', '2019-08-02')
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '7', '2019-08-01')
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '6', '2019-08-02')
insert into Views (article_id, author_id, viewer_id, view_date) values ('4', '7', '1', '2019-07-22')
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21')
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21')
--
select * from Views

select author_id as id from Views
where author_id=viewer_id
group by author_id
having count(1) >=1
order by 1 asc

select * from Views

select distinct
	viewer_id as id
from Views
group by viewer_id, view_date
having count(distinct article_id) >1
order by 1 asc

Create table Users (user_id int, join_date date, favorite_brand varchar(10))
Create table Orders (order_id int, order_date date, item_id int, buyer_id int, seller_id int)
Create table Items (item_id int, item_brand varchar(10))
drop table Users
insert into Users (user_id, join_date, favorite_brand) values ('1', '2018-01-01', 'Lenovo')
insert into Users (user_id, join_date, favorite_brand) values ('2', '2018-02-09', 'Samsung')
insert into Users (user_id, join_date, favorite_brand) values ('3', '2018-01-19', 'LG')
insert into Users (user_id, join_date, favorite_brand) values ('4', '2018-05-21', 'HP')
drop table Orders
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('1', '2019-08-01', '4', '1', '2')
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('2', '2018-08-02', '2', '1', '3')
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('3', '2019-08-03', '3', '2', '3')
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('4', '2018-08-04', '1', '4', '2')
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('5', '2018-08-04', '1', '3', '4')
insert into Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('6', '2019-08-05', '2', '2', '4')
Truncate table Items
insert into Items (item_id, item_brand) values ('1', 'Samsung')
insert into Items (item_id, item_brand) values ('2', 'Lenovo')
insert into Items (item_id, item_brand) values ('3', 'LG')
insert into Items (item_id, item_brand) values ('4', 'HP')
--



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

Create table Products (product_id int, new_price int, change_date date)
Truncate table Products
insert into Products (product_id, new_price, change_date) values ('1', '20', '2019-08-14')
insert into Products (product_id, new_price, change_date) values ('2', '50', '2019-08-14')
insert into Products (product_id, new_price, change_date) values ('1', '30', '2019-08-15')
insert into Products (product_id, new_price, change_date) values ('1', '35', '2019-08-16')
insert into Products (product_id, new_price, change_date) values ('2', '65', '2019-08-17')
insert into Products (product_id, new_price, change_date) values ('3', '20', '2019-08-18')

with cte_prod as (
	select *,
			rank() over (partition by product_id order by change_date desc) rn
	from Products
	where change_date <= '2019-08-16'
)
select distinct p.product_id, isnull(sq.new_price, 10) as price 
from products p 
left join ( select product_id, new_price from cte_prod where rn=1) sq
		on p.product_id=sq.product_id
order by 2 desc

Create table Delivery (delivery_id int, customer_id int, order_date date, customer_pref_delivery_date date)
Truncate table Delivery
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('1', '1', '2019-08-01', '2019-08-02')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('2', '5', '2019-08-02', '2019-08-02')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('3', '1', '2019-08-11', '2019-08-11')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('4', '3', '2019-08-24', '2019-08-26')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('5', '4', '2019-08-21', '2019-08-22')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('6', '2', '2019-08-11', '2019-08-13')

insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('1', '1', '2019-08-01', '2019-08-02')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('2', '2', '2019-08-02', '2019-08-02')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('3', '1', '2019-08-11', '2019-08-12')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('4', '3', '2019-08-24', '2019-08-24')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('5', '3', '2019-08-21', '2019-08-22')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('6', '2', '2019-08-11', '2019-08-13')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('7', '4', '2019-08-09', '2019-08-09')

select
	case when count(1) =0 then 0.00 else 
		cast(sum(case when order_date=customer_pref_delivery_date then 1.00 else 0 end) / count(1) * 100 as decimal(5,2)) 
	end as immediate_percentage 
from Delivery

select * from Delivery
-- soln
WITH cte_first_order
     AS (SELECT DISTINCT delivery_id,
                         customer_id,
                         order_date,
                         Min(order_date)
                           OVER (
                             partition BY customer_id
                             ORDER BY order_date) first_order,
                         CASE
                           WHEN order_date = customer_pref_delivery_date THEN
                           'Y'
                           ELSE 'N'
                         END                      AS immediate_order_flag
         FROM   delivery)
SELECT CASE
         WHEN Count(1) = 0 THEN 0.00
         ELSE Cast(Sum(CASE
                         WHEN immediate_order_flag = 'Y' THEN 1.00
                         ELSE 0
                       END) * 100 / Count(1) AS DECIMAL(5, 2))
       END AS immediate_percentage
FROM   cte_first_order c
WHERE  c.order_date = c.first_order 


/*
Create table  Department (id int, revenue int, month varchar(5))
DROP table Department
insert into Department (id, revenue, month) values ('1', '8000', 'Jan')
insert into Department (id, revenue, month) values ('2', '9000', 'Jan')
insert into Department (id, revenue, month) values ('3', '10000', 'Feb')
insert into Department (id, revenue, month) values ('1', '7000', 'Feb')
insert into Department (id, revenue, month) values ('1', '6000', 'Mar')
*/
-- sol
select id, Jan as Jan_Revenue, Feb as Feb_Revenue, Mar as Mar_Revenue, Apr as Apr_Revenue, May as May_Revenue
					,Jun as Jun_Revenue, Jul as Jul_Revenue, Aug as Aug_Revenue, Sep as Sep_Revenue, Oct as Oct_Revenue
					,Nov as Nov_Revenue, Dec as Dec_Revenue
from
(
select * from Department
) s
pivot
(
	max(revenue)
	for month in (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec)
) piv;

-- OR
select
	id,
	max(case when month='Jan' then revenue else null end) as Jan_Revenue,
	max(case when month='Feb' then revenue else null end) as Feb_Revenue
from Department
group by id

Truncate table Transactions
insert into Transactions (id, country, state, amount, trans_date) values ('121', 'US', 'approved', '1000', '2018-12-18')
insert into Transactions (id, country, state, amount, trans_date) values ('122', 'US', 'declined', '2000', '2018-12-19')
insert into Transactions (id, country, state, amount, trans_date) values ('123', 'US', 'approved', '2000', '2019-01-01')
insert into Transactions (id, country, state, amount, trans_date) values ('124', 'DE', 'approved', '2000', '2019-01-07')
*/
	--cast(year(trans_date) as varchar(4)) + '-' + cast(MONTH(trans_date) as varchar(2)) as month,
--select * from Transactions

select 
	month, country,
	count(1) as trans_count,
	sum(case when state='approved' then 1 else 0 end) as approved_count,
	sum(amount) as trans_total_amount,
	sum(case when state='approved' then amount else 0 end) as approved_total_amount
from (
	select
		left(convert(varchar(10), trans_date),7) as month,
		country,
		state, amount
	from Transactions
) sq group by month, country
/*
Create table Queue (person_id int, person_name varchar(30), weight int, turn int)
Truncate table Queue
insert into Queue (person_id, person_name, weight, turn) values ('5', 'Alice', '250', '1')
insert into Queue (person_id, person_name, weight, turn) values ('4', 'Bob', '175', '5')
insert into Queue (person_id, person_name, weight, turn) values ('3', 'Alex', '350', '2')
insert into Queue (person_id, person_name, weight, turn) values ('6', 'John Cena', '400', '3')
insert into Queue (person_id, person_name, weight, turn) values ('1', 'Winston', '500', '6')
insert into Queue (person_id, person_name, weight, turn) values ('2', 'Marie', '200', '4')
*/
--
with cte_rolling_sum as (
	select
		turn as Trun,
		person_id as ID,
		person_name,
		Weight,
		SUM(weight) over (order by turn asc) as [Total Weight]
	from Queue	
)
select top 1 person_name from cte_rolling_sum
where [Total Weight] <=1000
order by [Total Weight] desc

--
with cte_transaction as 
(
	select 
		month, country,
		sum(case when state='approved' then 1 else 0 end) as approved_count,
		sum(case when state='approved' then amount else 0 end) as approved_amount
	from (
		select
			left(convert(varchar(10), t.trans_date),7) as month,
			country,
			state, amount
		from Transactions t
	) sq group by month, country
), cte_chargeback as (
	select left(convert(varchar(10), c.trans_date),7) as [month], count(1) as chargeback_count, sum(amount) as chargeback_amount   from Chargebacks c join transactions t on c.trans_id = t.id
			group by left(convert(varchar(10), c.trans_date),7)
), cte_chargeback_except as (
	select left(convert(varchar(10), c.trans_date),7) as month, country, count(1) as chargeback_count, sum(amount) as chargeback_amount
	from Chargebacks c left join transactions t on c.trans_id=t.id 
	where left(convert(varchar(10), c.trans_date),7) not in (select month from cte_transaction)
	group by left(convert(varchar(10), c.trans_date),7), country
)
select 
	t.*, c.chargeback_count, c.chargeback_amount
from cte_transaction t left join cte_chargeback c on t.month=c.[month]
union
select month, country, 0 as approved_count, 0 as approved_amount, chargeback_count, chargeback_amount
from cte_chargeback_except


Create table Transactions (id int, country varchar(4), state varchar(50), amount int, trans_date date)
Create table Chargebacks (trans_id int, trans_date date)
drop table Transactions
insert into Transactions (id, country, state, amount, trans_date) values ('101', 'US', 'approved', '1000', '2019-05-18')
insert into Transactions (id, country, state, amount, trans_date) values ('102', 'US', 'declined', '2000', '2019-05-19')
insert into Transactions (id, country, state, amount, trans_date) values ('103', 'US', 'approved', '3000', '2019-06-10')
insert into Transactions (id, country, state, amount, trans_date) values ('104', 'US', 'declined', '4000', '2019-06-13')
insert into Transactions (id, country, state, amount, trans_date) values ('105', 'US', 'approved', '5000', '2019-06-15')
Truncate table Chargebacks
insert into Chargebacks (trans_id, trans_date) values ('102', '2019-05-29')
insert into Chargebacks (trans_id, trans_date) values ('101', '2019-06-30')
insert into Chargebacks (trans_id, trans_date) values ('105', '2019-09-18')

select * from Transactions
select * from Chargebacks

Create table Queries (query_name varchar(30), result varchar(50), position int, rating int)
Truncate table Queries
insert into Queries (query_name, result, position, rating) values ('Dog', 'Golden Retriever', '1', '5')
insert into Queries (query_name, result, position, rating) values ('Dog', 'German Shepherd', '2', '5')
insert into Queries (query_name, result, position, rating) values ('Dog', 'Mule', '200', '1')
insert into Queries (query_name, result, position, rating) values ('Cat', 'Shirazi', '5', '2')
insert into Queries (query_name, result, position, rating) values ('Cat', 'Siamese', '3', '3')
insert into Queries (query_name, result, position, rating) values ('Cat', 'Sphynx', '7', '4')

select * from Queries

with cte_query as (
	select *
			,(rating * 1.00 / position)  as ind_quality
	from queries q
)
select query_name,
		case when count(1)=0 then 0.00 else cast(sum(ind_quality) / count(1) as decimal(5,2)) end as quality,
		case when count(1) =0 then 0.00 else cast(sum(case when rating<3 then 1 else 0 end) * 1.00 / count(1) * 100 as decimal(5,2)) end as poor_query_percentage 
from cte_query
group by query_name

Create table  Teams (team_id int, team_name varchar(30))
Create table  Matches (match_id int, host_team int, guest_team int, host_goals int, guest_goals int)
Truncate table Teams
insert into Teams (team_id, team_name) values ('10', 'Leetcode FC')
insert into Teams (team_id, team_name) values ('20', 'NewYork FC')
insert into Teams (team_id, team_name) values ('30', 'Atlanta FC')
insert into Teams (team_id, team_name) values ('40', 'Chicago FC')
insert into Teams (team_id, team_name) values ('50', 'Toronto FC')
Truncate table Matches
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('1', '10', '20', '3', '0')
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('2', '30', '10', '2', '2')
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('3', '10', '50', '5', '1')
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('4', '20', '30', '1', '0')
insert into Matches (match_id, host_team, guest_team, host_goals, guest_goals) values ('5', '50', '30', '1', '0')

select t.team_id, t.team_name, isnull(sum(num_points), 0) as num_points
from  teams t
left join (
	select
		host_team as team_id,
		3 as num_points
	from matches where host_goals>guest_goals
	UNION  ALL
	select
		guest_team as team_id,
		3 as num_points
	from matches where host_goals<guest_goals
	UNION ALL
	select
		host_team as team_id,
		1 as num_points
	from matches where host_goals=guest_goals
	UNION ALL
	select
		guest_team as team_id,
		1 as num_points
	from matches where host_goals=guest_goals
) sq on sq.team_id=t.team_id 
group by t.team_id, t.team_name
order by num_points desc, t.team_id asc

select * from teams

/*
Create table  Submissions (sub_id int, parent_id int)
Truncate table Submissions
insert into Submissions (sub_id, parent_id) values ('1', NULL)
insert into Submissions (sub_id, parent_id) values ('2', NULL)
insert into Submissions (sub_id, parent_id) values ('1', NULL)
insert into Submissions (sub_id, parent_id) values ('12', NULL)
insert into Submissions (sub_id, parent_id) values ('3', '1')
insert into Submissions (sub_id, parent_id) values ('5', '2')
insert into Submissions (sub_id, parent_id) values ('3', '1')
insert into Submissions (sub_id, parent_id) values ('4', '1')
insert into Submissions (sub_id, parent_id) values ('9', '1')
insert into Submissions (sub_id, parent_id) values ('10', '2')
insert into Submissions (sub_id, parent_id) values ('6', '7')
*/

select 
	distinct sub_id as post_id, isnull(sq1.number_of_comments, 0) as number_of_comments
from Submissions s
left join 
	(select parent_id, count(1)  as number_of_comments from (
		select distinct
			sub_id,
			parent_id
		from Submissions where parent_id is not null
	) sq group by parent_id
) sq1 on s.sub_id=sq1.parent_id
where s.parent_id is null
order by 1


/*
Create table Prices (product_id int, start_date date, end_date date, price int)
Create table  UnitsSold (product_id int, purchase_date date, units int)
Truncate table Prices
insert into Prices (product_id, start_date, end_date, price) values ('1', '2019-02-17', '2019-02-28', '5')
insert into Prices (product_id, start_date, end_date, price) values ('1', '2019-03-01', '2019-03-22', '20')
insert into Prices (product_id, start_date, end_date, price) values ('2', '2019-02-01', '2019-02-20', '15')
insert into Prices (product_id, start_date, end_date, price) values ('2', '2019-02-21', '2019-03-31', '30')
Truncate table UnitsSold
insert into UnitsSold (product_id, purchase_date, units) values ('1', '2019-02-25', '100')
insert into UnitsSold (product_id, purchase_date, units) values ('1', '2019-03-01', '15')
insert into UnitsSold (product_id, purchase_date, units) values ('2', '2019-02-10', '200')
insert into UnitsSold (product_id, purchase_date, units) values ('2', '2019-03-22', '30')
*/

with cte_prod as (
	select 
		p.product_id,
		price, units
	from prices p 
	join UnitsSold u on p.product_id=u.product_id and u.purchase_date between p.start_date and p.end_date
)
select 
	product_id,
	case when sum(units)=0 then 0.00 else cast(sum(price * units) * 1.00 / sum(units) as decimal(10,2)) end as average_price 
from cte_prod
group by product_id

/*
Create table  Friendship (user1_id int, user2_id int)
Create table  Likes (user_id int, page_id int)
Truncate table Friendship
insert into Friendship (user1_id, user2_id) values ('1', '2')
insert into Friendship (user1_id, user2_id) values ('1', '3')
insert into Friendship (user1_id, user2_id) values ('1', '4')
insert into Friendship (user1_id, user2_id) values ('2', '3')
insert into Friendship (user1_id, user2_id) values ('2', '4')
insert into Friendship (user1_id, user2_id) values ('2', '5')
insert into Friendship (user1_id, user2_id) values ('6', '1')
Truncate table Likes
insert into Likes (user_id, page_id) values ('1', '88')
insert into Likes (user_id, page_id) values ('2', '23')
insert into Likes (user_id, page_id) values ('3', '24')
insert into Likes (user_id, page_id) values ('4', '56')
insert into Likes (user_id, page_id) values ('5', '11')
insert into Likes (user_id, page_id) values ('6', '33')
insert into Likes (user_id, page_id) values ('2', '77')
insert into Likes (user_id, page_id) values ('3', '77')
insert into Likes (user_id, page_id) values ('6', '88')
*/

with cte_user1_friends as (
	select user2_id as user_id from Friendship where user1_id=1
	UNION 
	select user1_id as user_id from Friendship where user2_id=1
)
select distinct page_id as recommended_page 
from likes l where l.user_id in (select user_id from cte_user1_friends)
except
select page_id from likes where user_id=1

/*
Create table  Employees (employee_id int, employee_name varchar(30), manager_id int)
Truncate table Employees
insert into Employees (employee_id, employee_name, manager_id) values ('1', 'Boss', '1')
insert into Employees (employee_id, employee_name, manager_id) values ('3', 'Alice', '3')
insert into Employees (employee_id, employee_name, manager_id) values ('2', 'Bob', '1')
insert into Employees (employee_id, employee_name, manager_id) values ('4', 'Daniel', '2')
insert into Employees (employee_id, employee_name, manager_id) values ('7', 'Luis', '4')
insert into Employees (employee_id, employee_name, manager_id) values ('8', 'John', '3')
insert into Employees (employee_id, employee_name, manager_id) values ('9', 'Angela', '8')
insert into Employees (employee_id, employee_name, manager_id) values ('77', 'Robert', '1')
*/

with cte_managers as (
select
	e.employee_id,
	e.manager_id as m1,
	m2.manager_id as m2,
	m3.manager_id as m3
from Employees e
left join Employees m2 on e.manager_id=m2.employee_id
left join Employees m3 on m2.manager_id=m3.employee_id
where e.employee_id<>e.manager_id
)
select employee_id
from cte_managers
where m1=1 or m2=1 or m3=1

Create table Students (student_id int, student_name varchar(20))
Create table Subjects (subject_name varchar(20))
Create table Examinations (student_id int, subject_name varchar(20))
Truncate table Students
insert into Students (student_id, student_name) values ('1', 'Alice')
insert into Students (student_id, student_name) values ('2', 'Bob')
insert into Students (student_id, student_name) values ('13', 'John')
insert into Students (student_id, student_name) values ('6', 'Alex')
Truncate table Subjects
insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')
Truncate table Examinations
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')

--
with cte_sub_available as 
(
	select 
		student_id,
		subject_name,
		count(1) as attended_exams
	from
		Examinations e
	group by student_id, subject_name
)
select 
	s.student_id,
	s.student_name,
	sb.subject_name,
	isnull(c.attended_exams, 0) as attended_exams
from Students s
cross join Subjects sb
left join cte_sub_available c on s.student_id=c.student_id and sb.subject_name=c.subject_name
order by 	s.student_id, sb.subject_name


Create table Logs (log_id int)
Truncate table Logs
insert into Logs (log_id) values ('1')
insert into Logs (log_id) values ('2')
insert into Logs (log_id) values ('3')
insert into Logs (log_id) values ('7')
insert into Logs (log_id) values ('8')
insert into Logs (log_id) values ('10')

with cte_logs as (
select
	log_id,
	ROW_NUMBER() over (order by log_id) as rn,
	log_id - ROW_NUMBER() over (order by log_id) as row_diff
from Logs
)
select min(log_id) as start_id,
		max(log_id) as end_id
from cte_logs
group by row_diff
order by min(log_id)

Create table Countries (country_id int, country_name varchar(20))
Create table Weather (country_id int, weather_state int, day date)
Truncate table Countries
insert into Countries (country_id, country_name) values ('2', 'USA')
insert into Countries (country_id, country_name) values ('3', 'Australia')
insert into Countries (country_id, country_name) values ('7', 'Peru')
insert into Countries (country_id, country_name) values ('5', 'China')
insert into Countries (country_id, country_name) values ('8', 'Morocco')
insert into Countries (country_id, country_name) values ('9', 'Spain')
DROP table Weather
insert into Weather (country_id, weather_state, day) values ('2', '15', '2019-11-01')
insert into Weather (country_id, weather_state, day) values ('2', '12', '2019-10-28')
insert into Weather (country_id, weather_state, day) values ('2', '12', '2019-10-27')
insert into Weather (country_id, weather_state, day) values ('3', '-2', '2019-11-10')
insert into Weather (country_id, weather_state, day) values ('3', '0', '2019-11-11')
insert into Weather (country_id, weather_state, day) values ('3', '3', '2019-11-12')
insert into Weather (country_id, weather_state, day) values ('5', '16', '2019-11-07')
insert into Weather (country_id, weather_state, day) values ('5', '18', '2019-11-09')
insert into Weather (country_id, weather_state, day) values ('5', '21', '2019-11-23')
insert into Weather (country_id, weather_state, day) values ('7', '25', '2019-11-28')
insert into Weather (country_id, weather_state, day) values ('7', '22', '2019-12-01')
insert into Weather (country_id, weather_state, day) values ('7', '20', '2019-12-02')
insert into Weather (country_id, weather_state, day) values ('8', '25', '2019-11-05')
insert into Weather (country_id, weather_state, day) values ('8', '27', '2019-11-15')
insert into Weather (country_id, weather_state, day) values ('8', '31', '2019-11-25')
insert into Weather (country_id, weather_state, day) values ('9', '7', '2019-10-23')
insert into Weather (country_id, weather_state, day) values ('9', '3', '2019-12-23')
--

with cte_avg_weather as 
(
select
	country_id,
	avg(weather_state * 1.00) as avg_weather
from Weather w
where [day] between '2019-11-01' and '2019-11-30'
group by country_id
)
select 
	c.country_name,
	case when avg_weather <= 15 then 'Cold'
		when avg_weather >= 25 then 'Hot'
		else 'Warm' end as weather_type
from cte_avg_weather  w
left join Countries c on w.country_id=c.country_id

Create table Employee (employee_id int, team_id int)
DROP table Employee
insert into Employee (employee_id, team_id) values ('1', '8')
insert into Employee (employee_id, team_id) values ('2', '8')
insert into Employee (employee_id, team_id) values ('3', '8')
insert into Employee (employee_id, team_id) values ('4', '7')
insert into Employee (employee_id, team_id) values ('5', '9')
insert into Employee (employee_id, team_id) values ('6', '9')

with cte as (
			select
				team_id,
				count(team_id) as team_size
			from Employee
			group by team_id
)
select 
	employee_id,
	sq.team_size
from employee e 
left join cte sq on e.team_id = sq.team_id

--
Create table Scores (player_name varchar(20), gender varchar(1), day date, score_points int)
Truncate table Scores
insert into Scores (player_name, gender, day, score_points) values ('Aron', 'F', '2020-01-01', '17')
insert into Scores (player_name, gender, day, score_points) values ('Alice', 'F', '2020-01-07', '23')
insert into Scores (player_name, gender, day, score_points) values ('Bajrang', 'M', '2020-01-07', '7')
insert into Scores (player_name, gender, day, score_points) values ('Khali', 'M', '2019-12-25', '11')
insert into Scores (player_name, gender, day, score_points) values ('Slaman', 'M', '2019-12-30', '13')
insert into Scores (player_name, gender, day, score_points) values ('Joe', 'M', '2019-12-31', '3')
insert into Scores (player_name, gender, day, score_points) values ('Jose', 'M', '2019-12-18', '2')
insert into Scores (player_name, gender, day, score_points) values ('Priya', 'F', '2019-12-31', '23')
insert into Scores (player_name, gender, day, score_points) values ('Priyanka', 'F', '2019-12-30', '17')
--

select
	gender,
	[day],
	sum(score_points) over(partition by gender order by [day]) as total
from Scores
group by gender, [day], score_points
order by gender, [day]

Create table Customer (customer_id int, name varchar(20), visited_on date, amount int)
DROP table Customer
insert into Customer (customer_id, name, visited_on, amount) values ('1', 'Jhon', '2019-01-01', '100')
insert into Customer (customer_id, name, visited_on, amount) values ('2', 'Daniel', '2019-01-02', '110')
insert into Customer (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-03', '120')
insert into Customer (customer_id, name, visited_on, amount) values ('4', 'Khaled', '2019-01-04', '130')
insert into Customer (customer_id, name, visited_on, amount) values ('5', 'Winston', '2019-01-05', '110')
insert into Customer (customer_id, name, visited_on, amount) values ('6', 'Elvis', '2019-01-06', '140')
insert into Customer (customer_id, name, visited_on, amount) values ('7', 'Anna', '2019-01-07', '150')
insert into Customer (customer_id, name, visited_on, amount) values ('8', 'Maria', '2019-01-08', '80')
insert into Customer (customer_id, name, visited_on, amount) values ('9', 'Jaze', '2019-01-09', '110')
insert into Customer (customer_id, name, visited_on, amount) values ('1', 'Jhon', '2019-01-10', '130')
insert into Customer (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-10', '150')

--
-- Solution- 1
select visited_on, amount, average_amount 
from 
(
	select 
	visited_on,
	sum(amount) over(order by visited_on rows between 6 preceding and current row) as amount,
	cast(round(sum(amount) over(order by visited_on rows between 6 preceding and current row) * 1.00 / 7, 2) as decimal(8,2)) as average_amount,
	rank() over (order by visited_on asc) rn
	from (
		select
			c1.visited_on,
			sum(amount) as amount
		from Customer c1
		group by visited_on
	) sq1
) sq2 where sq2.rn >=7
order by 1

-- Solution- 2
with cte1 as (
select
	visited_on,
	sum(amount) as total_amount
FROM customer 
group by visited_on ),

cte2 as (
select
	visited_on,
	sum(total_amount) over(order by visited_on rows between 6 preceding and current row) as amount,
	cast(ROUND(avg(total_amount * 1.00) over(order by visited_on rows between 6 preceding and current row), 2) as decimal(8,2)) as average_amount
from cte1 )

select 
	*
from cte2
where datediff(day, (select min(visited_on) from cte2), visited_on) >= 6

select DATEDIFF(day, '2023-05-17', '2023-05-19')
Create table Ads (ad_id int, user_id int, action varchar(20))
Truncate table Ads
insert into Ads (ad_id, user_id, action) values ('1', '1', 'Clicked')
insert into Ads (ad_id, user_id, action) values ('2', '2', 'Clicked')
insert into Ads (ad_id, user_id, action) values ('3', '3', 'Viewed')
insert into Ads (ad_id, user_id, action) values ('5', '5', 'Ignored')
insert into Ads (ad_id, user_id, action) values ('1', '7', 'Ignored')
insert into Ads (ad_id, user_id, action) values ('2', '7', 'Viewed')
insert into Ads (ad_id, user_id, action) values ('3', '5', 'Clicked')
insert into Ads (ad_id, user_id, action) values ('1', '4', 'Viewed')
insert into Ads (ad_id, user_id, action) values ('2', '11', 'Viewed')
insert into Ads (ad_id, user_id, action) values ('1', '2', 'Clicked')
--
with cte_metrics as (
select
	ad_id,
	SUM(case when action='Clicked' then 1 else 0 end) as total_clicks,
	SUM(case when action='Viewed' then 1 else 0 end) as total_views
from Ads
group by ad_id
)
select ad_id,
		cast(ROUND(case when total_clicks + total_views = 0 then 0.00 else total_clicks * 1.00 / (total_clicks + total_views) end * 100, 2) as decimal(5,2)) as ctr
from cte_metrics
order by ctr desc, ad_id asc

----
Create table Products (product_id int, product_name varchar(40), product_category varchar(40))
Create table Orders (product_id int, order_date date, unit int)
DROP table Products
insert into Products (product_id, product_name, product_category) values ('1', 'Leetcode Solutions', 'Book')
insert into Products (product_id, product_name, product_category) values ('2', 'Jewels of Stringology', 'Book')
insert into Products (product_id, product_name, product_category) values ('3', 'HP', 'Laptop')
insert into Products (product_id, product_name, product_category) values ('4', 'Lenovo', 'Laptop')
insert into Products (product_id, product_name, product_category) values ('5', 'Leetcode Kit', 'T-shirt')
DROP table Orders
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-05', '60')
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-10', '70')
insert into Orders (product_id, order_date, unit) values ('2', '2020-01-18', '30')
insert into Orders (product_id, order_date, unit) values ('2', '2020-02-11', '80')
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-17', '2')
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-24', '3')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-01', '20')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '30')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '60')
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-25', '50')
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-27', '50')
insert into Orders (product_id, order_date, unit) values ('5', '2020-03-01', '50')
------

select 
	P.product_name,
	sum(unit) as unit
from Orders O 
join Products P on O.product_id=P.product_id
where datepart(month, order_date) = 2 and datepart(year, order_date) = 2020
group by P.product_name
having sum(unit) >=100

----*******************
Create table Movies (movie_id int, title varchar(30))
Create table Users (user_id int, name varchar(30))
Create table MovieRating (movie_id int, user_id int, rating int, created_at date)
Truncate table Movies
insert into Movies (movie_id, title) values ('1', 'Avengers')
insert into Movies (movie_id, title) values ('2', 'Frozen 2')
insert into Movies (movie_id, title) values ('3', 'Joker')
DROP table Users
insert into Users (user_id, name) values ('1', 'Daniel')
insert into Users (user_id, name) values ('2', 'Monica')
insert into Users (user_id, name) values ('3', 'Maria')
insert into Users (user_id, name) values ('4', 'James')
Truncate table MovieRating
insert into MovieRating (movie_id, user_id, rating, created_at) values ('1', '1', '3', '2020-01-12')
insert into MovieRating (movie_id, user_id, rating, created_at) values ('1', '2', '4', '2020-02-11')
insert into MovieRating (movie_id, user_id, rating, created_at) values ('1', '3', '2', '2020-02-12')
insert into MovieRating (movie_id, user_id, rating, created_at) values ('1', '4', '1', '2020-01-01')
insert into MovieRating (movie_id, user_id, rating, created_at) values ('2', '1', '5', '2020-02-17')
insert into MovieRating (movie_id, user_id, rating, created_at) values ('2', '2', '2', '2020-02-01')
insert into MovieRating (movie_id, user_id, rating, created_at) values ('2', '3', '2', '2020-03-01')
insert into MovieRating (movie_id, user_id, rating, created_at) values ('3', '1', '3', '2020-02-22')
insert into MovieRating (movie_id, user_id, rating, created_at) values ('3', '2', '4', '2020-02-25')

WITH cte_base as (
select
	u.name,
	M.title,
	mr.rating,
	mr.created_at
from MovieRating mr
left join Users u on mr.user_id=u.user_id
left join Movies M on mr.movie_id=M.movie_id
),
cte_max_rating as (
select top 1
	title as results
from cte_base
where datepart(month, created_at) = 2 and datepart(year, created_at) = 2020
group by title
order by avg(rating * 1.00) desc, title asc
),
cte_max_avg as (
select top 1 name  as results
from cte_base
group by name
order by count(1) desc, name asc
)
select * from cte_max_rating
UNION ALL
select * from cte_max_avg

Create table Departments (id int, name varchar(30))
Create table  Students (id int, name varchar(30), department_id int)
Truncate table Departments
insert into Departments (id, name) values ('1', 'Electrical Engineering')
insert into Departments (id, name) values ('7', 'Computer Engineering')
insert into Departments (id, name) values ('13', 'Bussiness Administration')
DROP table Students
insert into Students (id, name, department_id) values ('23', 'Alice', '1')
insert into Students (id, name, department_id) values ('1', 'Bob', '7')
insert into Students (id, name, department_id) values ('5', 'Jennifer', '13')
insert into Students (id, name, department_id) values ('2', 'John', '14')
insert into Students (id, name, department_id) values ('4', 'Jasmine', '77')
insert into Students (id, name, department_id) values ('3', 'Steve', '74')
insert into Students (id, name, department_id) values ('6', 'Luis', '1')
insert into Students (id, name, department_id) values ('8', 'Jonathan', '7')
insert into Students (id, name, department_id) values ('7', 'Daiana', '33')
insert into Students (id, name, department_id) values ('11', 'Madelynn', '1')

select id, name from Students 
EXCEPT
select 
	S.id,
	S.name
from Students S
join Departments D on S.department_id = D.id


Create table Friends (id int, name varchar(30), activity varchar(30))
Create table Activities (id int, name varchar(30))
Truncate table Friends
insert into Friends (id, name, activity) values ('1', 'Jonathan D.', 'Eating')
insert into Friends (id, name, activity) values ('2', 'Jade W.', 'Horse Riding')
insert into Friends (id, name, activity) values ('3', 'Victor J.', 'Eating')
insert into Friends (id, name, activity) values ('4', 'Elvis Q.', 'Singing')
insert into Friends (id, name, activity) values ('5', 'Daniel A.', 'Eating')
insert into Friends (id, name, activity) values ('6', 'Bob B.', 'Horse Riding')
insert into Friends (id, name, activity) values ('7', 'test.', 'Singing')
insert into Friends (id, name, activity) values ('1', 'Jonathan D.', 'Eating')
insert into Friends (id, name, activity) values ('2', 'Jade W.', 'Singing')
insert into Friends (id, name, activity) values ('3', 'Victor J.', 'Singing')
insert into Friends (id, name, activity) values ('4', 'Elvis Q.', 'Eating')
insert into Friends (id, name, activity) values ('5', 'Daniel A.', 'Eating')
insert into Friends (id, name, activity) values ('6', 'Bob B.', 'Horse Riding')
Truncate table Activities
insert into Activities (id, name) values ('1', 'Eating')
insert into Activities (id, name) values ('2', 'Singing')
insert into Activities (id, name) values ('3', 'Horse Riding')
--
with cte_activity_stats as (
	select
		activity,
		count(1) as activity_cnt
	from Friends
group by activity 
), cte_max_min as (
	select activity 
	from cte_activity_stats 
	where activity_cnt = (select max(activity_cnt) from cte_activity_stats)
	UNION
	select activity 
	from cte_activity_stats 
	where activity_cnt = (select MIN(activity_cnt) from cte_activity_stats)
)
select activity
from cte_activity_stats where activity not in (select * from cte_max_min)


Create table  Customers (customer_id int, customer_name varchar(20), email varchar(30))
Create table Contacts (user_id int, contact_name varchar(20), contact_email varchar(30))
Create table Invoices (invoice_id int, price int, user_id int)
Truncate table Customers
insert into Customers (customer_id, customer_name, email) values ('1', 'Alice', 'alice@leetcode.com')
insert into Customers (customer_id, customer_name, email) values ('2', 'Bob', 'bob@leetcode.com')
insert into Customers (customer_id, customer_name, email) values ('13', 'John', 'john@leetcode.com')
insert into Customers (customer_id, customer_name, email) values ('6', 'Alex', 'alex@leetcode.com')
Truncate table Contacts
insert into Contacts (user_id, contact_name, contact_email) values ('1', 'Bob', 'bob@leetcode.com')
insert into Contacts (user_id, contact_name, contact_email) values ('1', 'John', 'john@leetcode.com')
insert into Contacts (user_id, contact_name, contact_email) values ('1', 'Jal', 'jal@leetcode.com')
insert into Contacts (user_id, contact_name, contact_email) values ('2', 'Omar', 'omar@leetcode.com')
insert into Contacts (user_id, contact_name, contact_email) values ('2', 'Meir', 'meir@leetcode.com')
insert into Contacts (user_id, contact_name, contact_email) values ('6', 'Alice', 'alice@leetcode.com')
Truncate table Invoices
insert into Invoices (invoice_id, price, user_id) values ('77', '100', '1')
insert into Invoices (invoice_id, price, user_id) values ('88', '200', '1')
insert into Invoices (invoice_id, price, user_id) values ('99', '300', '2')
insert into Invoices (invoice_id, price, user_id) values ('66', '400', '2')
insert into Invoices (invoice_id, price, user_id) values ('55', '500', '13')
insert into Invoices (invoice_id, price, user_id) values ('44', '60', '6')
---

with cte_contact as (
	select  user_id, count(contact_name) as contacts_cnt 
				from Contacts Ct 
				group by user_id
), cte_trusted_contact as (
	select  user_id, count(contact_name) as trusted_contacts_cnt 
				from Contacts Ct 
				where contact_email in (select email from Customers)
				group by user_id
)
select
	I.invoice_id,
	C.customer_name,
	I.price,
	isnull(sq.contacts_cnt, 0) as contacts_cnt,
	isnull(sq1.trusted_contacts_cnt, 0) as trusted_contacts_cnt
from Invoices I
left join Customers C on I.user_id=C.customer_id
left join cte_contact sq on I.user_id=sq.user_id
left join cte_trusted_contact sq1 on I.user_id=sq1.user_id
order by I.invoice_id

Create table UserActivity (username varchar(30), activity varchar(30), startDate date, endDate date)
Truncate table UserActivity
insert into UserActivity (username, activity, startDate, endDate) values ('Alice', 'Travel', '2020-02-12', '2020-02-20')
insert into UserActivity (username, activity, startDate, endDate) values ('Alice', 'Dancing', '2020-02-21', '2020-02-23')
insert into UserActivity (username, activity, startDate, endDate) values ('Alice', 'Travel', '2020-02-24', '2020-02-28')
insert into UserActivity (username, activity, startDate, endDate) values ('Bob', 'Travel', '2020-02-11', '2020-02-18')

--
with cte_activity as (
select
	username,
	activity,
	startDate,
	endDate,
	dense_rank() over (partition by username order by startDate desc) rn
from UserActivity
), cte_numactivity as 
(select username, count(activity) as activityCnt from UserActivity group by username)

select
	ca.username,
	activity,
	startDate,
	endDate
from cte_activity ca
left join cte_numactivity cn on ca.username=cn.username
where rn = case when cn.activityCnt >1 then 2 else 1 end

Create table  Employees (id int, name varchar(20))
Create table  EmployeeUNI (id int, unique_id int)
DROP table Employees
insert into Employees (id, name) values ('1', 'Alice')
insert into Employees (id, name) values ('7', 'Bob')
insert into Employees (id, name) values ('11', 'Meir')
insert into Employees (id, name) values ('90', 'Winston')
insert into Employees (id, name) values ('3', 'Jonathan')
Truncate table EmployeeUNI
insert into EmployeeUNI (id, unique_id) values ('3', '1')
insert into EmployeeUNI (id, unique_id) values ('11', '2')
insert into EmployeeUNI (id, unique_id) values ('90', '3')
--
select
	EU.unique_id,
	E.name
from Employees E
left join EmployeeUNI EU on E.id=EU.id


Create Table Stocks (stock_name varchar(15), operation varchar(50), operation_day int, price int)
Truncate table Stocks
insert into Stocks (stock_name, operation, operation_day, price) values ('Leetcode', 'Buy', '1', '1000')
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '2', '10')
insert into Stocks (stock_name, operation, operation_day, price) values ('Leetcode', 'Sell', '5', '9000')
insert into Stocks (stock_name, operation, operation_day, price) values ('Handbags', 'Buy', '17', '30000')
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '3', '1010')
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '4', '1000')
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '5', '500')
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '6', '1000')
insert into Stocks (stock_name, operation, operation_day, price) values ('Handbags', 'Sell', '29', '7000')
insert into Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '10', '10000')

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

Create table  Customers (customer_id int, customer_name varchar(30))
Create table  Orders (order_id int, customer_id int, product_name varchar(30))
DROP table Customers
insert into Customers (customer_id, customer_name) values ('1', 'Daniel')
insert into Customers (customer_id, customer_name) values ('2', 'Diana')
insert into Customers (customer_id, customer_name) values ('3', 'Elizabeth')
insert into Customers (customer_id, customer_name) values ('4', 'Jhon')
DROP table Orders
insert into Orders (order_id, customer_id, product_name) values ('10', '1', 'A')
insert into Orders (order_id, customer_id, product_name) values ('20', '1', 'B')
insert into Orders (order_id, customer_id, product_name) values ('30', '1', 'D')
insert into Orders (order_id, customer_id, product_name) values ('40', '1', 'C')
insert into Orders (order_id, customer_id, product_name) values ('50', '2', 'A')
insert into Orders (order_id, customer_id, product_name) values ('60', '3', 'A')
insert into Orders (order_id, customer_id, product_name) values ('70', '3', 'B')
insert into Orders (order_id, customer_id, product_name) values ('80', '3', 'D')
insert into Orders (order_id, customer_id, product_name) values ('90', '4', 'C')
--

with cte_price as (
select
	customer_id,
	product_name,
	case	when product_name = 'A' then 10 
			when product_name = 'B' then 20
			when product_name = 'C' then -1
			else 0 end as grp
from Orders O
)
select cte.customer_id, customer_name
from cte_price cte
join Customers C on cte.customer_id=c.customer_id
group by cte.customer_id, customer_name
having sum(distinct grp) = 30
order by cte.customer_id

--(select customer_id from orders where product_name in ('A', 'B') group by customer_id having count(distinct product_name) =2 )

SELECT DISTINCT b.customer_id, b.customer_name
  FROM Orders a
  JOIN Customers b
    ON a.customer_id = b.customer_id 
 WHERE a.customer_id NOT IN (select customer_id FROM Orders WHERE product_name = 'C')
   AND a.customer_id IN (SELECT customer_id FROM Orders WHERE product_name = 'A')
   AND a.customer_id IN (SELECT customer_id FROM Orders WHERE product_name = 'B')
ORDER BY 1

Create Table Users (id int, name varchar(30))
Create Table Rides (id int, user_id int, distance int)
DROP table Users
insert into Users (id, name) values ('1', 'Alice')
insert into Users (id, name) values ('2', 'Bob')
insert into Users (id, name) values ('3', 'Alex')
insert into Users (id, name) values ('4', 'Donald')
insert into Users (id, name) values ('7', 'Lee')
insert into Users (id, name) values ('13', 'Jonathan')
insert into Users (id, name) values ('19', 'Elvis')
Truncate table Rides
insert into Rides (id, user_id, distance) values ('1', '1', '120')
insert into Rides (id, user_id, distance) values ('2', '2', '317')
insert into Rides (id, user_id, distance) values ('3', '3', '222')
insert into Rides (id, user_id, distance) values ('4', '7', '100')
insert into Rides (id, user_id, distance) values ('5', '13', '312')
insert into Rides (id, user_id, distance) values ('6', '19', '50')
insert into Rides (id, user_id, distance) values ('7', '7', '120')
insert into Rides (id, user_id, distance) values ('8', '19', '400')
insert into Rides (id, user_id, distance) values ('9', '7', '230')
--
select
	U.name, 
	isnull(sq.travelled_distance, 0) as travelled_distance
from Users u 
left join 	(
				select 
					R.user_id,
					isnull(sum(R.distance), 0) as travelled_distance
				from Rides R
				group by R.user_id
			) sq on sq.user_id=U.id
order by 2 desc, 1 asc


Create Table  NPV (id int, year int, npv int)
Create Table Queries (id int, year int)
Truncate table NPV
insert into NPV (id, year, npv) values ('1', '2018', '100')
insert into NPV (id, year, npv) values ('7', '2020', '30')
insert into NPV (id, year, npv) values ('13', '2019', '40')
insert into NPV (id, year, npv) values ('1', '2019', '113')
insert into NPV (id, year, npv) values ('2', '2008', '121')
insert into NPV (id, year, npv) values ('3', '2009', '21')
insert into NPV (id, year, npv) values ('11', '2020', '99')
insert into NPV (id, year, npv) values ('7', '2019', '0')
DROP table Queries
insert into Queries (id, year) values ('1', '2019')
insert into Queries (id, year) values ('2', '2008')
insert into Queries (id, year) values ('3', '2009')
insert into Queries (id, year) values ('7', '2018')
insert into Queries (id, year) values ('7', '2019')
insert into Queries (id, year) values ('7', '2020')
insert into Queries (id, year) values ('13', '2019')
--

select 
	Q.id,
	Q.year,
	isnull(N.npv, 0) as npv
from Queries Q
left join NPV N on Q.id=N.id and Q.year=N.year



Create table Sessions (session_id int, duration int)
Truncate table Sessions
insert into Sessions (session_id, duration) values ('1', '30')
insert into Sessions (session_id, duration) values ('2', '199')
insert into Sessions (session_id, duration) values ('3', '299')
insert into Sessions (session_id, duration) values ('4', '580')
insert into Sessions (session_id, duration) values ('5', '1000')


with cte1 as (
	select
		session_id,
		duration,
		cast(duration * 1.00 / 60 as decimal(10,2)) as duration_mins
	from Sessions S
), cte2 as (
	select
		session_id,
		case when duration_mins >= 0 and duration_mins < 5 then '[0-5>'
			when duration_mins >= 5 and duration_mins < 10 then '[5-10>'
			when duration_mins >= 10 and duration_mins < 15 then '[10-15>'
			else '15 minutes or more' end as bin
	from cte1
)select * from cte2
select bin, count(1) as total from cte2 group by bin

select '[0-5>' as bin, count(1) as total from  Sessions S where duration >=0 and duration < 300
UNION
select '[5-10>' as bin, count(1) as total from  Sessions S where duration >=300 and duration < 600
UNION
select '[10-15>' as bin, count(1) as total from  Sessions S where duration >=600 and duration < 900
UNION
select '15 minutes or more' as bin, count(1) as total from  Sessions S where duration >=900




Create Table  Variables (name varchar(3), value int)
Create Table  Expressions (left_operand varchar(3), operator varchar(5), right_operand varchar(3))
Truncate table Variables
insert into Variables (name, value) values ('x', '66')
insert into Variables (name, value) values ('y', '77')
Truncate table Expressions
insert into Expressions (left_operand, operator, right_operand) values ('x', '>', 'y')
insert into Expressions (left_operand, operator, right_operand) values ('x', '<', 'y')
insert into Expressions (left_operand, operator, right_operand) values ('x', '=', 'y')
insert into Expressions (left_operand, operator, right_operand) values ('y', '>', 'x')
insert into Expressions (left_operand, operator, right_operand) values ('y', '<', 'x')
insert into Expressions (left_operand, operator, right_operand) values ('x', '=', 'x')

--

select
	E.left_operand,
	E.operator,
	E.right_operand,
	case when operator = '>' and (VL.value > VR.value) then 'true'
		when operator = '<' and (VL.value < VR.value) then 'true'
		when operator = '=' and (VL.value = VR.value) then 'true'
		else 'false' end as value
	--VL.value, VR.value
from Expressions E
left join Variables VL on E.left_operand=VL.name
left join Variables VR on E.right_operand=VR.name



Create table Sales (sale_date date, fruit varchar(50), sold_num int)
DROP table Sales
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-01', 'apples', '10')
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-01', 'oranges', '8')
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-02', 'apples', '15')
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-02', 'oranges', '15')
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-03', 'apples', '20')
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-03', 'oranges', '0')
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-04', 'apples', '15')
insert into Sales (sale_date, fruit, sold_num) values ('2020-05-04', 'oranges', '16')

with cte_apples as (
	select
		sale_date,
		sold_num
	from Sales S1
	where fruit = 'apples'
), cte_oranges as (
	select
		sale_date,
		sold_num
	from Sales S1
	where fruit = 'oranges'
), cte_sale_date as (
	select distinct sale_date
	from Sales
)
select 
	s.sale_date,
	a.sold_num - o.sold_num as diff
from cte_sale_date s
join cte_apples a on s.sale_date=a.sale_date
join cte_oranges o on s.sale_date=o.sale_date
order by s.sale_date

--

select 
	sale_date,
	sum(case when fruit='apples' then sold_num else -1 * sold_num end) as diff
from Sales
group by sale_date
order by 1

Create table Salaries (company_id int, employee_id int, employee_name varchar(13), salary int)
Truncate table Salaries
insert into Salaries (company_id, employee_id, employee_name, salary) values ('1', '1', 'Tony', '2000')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('1', '2', 'Pronub', '21300')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('1', '3', 'Tyrrox', '10800')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('2', '1', 'Pam', '300')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('2', '7', 'Bassem', '450')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('2', '9', 'Hermione', '700')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('3', '7', 'Bocaben', '100')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('3', '2', 'Ognjen', '2200')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('3', '13', 'Nyancat', '3300')
insert into Salaries (company_id, employee_id, employee_name, salary) values ('3', '15', 'Morninngcat', '7777')
--

with cte_tax_rate as (
	select
	company_id,
	case when max(salary) < 1000 then 0
		when max(salary) between 1000 and 10000 then 24
		else 49 end as tax_rate
	from Salaries 
	group by company_id
)
select 
	S.company_id,
	employee_id,
	employee_name,
	cast(ROUND(S.salary * 1.00 * (100 - tax_rate) / 100, 0) as integer) as salary
from Salaries S 
join cte_tax_rate C on S.company_id=C.company_id

Create table  Points (id int, x_value int, y_value int)
Truncate table Points
insert into Points (id, x_value, y_value) values ('1', '1', '6')
insert into Points (id, x_value, y_value) values ('2', '5', '3')
insert into Points (id, x_value, y_value) values ('3', '3', '6')
--
select * from Points
select * from (
select
	P1.id as P1,
	P2.id as P2,
	ABS(p2.x_value - p1.x_value) * ABS(p2.y_value - p1.y_value) as AREA
from Points P1
join Points P2 on p1.id<P2.id
and p1.x_value != p2.x_value
or p2.y_value != p2.y_value
) sq
where AREA !=0
order by 3 desc, 1 , 2

select
	P1.*,
	P2.*
from Points P1
join Points P2 on p1.id<P2.id

select datename(weekday, getdate())
/* Write your T-SQL query statement below */
with cte2 as 
(
	select
		item_id,datename(weekday, order_date) as week_day, sum(quantity) as total_quantity
	from Orders
	group by item_id, datename(weekday, order_date)
) , cte3 as 
(
select
	i.item_category as Category,c.week_day,sum(c.total_quantity) as total_quantity
from items i
left join cte2 c on c.item_id = i.item_id
group by i.item_category, c.week_day
)
select  
	Category,
	SUM(case when week_day='Monday' then total_quantity else 0 end)  as 'Monday',
	SUM(case when week_day='Tuesday' then total_quantity else 0 end)  as 'Tuesday',
	SUM(case when week_day='Wednesday' then total_quantity else 0 end)  as 'Wednesday',
	SUM(case when week_day='Thursday' then total_quantity else 0 end)  as 'Thursday',
	SUM(case when week_day='Friday' then total_quantity else 0 end)  as 'Friday',
	SUM(case when week_day='Saturday' then total_quantity else 0 end)  as 'Saturday',
	SUM(case when week_day='Sunday' then total_quantity else 0 end)  as 'Sunday'
from  cte3
group by category
order by Category

--
Create table  Activities (sell_date date, product varchar(20))
DROP table Activities
insert into Activities (sell_date, product) values ('2020-05-30', 'Headphone')
insert into Activities (sell_date, product) values ('2020-06-01', 'Pencil')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'Basketball')
insert into Activities (sell_date, product) values ('2020-06-01', 'Bible')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'T-Shirt')
--

with cte1 as 
	(select distinct * 
	from Activities
), cte2 as (
	select
		sell_date,
		count(distinct product) as num_sold,
		STRING_AGG(product, ',') within group (order by product asc)  as products
	from cte1
	group by sell_date
) select * from cte2


Create table TVProgram (program_date date, content_id int, channel varchar(30))
Create table Content (content_id varchar(30), title varchar(30), Kids_content varchar(10), content_type varchar(30))
Truncate table TVProgram
insert into TVProgram (program_date, content_id, channel) values ('2020-06-10 08:00', '1', 'LC-Channel')
insert into TVProgram (program_date, content_id, channel) values ('2020-05-11 12:00', '2', 'LC-Channel')
insert into TVProgram (program_date, content_id, channel) values ('2020-05-12 12:00', '3', 'LC-Channel')
insert into TVProgram (program_date, content_id, channel) values ('2020-05-13 14:00', '4', 'Disney Ch')
insert into TVProgram (program_date, content_id, channel) values ('2020-06-18 14:00', '4', 'Disney Ch')
insert into TVProgram (program_date, content_id, channel) values ('2020-07-15 16:00', '5', 'Disney Ch')
Truncate table Content
insert into Content (content_id, title, Kids_content, content_type) values ('1', 'Leetcode Movie', 'N', 'Movies')
insert into Content (content_id, title, Kids_content, content_type) values ('2', 'Alg. for Kids', 'Y', 'Series')
insert into Content (content_id, title, Kids_content, content_type) values ('3', 'Database Sols', 'N', 'Series')
insert into Content (content_id, title, Kids_content, content_type) values ('4', 'Aladdin', 'Y', 'Movies')
insert into Content (content_id, title, Kids_content, content_type) values ('5', 'Cinderella', 'Y', 'Movies')
--

select 
	distinct title
from TVProgram T
join (
	select
		content_id,
		title
	from Content
	where Kids_content='Y' and content_type='Movies'
) C on cast(T.content_id as varchar(30)) = C.content_id
where program_date between '2020-06-01' and '2020-06-30'

Create table  Person (id int, name varchar(15), phone_number varchar(11))
Create table  Country (name varchar(15), country_code varchar(3))
Create table  Calls (caller_id int, callee_id int, duration int)
DROP table Person
insert into Person (id, name, phone_number) values ('3', 'Jonathan', '051-1234567')
insert into Person (id, name, phone_number) values ('12', 'Elvis', '051-7654321')
insert into Person (id, name, phone_number) values ('1', 'Moncef', '212-1234567')
insert into Person (id, name, phone_number) values ('2', 'Maroua', '212-6523651')
insert into Person (id, name, phone_number) values ('7', 'Meir', '972-1234567')
insert into Person (id, name, phone_number) values ('9', 'Rachel', '972-0011100')
Truncate table Country
insert into Country (name, country_code) values ('Peru', '051')
insert into Country (name, country_code) values ('Israel', '972')
insert into Country (name, country_code) values ('Morocco', '212')
insert into Country (name, country_code) values ('Germany', '049')
insert into Country (name, country_code) values ('Ethiopia', '251')
Truncate table Calls
insert into Calls (caller_id, callee_id, duration) values ('1', '9', '33')
insert into Calls (caller_id, callee_id, duration) values ('2', '9', '4')
insert into Calls (caller_id, callee_id, duration) values ('1', '2', '59')
insert into Calls (caller_id, callee_id, duration) values ('3', '12', '102')
insert into Calls (caller_id, callee_id, duration) values ('3', '12', '330')
insert into Calls (caller_id, callee_id, duration) values ('12', '3', '5')
insert into Calls (caller_id, callee_id, duration) values ('7', '9', '13')
insert into Calls (caller_id, callee_id, duration) values ('7', '1', '3')
insert into Calls (caller_id, callee_id, duration) values ('9', '7', '1')
insert into Calls (caller_id, callee_id, duration) values ('1', '7', '7')
--
with cte1 as (
	select
		P.id,
		C.name as country_name
	from Person P
	left join Country C on substring(P.phone_number, 1 , 3) = C.country_code
), cte2 as (
	select
		a.country_name,
		sum(duration) as call_duration,
		count(caller_id) as total_callers
	from Calls cr
	left join cte1 a on a.id = cr.caller_id
	group by a.country_name
	UNION ALL
	select
		b.country_name,
		sum(duration) as call_duration,
		count(caller_id) as total_callers
	from Calls cr
	left join cte1 b on b.id = cr.callee_id
	group by b.country_name
)
select 
	country_name as country
	--sum(call_duration * 1.00) / sum(total_callers) as avg
from cte2
group by country_name
having (sum(call_duration * 1.00) / sum(total_callers)) > (select avg(duration * 1.00) from Calls)

Create table  Customers (customer_id int, name varchar(30), country varchar(30))
Create table  Product (product_id int, description varchar(30), price int)
Create table  Orders (order_id int, customer_id int, product_id int, order_date date, quantity int)
DROP table Customers
insert into Customers (customer_id, name, country) values ('1', 'Winston', 'USA')
insert into Customers (customer_id, name, country) values ('2', 'Jonathan', 'Peru')
insert into Customers (customer_id, name, country) values ('3', 'Moustafa', 'Egypt')
DROP table Product
insert into Product (product_id, description, price) values ('10', 'LC Phone', '300')
insert into Product (product_id, description, price) values ('20', 'LC T-Shirt', '10')
insert into Product (product_id, description, price) values ('30', 'LC Book', '45')
insert into Product (product_id, description, price) values ('40', 'LC Keychain', '2')
DROP table Orders
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values ('1', '1', '10', '2020-06-10', '1')
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values ('2', '1', '20', '2020-07-01', '1')
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values ('3', '1', '30', '2020-07-08', '2')
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values ('4', '2', '10', '2020-06-15', '2')
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values ('5', '2', '40', '2020-07-01', '10')
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values ('6', '3', '20', '2020-06-24', '2')
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values ('7', '3', '30', '2020-06-25', '2')
insert into Orders (order_id, customer_id, product_id, order_date, quantity) values ('9', '3', '30', '2020-05-08', '3')
--

with cte as (
	select 
		O.customer_id,
		month(order_date) as order_month,
		year(order_date) as order_year,
		sum(price*quantity) as sales
	from Orders O
	join product P on O.product_id=p.product_id
	where order_date between '2020-06-01' and '2020-07-31'
	group by O.customer_id, month(order_date), year(order_date)
)
select 
	c.customer_id,
	cust.name
from cte c 
join customers cust on c.customer_id=cust.customer_id
where (order_year = 2020 and sales >=100 and order_month in (6,7))
group by c.customer_id, cust.name
having count(1) >= 2

Create table Users (user_id int, name varchar(30), mail varchar(50))
DROP table Users
insert into Users (user_id, name, mail) values ('1', 'Winston', 'winston@leetcode.com')
insert into Users (user_id, name, mail) values ('2', 'Jonathan', 'jonathanisgreat')
insert into Users (user_id, name, mail) values ('3', 'Annabelle', 'bella-@leetcode.com')
insert into Users (user_id, name, mail) values ('4', 'Sally', 'sally.come@leetcode.com')
insert into Users (user_id, name, mail) values ('5', 'Marwan', 'quarz#2020@leetcode.com')
insert into Users (user_id, name, mail) values ('6', 'David', 'david69@gmail.com')
insert into Users (user_id, name, mail) values ('7', 'Shapiro', '.shapo@leetcode.com')
--

select
	user_id,
	name,
	mail
from Users
where	mail like '[a-zA-Z]%@leetcode.com'
	and left(mail, len(mail) - 13) not like '%[^a-zA-Z0-9._-]%'


Create table Patients (patient_id int, patient_name varchar(30), conditions varchar(100))
Truncate table Patients
insert into Patients (patient_id, patient_name, conditions) values ('1', 'Daniel', 'YFEV COUGH')
insert into Patients (patient_id, patient_name, conditions) values ('2', 'Alice', '')
insert into Patients (patient_id, patient_name, conditions) values ('3', 'Bob', 'DIAB100 MYOP')
insert into Patients (patient_id, patient_name, conditions) values ('4', 'George', 'ACNE DIAB100')
insert into Patients (patient_id, patient_name, conditions) values ('5', 'Alain', 'DIAB201')
--

select
	*
from Patients
where	conditions  like 'DIAB1%' 
	or	conditions  like '%[ ]DIAB1[ ]%' 
	or	conditions  like '%[ ]DIAB1%'

Create table  Customers (customer_id int, name varchar(10))
Create table  Orders (order_id int, order_date date, customer_id int, cost int)
DROP table Customers
insert into Customers (customer_id, name) values ('1', 'Winston')
insert into Customers (customer_id, name) values ('2', 'Jonathan')
insert into Customers (customer_id, name) values ('3', 'Annabelle')
insert into Customers (customer_id, name) values ('4', 'Marwan')
insert into Customers (customer_id, name) values ('5', 'Khaled')
DROP table Orders
insert into Orders (order_id, order_date, customer_id, cost) values ('1', '2020-07-31', '1', '30')
insert into Orders (order_id, order_date, customer_id, cost) values ('2', '2020-7-30', '2', '40')
insert into Orders (order_id, order_date, customer_id, cost) values ('3', '2020-07-31', '3', '70')
insert into Orders (order_id, order_date, customer_id, cost) values ('4', '2020-07-29', '4', '100')
insert into Orders (order_id, order_date, customer_id, cost) values ('5', '2020-06-10', '1', '1010')
insert into Orders (order_id, order_date, customer_id, cost) values ('6', '2020-08-01', '2', '102')
insert into Orders (order_id, order_date, customer_id, cost) values ('7', '2020-08-01', '3', '111')
insert into Orders (order_id, order_date, customer_id, cost) values ('8', '2020-08-03', '1', '99')
insert into Orders (order_id, order_date, customer_id, cost) values ('9', '2020-08-07', '2', '32')
insert into Orders (order_id, order_date, customer_id, cost) values ('10', '2020-07-15', '1', '2')
--

with cte_order as (
	select
		name as customer_name,
		O.customer_id,
		order_id,
		order_date,
		ROW_NUMBER() over (partition by O.customer_id order by order_date desc) rn
	from Orders O
	join Customers c on o.customer_id=c.customer_id
)
select
	customer_name, ct.customer_id, order_id, order_date
from cte_order ct
where rn <= 3
order by customer_name, ct.customer_id, order_date desc
--
Create table Sales (sale_id int, product_name varchar(30), sale_date date)
DROP table Sales
insert into Sales (sale_id, product_name, sale_date) values ('1', 'LCPHONE', '2000-01-16')
insert into Sales (sale_id, product_name, sale_date) values ('2', 'LCPhone', '2000-01-17')
insert into Sales (sale_id, product_name, sale_date) values ('3', 'LcPhOnE', '2000-02-18')
insert into Sales (sale_id, product_name, sale_date) values ('4', 'LCKeyCHAiN', '2000-02-19')
insert into Sales (sale_id, product_name, sale_date) values ('5', 'LCKeyChain', '2000-02-28')
insert into Sales (sale_id, product_name, sale_date) values ('6', 'Matryoshka', '2000-03-31')
---

select 
	product_name,
	sale_date,
	count(1) as total
from
(
	select
		sale_id,
		trim(lower(product_name)) as product_name,
		format(sale_date, 'yyyy-MM') as sale_date
	from Sales
) sq group by product_name, sale_date
	order by product_name, sale_date

	-- OR
with cte as 
(
	select
		sale_id,
		trim(lower(product_name)) as product_name,
		format(sale_date, 'yyyy-MM') as sale_date
	from Sales
)
select 
	product_name,
	sale_date,
	count(1) as total
from cte group by product_name, sale_date
	order by product_name, sale_date

Create table  Customers (customer_id int, name varchar(10))
Create table  Orders (order_id int, order_date date, customer_id int, product_id int)
Create table  Products (product_id int, product_name varchar(20), price int)
DROP table Customers
insert into Customers (customer_id, name) values ('1', 'Winston')
insert into Customers (customer_id, name) values ('2', 'Jonathan')
insert into Customers (customer_id, name) values ('3', 'Annabelle')
insert into Customers (customer_id, name) values ('4', 'Marwan')
insert into Customers (customer_id, name) values ('5', 'Khaled')
DROP table Orders
insert into Orders (order_id, order_date, customer_id, product_id) values ('1', '2020-07-31', '1', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('2', '2020-7-30', '2', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('3', '2020-08-29', '3', '3')
insert into Orders (order_id, order_date, customer_id, product_id) values ('4', '2020-07-29', '4', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('5', '2020-06-10', '1', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('6', '2020-08-01', '2', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('7', '2020-08-01', '3', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('8', '2020-08-03', '1', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('9', '2020-08-07', '2', '3')
insert into Orders (order_id, order_date, customer_id, product_id) values ('10', '2020-07-15', '1', '2')
DROP table Products
insert into Products (product_id, product_name, price) values ('1', 'keyboard', '120')
insert into Products (product_id, product_name, price) values ('2', 'mouse', '80')
insert into Products (product_id, product_name, price) values ('3', 'screen', '600')
insert into Products (product_id, product_name, price) values ('4', 'hard disk', '450')
--
with cte_orders as 
(
	select
		o.product_id,
		o.order_id,
		o.order_date,
		dense_rank() over(partition by o.product_id order by order_date desc) rn
	from Orders O
)
select
	p.product_name,
	o.product_id,
	order_id,
	order_date
from cte_orders o
join Products P on o.product_id=p.product_id
where rn = 1
order by p.product_name, o.product_id, o.order_id 

Create table  Users (user_id int, user_name varchar(20), credit int)
Create table  Transactions (trans_id int, paid_by int, paid_to int, amount int, transacted_on date)
DROP table Users
insert into Users (user_id, user_name, credit) values ('1', 'Moustafa', '100')
insert into Users (user_id, user_name, credit) values ('2', 'Jonathan', '200')
insert into Users (user_id, user_name, credit) values ('3', 'Winston', '10000')
insert into Users (user_id, user_name, credit) values ('4', 'Luis', '800')
DROP table Transactions
insert into Transactions (trans_id, paid_by, paid_to, amount, transacted_on) values ('1', '1', '3', '400', '2020-08-01')
insert into Transactions (trans_id, paid_by, paid_to, amount, transacted_on) values ('2', '3', '2', '500', '2020-08-02')
insert into Transactions (trans_id, paid_by, paid_to, amount, transacted_on) values ('3', '2', '1', '200', '2020-08-03')
--
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

Create table Orders (order_id int, order_date date, customer_id int, invoice int)
DROP table Orders
insert into Orders (order_id, order_date, customer_id, invoice) values ('1', '2020-09-15', '1', '30')
insert into Orders (order_id, order_date, customer_id, invoice) values ('2', '2020-09-17', '2', '90')
insert into Orders (order_id, order_date, customer_id, invoice) values ('3', '2020-10-06', '3', '20')
insert into Orders (order_id, order_date, customer_id, invoice) values ('4', '2020-10-20', '3', '21')
insert into Orders (order_id, order_date, customer_id, invoice) values ('5', '2020-11-10', '1', '10')
insert into Orders (order_id, order_date, customer_id, invoice) values ('6', '2020-11-21', '2', '15')
insert into Orders (order_id, order_date, customer_id, invoice) values ('7', '2020-12-01', '4', '55')
insert into Orders (order_id, order_date, customer_id, invoice) values ('8', '2020-12-03', '4', '77')
insert into Orders (order_id, order_date, customer_id, invoice) values ('9', '2021-01-07', '3', '31')
insert into Orders (order_id, order_date, customer_id, invoice) values ('10', '2021-01-15', '2', '20')

--

select 
	format(order_date, 'yyyy-MM') as month,
	count(distinct order_id) as order_count,
	count(distinct customer_id) as customer_count
from Orders
where invoice > 20
group by format(order_date, 'yyyy-MM')

Create table  Warehouse (name varchar(50), product_id int, units int)
Create table  Products (product_id int, product_name varchar(50), Width int,Length int,Height int)
Truncate table Warehouse
insert into Warehouse (name, product_id, units) values ('LCHouse1', '1', '1')
insert into Warehouse (name, product_id, units) values ('LCHouse1', '2', '10')
insert into Warehouse (name, product_id, units) values ('LCHouse1', '3', '5')
insert into Warehouse (name, product_id, units) values ('LCHouse2', '1', '2')
insert into Warehouse (name, product_id, units) values ('LCHouse2', '2', '2')
insert into Warehouse (name, product_id, units) values ('LCHouse3', '4', '1')
DROP table Products
insert into Products (product_id, product_name, Width, Length, Height) values ('1', 'LC-TV', '5', '50', '40')
insert into Products (product_id, product_name, Width, Length, Height) values ('2', 'LC-KeyChain', '5', '5', '5')
insert into Products (product_id, product_name, Width, Length, Height) values ('3', 'LC-Phone', '2', '10', '10')
insert into Products (product_id, product_name, Width, Length, Height) values ('4', 'LC-T-Shirt', '4', '10', '20')
--

select 
	name as warehouse_name,
	SUM(units * sq.volume) as volume
from Warehouse w join 
(
	select
		product_id,
		product_name,
		(width * length * height) as volume
	from Products
) sq on w.product_id= sq.product_id
group by name

Create table  Visits(visit_id int, customer_id int)
Create table  Transactions(transaction_id int, visit_id int, amount int)
Truncate table Visits
insert into Visits (visit_id, customer_id) values ('1', '23')
insert into Visits (visit_id, customer_id) values ('2', '9')
insert into Visits (visit_id, customer_id) values ('4', '30')
insert into Visits (visit_id, customer_id) values ('5', '54')
insert into Visits (visit_id, customer_id) values ('6', '96')
insert into Visits (visit_id, customer_id) values ('7', '54')
insert into Visits (visit_id, customer_id) values ('8', '54')
DROP table Transactions
insert into Transactions (transaction_id, visit_id, amount) values ('2', '5', '310')
insert into Transactions (transaction_id, visit_id, amount) values ('3', '5', '300')
insert into Transactions (transaction_id, visit_id, amount) values ('9', '5', '200')
insert into Transactions (transaction_id, visit_id, amount) values ('12', '1', '910')
insert into Transactions (transaction_id, visit_id, amount) values ('13', '2', '970')
--
with cte as (
select
	V.visit_id,
	customer_id,
	transaction_id
from Visits V
left join Transactions T on V.visit_id=T.visit_id
)
select customer_id, count(1) as count_no_trans
from cte 
where transaction_id is null
group by customer_id
order by 2 desc


Create table Users (account int, name varchar(20))
Create table  Transactions (trans_id int, account int, amount int, transacted_on date)
DROP table Users
insert into Users (account, name) values ('900001', 'Alice')
insert into Users (account, name) values ('900002', 'Bob')
insert into Users (account, name) values ('900003', 'Charlie')
DROP table Transactions
insert into Transactions (trans_id, account, amount, transacted_on) values ('1', '900001', '7000', '2020-08-01')
insert into Transactions (trans_id, account, amount, transacted_on) values ('2', '900001', '7000', '2020-09-01')
insert into Transactions (trans_id, account, amount, transacted_on) values ('3', '900001', '-3000', '2020-09-02')
insert into Transactions (trans_id, account, amount, transacted_on) values ('4', '900002', '1000', '2020-09-12')
insert into Transactions (trans_id, account, amount, transacted_on) values ('5', '900003', '6000', '2020-08-07')
insert into Transactions (trans_id, account, amount, transacted_on) values ('6', '900003', '6000', '2020-09-07')
insert into Transactions (trans_id, account, amount, transacted_on) values ('7', '900003', '-4000', '2020-09-11')

--

select 
	name,
	sum(amount) as balance
from [transactions] T 
join Users A on T.account=A.account
group by name
having sum(amount) > 10000

--
Create table Customers (customer_id int, name varchar(10))
Create table Orders (order_id int, order_date date, customer_id int, product_id int)
Create table Products (product_id int, product_name varchar(20), price int)
DROP table Customers
insert into Customers (customer_id, name) values ('1', 'Alice')
insert into Customers (customer_id, name) values ('2', 'Bob')
insert into Customers (customer_id, name) values ('3', 'Tom')
insert into Customers (customer_id, name) values ('4', 'Jerry')
insert into Customers (customer_id, name) values ('5', 'John')
DROP table Orders
insert into Orders (order_id, order_date, customer_id, product_id) values ('1', '2020-07-31', '1', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('2', '2020-7-30', '2', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('3', '2020-08-29', '3', '3')
insert into Orders (order_id, order_date, customer_id, product_id) values ('4', '2020-07-29', '4', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('5', '2020-06-10', '1', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('6', '2020-08-01', '2', '1')
insert into Orders (order_id, order_date, customer_id, product_id) values ('7', '2020-08-01', '3', '3')
insert into Orders (order_id, order_date, customer_id, product_id) values ('8', '2020-08-03', '1', '2')
insert into Orders (order_id, order_date, customer_id, product_id) values ('9', '2020-08-07', '2', '3')
insert into Orders (order_id, order_date, customer_id, product_id) values ('10', '2020-07-15', '1', '2')
DROP table Products
insert into Products (product_id, product_name, price) values ('1', 'keyboard', '120')
insert into Products (product_id, product_name, price) values ('2', 'mouse', '80')
insert into Products (product_id, product_name, price) values ('3', 'screen', '600')
insert into Products (product_id, product_name, price) values ('4', 'hard disk', '450')
--
with cte1 as (
	select
		customer_id,
		product_id,
		count(1) as prod_order_count
	from Orders O
	group by customer_id, product_id
), cte2 as (
	select cte1.customer_id,
			cte1.product_id,
			P.product_name,
			DENSE_RANK() over (partition by  cte1.customer_id order by prod_order_count desc) as rn
	from cte1
	left join products P on cte1.product_id=P.product_id
	left join Customers C on cte1.customer_id=C.customer_id
)
select 
	customer_id,
	product_id,
	product_name
from cte2
where rn = 1

Create table Customer (customer_id int, customer_name varchar(20))
Create table Orders (order_id int, sale_date date, order_cost int, customer_id int, seller_id int)
Create table Seller (seller_id int, seller_name varchar(20))
DROP table Customer
insert into Customer (customer_id, customer_name) values ('101', 'Alice')
insert into Customer (customer_id, customer_name) values ('102', 'Bob')
insert into Customer (customer_id, customer_name) values ('103', 'Charlie')
DROP table Orders
insert into Orders (order_id, sale_date, order_cost, customer_id, seller_id) values ('1', '2020-03-01', '1500', '101', '1')
insert into Orders (order_id, sale_date, order_cost, customer_id, seller_id) values ('2', '2020-05-25', '2400', '102', '2')
insert into Orders (order_id, sale_date, order_cost, customer_id, seller_id) values ('3', '2019-05-25', '800', '101', '3')
insert into Orders (order_id, sale_date, order_cost, customer_id, seller_id) values ('4', '2020-09-13', '1000', '103', '2')
insert into Orders (order_id, sale_date, order_cost, customer_id, seller_id) values ('5', '2019-02-11', '700', '101', '2')
Truncate table Seller
insert into Seller (seller_id, seller_name) values ('1', 'Daniel')
insert into Seller (seller_id, seller_name) values ('2', 'Elizabeth')
insert into Seller (seller_id, seller_name) values ('3', 'Frank')
--

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

Create table  Customers (customer_id int, customer_name varchar(20))
DROP table Customers
delete from customers where customer_id = 1
insert into Customers (customer_id, customer_name) values ('2', 'Alice')
insert into Customers (customer_id, customer_name) values ('4', 'Bob')
insert into Customers (customer_id, customer_name) values ('5', 'Charlie')
--
select * from customers;

with cte1 as (
	select
		max(customer_id) as maxid
	from Customers
), cte2 as 
(
	select 1 as ids
	UNION all
	select ids + 1 from cte2 where ids < (select maxid from cte1)
)
select ids from cte2 where ids not in (select customer_id from Customers)
order by 1

Create table SchoolA (student_id int, student_name varchar(20))
Create table SchoolB (student_id int, student_name varchar(20))
Create table SchoolC (student_id int, student_name varchar(20))
Truncate table SchoolA
insert into SchoolA (student_id, student_name) values ('1', 'Alice')
insert into SchoolA (student_id, student_name) values ('2', 'Bob')
Truncate table SchoolB
insert into SchoolB (student_id, student_name) values ('3', 'Tom')
Truncate table SchoolC
insert into SchoolC (student_id, student_name) values ('3', 'Tom')
insert into SchoolC (student_id, student_name) values ('2', 'Jerry')
insert into SchoolC (student_id, student_name) values ('10', 'Alice')
--

select
	A.student_name as member_A,
	B.student_name as member_B,
	C.student_name as member_C
from SchoolA A
cross join SchoolB B
cross join SchoolC C
where (A.student_id <> B.student_id and B.student_id <> C.student_id and C.student_id <> A.student_id)
and (A.student_name <> B.student_name and B.student_name <> C.student_name and C.student_name <> A.student_name)


Create table Users (user_id int, user_name varchar(20))
Create table Register (contest_id int, user_id int)
DROP table Users
insert into Users (user_id, user_name) values ('6', 'Alice')
insert into Users (user_id, user_name) values ('2', 'Bob')
insert into Users (user_id, user_name) values ('7', 'Alex')
Truncate table Register
insert into Register (contest_id, user_id) values ('215', '6')
insert into Register (contest_id, user_id) values ('209', '2')
insert into Register (contest_id, user_id) values ('208', '2')
insert into Register (contest_id, user_id) values ('210', '6')
insert into Register (contest_id, user_id) values ('208', '6')
insert into Register (contest_id, user_id) values ('209', '7')
insert into Register (contest_id, user_id) values ('209', '6')
insert into Register (contest_id, user_id) values ('215', '7')
insert into Register (contest_id, user_id) values ('208', '7')
insert into Register (contest_id, user_id) values ('210', '2')
insert into Register (contest_id, user_id) values ('207', '2')
insert into Register (contest_id, user_id) values ('210', '7')
--


select
	contest_id,
	cast(ROUND((count(distinct user_id) * 1.00 * 100 / (select count(1) from Users)), 2) as decimal(5,2)) as percentage
from Register R
group by contest_id
order by 2 desc, 1 asc

Create table Drivers (driver_id int, join_date date)
Create table Rides (ride_id int, user_id int, requested_at date)
Create table AcceptedRides (ride_id int, driver_id int, ride_distance int, ride_duration int)
Truncate table Drivers
insert into Drivers (driver_id, join_date) values ('10', '2019-12-10')
insert into Drivers (driver_id, join_date) values ('8', '2020-1-13')
insert into Drivers (driver_id, join_date) values ('5', '2020-2-16')
insert into Drivers (driver_id, join_date) values ('7', '2020-3-8')
insert into Drivers (driver_id, join_date) values ('4', '2020-5-17')
insert into Drivers (driver_id, join_date) values ('1', '2020-10-24')
insert into Drivers (driver_id, join_date) values ('6', '2021-1-5')
DROP table Rides
insert into Rides (ride_id, user_id, requested_at) values ('6', '75', '2019-12-9')
insert into Rides (ride_id, user_id, requested_at) values ('1', '54', '2020-2-9')
insert into Rides (ride_id, user_id, requested_at) values ('10', '63', '2020-3-4')
insert into Rides (ride_id, user_id, requested_at) values ('19', '39', '2020-4-6')
insert into Rides (ride_id, user_id, requested_at) values ('3', '41', '2020-6-3')
insert into Rides (ride_id, user_id, requested_at) values ('13', '52', '2020-6-22')
insert into Rides (ride_id, user_id, requested_at) values ('7', '69', '2020-7-16')
insert into Rides (ride_id, user_id, requested_at) values ('17', '70', '2020-8-25')
insert into Rides (ride_id, user_id, requested_at) values ('20', '81', '2020-11-2')
insert into Rides (ride_id, user_id, requested_at) values ('5', '57', '2020-11-9')
insert into Rides (ride_id, user_id, requested_at) values ('2', '42', '2020-12-9')
insert into Rides (ride_id, user_id, requested_at) values ('11', '68', '2021-1-11')
insert into Rides (ride_id, user_id, requested_at) values ('15', '32', '2021-1-17')
insert into Rides (ride_id, user_id, requested_at) values ('12', '11', '2021-1-19')
insert into Rides (ride_id, user_id, requested_at) values ('14', '18', '2021-1-27')
Truncate table AcceptedRides
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('10', '10', '63', '38')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('13', '10', '73', '96')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('7', '8', '100', '28')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('17', '7', '119', '68')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('20', '1', '121', '92')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('5', '7', '42', '101')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('2', '4', '6', '38')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('11', '8', '37', '43')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('15', '8', '108', '82')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('12', '8', '38', '34')
insert into AcceptedRides (ride_id, driver_id, ride_distance, ride_duration) values ('14', '1', '90', '74')
--

-- create a table for all the months
with cte_month as (
	select
		1 as [month]
	UNION ALL
	select
		[month] + 1
	from cte_month
	where [month] < 12
),
-- get all the drivers or or before 2020
cte_driver as (
	select
		driver_id,
		case when year(join_date) < 2020 then 1 else month(join_date) end as month 	
	from drivers d
	where year(join_date) <= 2020
),
-- get all active drivers -- byp passing null drivers for any month not present
cte_driver_cnt as (
	select distinct
		c1.month,
		count(c2.driver_id) over(order by c1.month) as active_drivers
	from cte_month c1 left join cte_driver c2 on c1.month = c2.month
),
-- gett accepted rides (exclusive of month with no rides)
cte_accepted_rides as (
	select
		month(r.requested_at) as [month],
		count(1) as accepted_rides
	from AcceptedRides  AR
	join Rides R on AR.ride_id=R.ride_id
	where year(R.requested_at) = 2020 and month(R.requested_at) between 1 and 12
	group by month(r.requested_at)
)
select
	dc.[month],
	dc.active_drivers,
	isnull(accepted_rides, 0) as accepted_rides 
from cte_driver_cnt dc
left join cte_accepted_rides ar on dc.month=ar.month
order by dc.month

-- 
--ii
-- create a table for all the months
with cte_month as (
	select
		1 as [month]
	UNION ALL
	select
		[month] + 1
	from cte_month
	where [month] < 12
),
-- get all the drivers or or before 2020
cte_driver as (
	select
		driver_id,
		case when year(join_date) < 2020 then 1 else month(join_date) end as month 	
	from drivers d
	where year(join_date) <= 2020
),
-- get all active drivers -- byp passing null drivers for any month not present
cte_driver_cnt as (
	select distinct
		c1.month,
		count(c2.driver_id) over(order by c1.month) as active_drivers
	from cte_month c1 left join cte_driver c2 on c1.month = c2.month
), 
-- get drivers count with atleast 1 ride in that month
cte_accepted_rides as (
	select 
		month(r.requested_at) as [month],
			count(distinct driver_id) as accepted_rides
		from AcceptedRides  AR
		join Rides R on AR.ride_id=R.ride_id
		where year(R.requested_at) = 2020 and month(R.requested_at) between 1 and 12
		group by month(r.requested_at)
)
select
	dc.[month],
	case when active_drivers = 0 then 0.00 
		else cast(ROUND((isnull(accepted_rides, 0) * 1.00 / active_drivers) * 100, 2) as decimal(5,2)) 
	end as working_percentage 
from cte_driver_cnt dc
left join cte_accepted_rides ar on dc.month=ar.month
order by dc.month

select * from Rides
---
-- create a table for all the months
with cte_month as (
	select
		1 as [month]
	UNION ALL
	select
		[month] + 1
	from cte_month
	where [month] < 12
), cte_ride_grp as (
	select 
		month(r.requested_at) as [month],
		isnull(SUM(ride_distance), 0) as ride_distance,
		isnull(sum(ride_duration), 0) as ride_duration
	from AcceptedRides  AR
	join Rides R on AR.ride_id=R.ride_id
	where year(R.requested_at) = 2020 and month(R.requested_at) between 1 and 12
	group by month(r.requested_at)
), cte_1 as (
	select
		c1.[month],
		isnull(ride_distance, 0) as ride_distance,
		isnull(ride_duration, 0) as ride_duration
	from cte_month c1
	left join cte_ride_grp c2 on c1.month=c2.month
), cte_rolling_avg as (
	select month,
		cast(round((sum(ride_distance) over (order by month rows between current row and 2 following) * 1.00 / 3), 2) as decimal(28,2)) as average_ride_distance,
		cast(round((sum(ride_duration) over (order by month rows between current row and 2 following) * 1.00 / 3), 2) as decimal(28,2)) as average_ride_duration  
	from cte_1
)
select
	*
from cte_rolling_avg
where month <= 10
order by 1

Create table Activity (machine_id int, process_id int, activity_type varchar(20), timestamp float)
DROP table Activity
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '0', 'start', '0.712')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '0', 'end', '1.52')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '1', 'start', '3.14')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('0', '1', 'end', '4.12')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '0', 'start', '0.55')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '0', 'end', '1.55')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '1', 'start', '0.43')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('1', '1', 'end', '1.42')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '0', 'start', '4.1')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '0', 'end', '4.512')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '1', 'start', '2.5')
insert into Activity (machine_id, process_id, activity_type, timestamp) values ('2', '1', 'end', '5')
--

with cte as (
	select
		AStart.machine_id,
		AStart.process_id,
		AStart.timestamp as timestamp_start,
		AEnd.timestamp as timestamp_end,
		AEnd.timestamp - AStart.timestamp as processing_time 
	from Activity AStart
	inner join Activity AEnd on AStart.machine_id=AEnd.machine_id and AStart.process_id=AEnd.process_id and AStart.activity_type<>AEnd.activity_type and AStart.timestamp<AEnd.timestamp
)
select
	machine_id,
	cast(ROUND(SUM(processing_time) * 1.00 / count(process_id), 3) as decimal(5, 3)) as processing_time 
from cte
group by machine_id

--

Create table Users (user_id int, name varchar(40))
DROP table Users
insert into Users (user_id, name) values ('1', 'aLice')
insert into Users (user_id, name) values ('2', 'bOB')
--

select
	user_id,
	upper(LEFT(name, 1)) + lower(right(name, LEN(name) - 1)) as name
from Users
order by user_id

--

Create table  Product(product_id int, name varchar(15))
Create table  Invoice(invoice_id int,product_id int,rest int, paid int, canceled int, refunded int)
DROP table Product
insert into Product (product_id, name) values ('0', 'ham')
insert into Product (product_id, name) values ('1', 'bacon')
insert into Product (product_id, name) values ('1', 'bacon')
Truncate table Invoice
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('23', '0', '2', '0', '5', '0')
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('12', '0', '0', '4', '0', '3')
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('1', '1', '1', '1', '0', '1')
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('2', '1', '1', '0', '1', '1')
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('3', '1', '0', '1', '1', '1')
insert into Invoice (invoice_id, product_id, rest, paid, canceled, refunded) values ('4', '1', '1', '1', '1', '0')

--

select
	p.name,
	isnull(sum(rest), 0) as rest,
	isnull(sum(paid), 0) as paid,
	isnull(sum(canceled), 0) as canceled,
	isnull(sum(refunded), 0) as refunded
from Product P
left join Invoice I  on I.product_id=P.product_id
group by p.name
order by name


select
	p.name,
	isnull(sum(rest), 0) as rest,
	isnull(sum(paid), 0) as paid,
	isnull(sum(canceled), 0) as canceled,
	isnull(sum(refunded), 0) as refunded
from Product P
left join Invoice I  on I.product_id=P.product_id
group by p.name
order by name

---

Create table  Tweets(tweet_id int, content varchar(50))
Truncate table Tweets
insert into Tweets (tweet_id, content) values ('1', 'Vote for Biden')
insert into Tweets (tweet_id, content) values ('2', 'Let us make America great again!')
--

select
	tweet_id
from Tweets
where len(content) >= 15

--

Create table DailySales(date_id date, make_name varchar(20), lead_id int, partner_id int)
Truncate table DailySales
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'toyota', '0', '1')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'toyota', '1', '0')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'toyota', '1', '2')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'toyota', '0', '2')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'toyota', '0', '1')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'honda', '1', '2')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-8', 'honda', '2', '1')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'honda', '0', '1')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'honda', '1', '2')
insert into DailySales (date_id, make_name, lead_id, partner_id) values ('2020-12-7', 'honda', '2', '1')
--

select
	date_id,
	make_name,
	count(distinct lead_id) as unique_leads,
	count(distinct partner_id) as unique_partners
from DailySales
group by date_id, make_name


Create table Calls (from_id int, to_id int, duration int)
DROP table Calls
insert into Calls (from_id, to_id, duration) values ('1', '2', '59')
insert into Calls (from_id, to_id, duration) values ('2', '1', '11')
insert into Calls (from_id, to_id, duration) values ('1', '3', '20')
insert into Calls (from_id, to_id, duration) values ('3', '4', '100')
insert into Calls (from_id, to_id, duration) values ('3', '4', '200')
insert into Calls (from_id, to_id, duration) values ('3', '4', '200')
insert into Calls (from_id, to_id, duration) values ('4', '3', '499')
--
with cte as (
	select
		to_id as person1 , from_id as person2,
		duration
	from Calls where from_id > to_id
	UNION ALL
	select
		from_id as person1 , to_id as person2,
		duration
	from Calls where from_id < to_id
)
select 
	person1, person2,
	count(1) as call_count,
	sum(duration) as total_duration
from cte
group by person1, person2

--
with cte_interval as (
	select 
		user_id,
		visit_date,
		isnull(LEAD(visit_date, 1) over (partition by user_id order by visit_date), '2021-01-01') as nxt_date
	from UserVisits
) 
select 
	user_id, 
	max(DATEDIFF(day, visit_date, nxt_date)) as biggest_window
from cte_interval
group by user_id
order by user_id

--
Create table Boxes (box_id int, chest_id int, apple_count int, orange_count int)
Create table Chests (chest_id int, apple_count int, orange_count int)
Truncate table Boxes
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('2', null, '6', '15')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('18', '14', '4', '15')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('19', '3', '8', '4')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('12', '2', '19', '20')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('20', '6', '12', '9')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('8', '6', '9', '9')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('3', '14', '16', '7')
Truncate table Chests
insert into Chests (chest_id, apple_count, orange_count) values ('6', '5', '6')
insert into Chests (chest_id, apple_count, orange_count) values ('14', '20', '10')
insert into Chests (chest_id, apple_count, orange_count) values ('2', '8', '8')
insert into Chests (chest_id, apple_count, orange_count) values ('3', '19', '4')
insert into Chests (chest_id, apple_count, orange_count) values ('16', '19', '19')
--
select sum(apple_count) as apple_count, sum(orange_count) as orange_count
from (
	select
		isnull(b.apple_count, 0) + isnull(c.apple_count, 0) as apple_count,
		isnull(b.orange_count, 0) + isnull(c.orange_count, 0) as orange_count
	from Boxes B
	left join Chests C on B.chest_id=C.chest_id
) sq 
--
Create table  Followers(user_id int, follower_id int)
Truncate table Followers
insert into Followers (user_id, follower_id) values ('0', '1')
insert into Followers (user_id, follower_id) values ('1', '0')
insert into Followers (user_id, follower_id) values ('2', '0')
insert into Followers (user_id, follower_id) values ('2', '1')
--

select
	user_id,
	count(follower_id) as followers_count
from Followers F
group by user_id
order by 1

--
--Create table Employees(employee_id int, name varchar(20), reports_to int, age int)
--DROP table Employees
--insert into Employees (employee_id, name, reports_to, age) values ('9', 'Hercy', Null , '43')
--insert into Employees (employee_id, name, reports_to, age) values ('6', 'Alice', '9', '41')
--insert into Employees (employee_id, name, reports_to, age) values ('4', 'Bob', '9', '36')
--insert into Employees (employee_id, name, reports_to, age) values ('2', 'Winston', Null, '37')

--
with cte as (
	select
		E.age as employee_age,
		M.employee_id as manager_id,
		M.name as manager_name
	from Employees E
	left join Employees M on M.employee_id = E.reports_to
	where M.employee_id is not null
)
select 
	manager_id as employee_id,
	manager_name as name,
	count(1) as reports_count,
	cast(ROUND(avg(employee_age * 1.00), 0) as int) as average_age 
from cte
group by manager_id, manager_name
order by manager_id

--
	select
		M.employee_id,
		M.name,
		count(1) as reports_count,
		cast(ROUND(avg(E.age * 1.00), 0) as int) as average_age 
	from Employees E
	left join Employees M on M.employee_id = E.reports_to
	where M.employee_id is not null
	group by M.employee_id, M.name
	order by M.employee_id

--Create table  Employees(emp_id int, event_day date, in_time int, out_time int)
--DROP table Employees
--insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '4', '32')
--insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '55', '200')
--insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-12-3', '1', '42')
--insert into Employees (emp_id, event_day, in_time, out_time) values ('2', '2020-11-28', '3', '33')
--insert into Employees (emp_id, event_day, in_time, out_time) values ('2', '2020-12-9', '47', '74')

select
	event_day as day,
	emp_id,
	sum(out_time - in_time) as total_time
from Employees
group by 	emp_id, event_day

--Create table  LogInfo (account_id int, ip_address int, login datetime, logout datetime)
--Truncate table LogInfo
--insert into LogInfo (account_id, ip_address, login, logout) values ('1', '1', '2021-02-01 09:00:00', '2021-02-01 09:30:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('1', '2', '2021-02-01 08:00:00', '2021-02-01 11:30:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('2', '6', '2021-02-01 20:30:00', '2021-02-01 22:00:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('2', '7', '2021-02-02 20:30:00', '2021-02-02 22:00:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('3', '9', '2021-02-01 16:00:00', '2021-02-01 16:59:59')
--insert into LogInfo (account_id, ip_address, login, logout) values ('3', '13', '2021-02-01 17:00:00', '2021-02-01 17:59:59')
--insert into LogInfo (account_id, ip_address, login, logout) values ('4', '10', '2021-02-01 16:00:00', '2021-02-01 17:00:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('4', '11', '2021-02-01 17:00:00', '2021-02-01 17:59:59')

select
distinct
	A.account_id
from LogInfo A
join LogInfo B on A.account_id= B.account_id
where A.ip_address!=B.ip_address and (B.login between A.login and A.logout or B.logout between A.login and A.logout)


--Create table  Products (product_id int, low_fats Varchar(20), recyclable varchar(10))
--DROP table Products
--insert into Products (product_id, low_fats, recyclable) values ('0', 'Y', 'N')
--insert into Products (product_id, low_fats, recyclable) values ('1', 'Y', 'Y')
--insert into Products (product_id, low_fats, recyclable) values ('2', 'N', 'Y')
--insert into Products (product_id, low_fats, recyclable) values ('3', 'Y', 'Y')
--insert into Products (product_id, low_fats, recyclable) values ('4', 'N', 'N')

select
	product_id
from Products
where low_fats = 'Y' and recyclable = 'Y'


--Create table Tasks (task_id int, subtasks_count int)
--Create table Executed (task_id int, subtask_id int)
--Truncate table Tasks
--insert into Tasks (task_id, subtasks_count) values ('1', '3')
--insert into Tasks (task_id, subtasks_count) values ('2', '2')
--insert into Tasks (task_id, subtasks_count) values ('3', '4')
--Truncate table Executed
--insert into Executed (task_id, subtask_id) values ('1', '2')
--insert into Executed (task_id, subtask_id) values ('3', '1')
--insert into Executed (task_id, subtask_id) values ('3', '2')
--insert into Executed (task_id, subtask_id) values ('3', '3')
--insert into Executed (task_id, subtask_id) values ('3', '4')
----
with cte_subtasks as 
(
	select task_id, 1 as subtask_id from tasks
	UNION ALL
	select task_id, subtask_id + 1 from cte_subtasks T1 where subtask_id < (select subtasks_count from Tasks T2 where T1.task_id=T2.task_id)
)
select * 
from cte_subtasks c1 where c1.subtask_id not in (select subtask_id from Executed C2 where c1.task_id=c2.task_id)
order by 1, 2
--
--Create table  Products (product_id int, store varchar(20), price int)
--DROP table Products
--insert into Products (product_id, store, price) values ('0', 'store1', '95')
--insert into Products (product_id, store, price) values ('0', 'store3', '105')
--insert into Products (product_id, store, price) values ('0', 'store2', '100')
--insert into Products (product_id, store, price) values ('1', 'store1', '70')
--insert into Products (product_id, store, price) values ('1', 'store3', '80')
--
/* Write your T-SQL query statement below */
/*
select
	distinct product_id,
	(select price from products sq1 where store='store1' and sq1.product_id = p.product_id) as store1,
	(select price from products sq1 where store='store2' and sq1.product_id = p.product_id) as store2,
	(select price from products sq1 where store='store3' and sq1.product_id = p.product_id) as store3
from Products P
*/

--Sol-2
select
	product_id,
	max(case when store='store1' then price else null end)  as store1,
	max(case when store='store2' then price else null end)  as store2,	
	max(case when store='store3' then price else null end)  as store3
from Products
group by product_id

--Create table  Players (player_id int, player_name varchar(20))
--Create table Championships (year int, Wimbledon int, Fr_open int, US_open int, Au_open int)
--Truncate table Players
--insert into Players (player_id, player_name) values ('1', 'Nadal')
--insert into Players (player_id, player_name) values ('2', 'Federer')
--insert into Players (player_id, player_name) values ('3', 'Novak')
--Truncate table Championships
--insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2018', '1', '1', '1', '1')
--insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2019', '1', '1', '2', '2')
--insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2020', '2', '1', '2', '2')
--
--> solution-1
with cte_tournament as (
	select
		year, Wimbledon as player_id
	from Championships 
	UNION ALL
	select
		year, Fr_open as player_id
	from Championships 
	UNION ALL
	select
		year, US_open as player_id
	from Championships 
	UNION ALL
	select
		year, Au_open as player_id
	from Championships
)
select 
	C.player_id,
	player_name,
	count(1) as grand_slams_count 
from cte_tournament C
join Players P on C.player_id=P.player_id
group by C.player_id, player_name

--> solution- 2
--with cte_tournament as (
--	select tournament, player_id 
--	from
--	(	select
--			wimbledon,
--			fr_open,
--			US_open,
--			Au_open
--		from Championships
--	) P
--	UNPIVOT
--	(
--		player_id for tournament in (wimbledon, fr_open, US_open, Au_open)
--	) as upvt
--) 
--select 
--	C.player_id,
--	player_name,
--	count(1) as grand_slams_count 
--from cte_tournament C
--join Players P on C.player_id=P.player_id
--group by C.player_id, player_name

Create table  Employee (employee_id int, department_id int, primary_flag varchar(10))
DROP table Employee
insert into Employee (employee_id, department_id, primary_flag) values ('1', '1', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('2', '1', 'Y')
insert into Employee (employee_id, department_id, primary_flag) values ('2', '2', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('3', '3', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '2', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '3', 'Y')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '4', 'N')
--

select
	employee_id,
	department_id
from Employee
where primary_flag='Y'
UNION
select
	employee_id,
	max(department_id)
from Employee
group by employee_id
having count(department_id) = 1

--Create table Products (product_id int, store1 int, store2 int, store3 int)
--DROP table Products
--insert into Products (product_id, store1, store2, store3) values ('0', '95', '100', '105')
--insert into Products (product_id, store1, store2, store3) values ('1', '70', null, '80')
--
with cte_products as (
	select 
		product_id,
		'store1' as store,
		store1 as price
	from Products
	UNION ALL
	select 
		product_id,
		'store2' as store,
		store2 as price
	from Products
	UNION ALL
	select 
		product_id,
		'store3' as store,
		store3 as price
	from Products
) select * from cte_products where price is not null order by 1, 2


Create table  Playback(session_id int,customer_id int,start_time int,end_time int)
Create table Ads (ad_id int, customer_id int, timestamp int)
Truncate table Playback
insert into Playback (session_id, customer_id, start_time, end_time) values ('1', '1', '1', '5')
insert into Playback (session_id, customer_id, start_time, end_time) values ('2', '1', '15', '23')
insert into Playback (session_id, customer_id, start_time, end_time) values ('3', '2', '10', '12')
insert into Playback (session_id, customer_id, start_time, end_time) values ('4', '2', '17', '28')
insert into Playback (session_id, customer_id, start_time, end_time) values ('5', '2', '2', '8')
DROP table Ads
insert into Ads (ad_id, customer_id, timestamp) values ('1', '1', '5')
insert into Ads (ad_id, customer_id, timestamp) values ('2', '2', '17')
insert into Ads (ad_id, customer_id, timestamp) values ('3', '2', '20')
--
with cte_ads as (
	select distinct
		session_id
	from Playback P
	join Ads A on P.customer_id=A.customer_id
	where timestamp between start_time and end_time
)
select session_id from Playback where session_id not in (select session_id from cte_ads)

--Create table  Contests (contest_id int, gold_medal int, silver_medal int, bronze_medal int)
--Create table  Users (user_id int, mail varchar(50), name varchar(30))
--DROP table Contests
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('190', '1', '5', '2')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('191', '2', '3', '5')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('192', '5', '2', '3')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('193', '1', '3', '5')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('194', '4', '5', '2')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('195', '4', '2', '1')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('196', '1', '5', '2')
--DROP table Users
--insert into Users (user_id, mail, name) values ('1', 'sarah@leetcode.com', 'Sarah')
--insert into Users (user_id, mail, name) values ('2', 'bob@leetcode.com', 'Bob')
--insert into Users (user_id, mail, name) values ('3', 'alice@leetcode.com', 'Alice')
--insert into Users (user_id, mail, name) values ('4', 'hercy@leetcode.com', 'Hercy')
--insert into Users (user_id, mail, name) values ('5', 'quarz@leetcode.com', 'Quarz')
--
with cte1 as (
	select
		contest_id,
		medals,
		user_id
	from Contests
	unpivot (user_id for medals in (gold_medal, silver_medal, bronze_medal)) as unpvt
), cte2 as (
	select
		*,
		contest_id - LAG(contest_id, 2) over (partition by user_id order by contest_id) as diff
	from cte1
), cte3 as (
	select user_id
	from cte2
	where diff = 2
	UNION
	select user_id
	from cte1
	group by user_id, medals
	having count(user_id) >= 3 and  medals= 'gold_medal'
)
select name, mail
from cte3 c join users u on c.user_id=u.user_id

--Create table Customers (customer_id int, year int, revenue int)
--DROP table Customers
--insert into Customers (customer_id, year, revenue) values ('1', '2018', '50')
--insert into Customers (customer_id, year, revenue) values ('1', '2021', '30')
--insert into Customers (customer_id, year, revenue) values ('1', '2020', '70')
--insert into Customers (customer_id, year, revenue) values ('2', '2021', '-50')
--insert into Customers (customer_id, year, revenue) values ('3', '2018', '10')
--insert into Customers (customer_id, year, revenue) values ('3', '2016', '50')
--insert into Customers (customer_id, year, revenue) values ('4', '2021', '20')

with cte as (
select
	customer_id,
	revenue
from Customers
where year= 2021
)
select customer_id from cte where revenue > 0

--Create table Transactions (transaction_id int, day datetime, amount int)
--DROP table Transactions
--insert into Transactions (transaction_id, day, amount) values ('8', '2021-4-3 15:57:28', '57')
--insert into Transactions (transaction_id, day, amount) values ('9', '2021-4-28 08:47:25', '21')
--insert into Transactions (transaction_id, day, amount) values ('1', '2021-4-29 13:28:30', '58')
--insert into Transactions (transaction_id, day, amount) values ('5', '2021-4-28 16:39:59', '40')
--insert into Transactions (transaction_id, day, amount) values ('6', '2021-4-29 23:39:28', '58')

with cte1 as (
	select
		transaction_id,
		convert(varchar(10), day, 121) as date,
		amount
	from Transactions
), cte2 as  (
	select 
		date,
		max(amount) as max_amount
	from cte1
	group by date
) 
select 
	transaction_id
from cte1 c1 where amount= (select max_amount from cte2  c2 where c1.date=c2.date) 
order by transaction_id

--Create table  Days (day date)
--Truncate table Days
--insert into Days (day) values ('2022-04-12')
--insert into Days (day) values ('2021-08-09')
--insert into Days (day) values ('2020-06-26')

--
select
	datename(weekday, day) + ', ' + 
	datename(month, day) + ' ' + 
	cast(day(day) as varchar(3)) + ', ' + 
	cast(year(day) as varchar(5)) as day
from days

select format(day, 'D' ,'en-US') from days

--Create table OrdersDetails (order_id int, product_id int, quantity int)
--Truncate table OrdersDetails
--insert into OrdersDetails (order_id, product_id, quantity) values ('1', '1', '12')
--insert into OrdersDetails (order_id, product_id, quantity) values ('1', '2', '10')
--insert into OrdersDetails (order_id, product_id, quantity) values ('1', '3', '15')
--insert into OrdersDetails (order_id, product_id, quantity) values ('2', '1', '8')
--insert into OrdersDetails (order_id, product_id, quantity) values ('2', '4', '4')
--insert into OrdersDetails (order_id, product_id, quantity) values ('2', '5', '6')
--insert into OrdersDetails (order_id, product_id, quantity) values ('3', '3', '5')
--insert into OrdersDetails (order_id, product_id, quantity) values ('3', '4', '18')
--insert into OrdersDetails (order_id, product_id, quantity) values ('4', '5', '2')
--insert into OrdersDetails (order_id, product_id, quantity) values ('4', '6', '8')
--insert into OrdersDetails (order_id, product_id, quantity) values ('5', '7', '9')
--insert into OrdersDetails (order_id, product_id, quantity) values ('5', '8', '9')
--insert into OrdersDetails (order_id, product_id, quantity) values ('3', '9', '20')
--insert into OrdersDetails (order_id, product_id, quantity) values ('2', '9', '4')

with cte_avg as (
	select
		sum(quantity) * 1.00 / count(distinct product_id) as avg_quantity
	from OrdersDetails
	group by order_id
)
select distinct c1.order_id
from OrdersDetails c1
where c1.quantity > (select max(avg_quantity) from cte_avg)

<<<<<<< working
--
with cte_interval as (
	select 
		user_id,
		visit_date,
		isnull(LEAD(visit_date, 1) over (partition by user_id order by visit_date), '2021-01-01') as nxt_date
	from UserVisits
) 
select 
	user_id, 
	max(DATEDIFF(day, visit_date, nxt_date)) as biggest_window
from cte_interval
group by user_id
order by user_id

--
Create table Boxes (box_id int, chest_id int, apple_count int, orange_count int)
Create table Chests (chest_id int, apple_count int, orange_count int)
Truncate table Boxes
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('2', null, '6', '15')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('18', '14', '4', '15')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('19', '3', '8', '4')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('12', '2', '19', '20')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('20', '6', '12', '9')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('8', '6', '9', '9')
insert into Boxes (box_id, chest_id, apple_count, orange_count) values ('3', '14', '16', '7')
Truncate table Chests
insert into Chests (chest_id, apple_count, orange_count) values ('6', '5', '6')
insert into Chests (chest_id, apple_count, orange_count) values ('14', '20', '10')
insert into Chests (chest_id, apple_count, orange_count) values ('2', '8', '8')
insert into Chests (chest_id, apple_count, orange_count) values ('3', '19', '4')
insert into Chests (chest_id, apple_count, orange_count) values ('16', '19', '19')
--
select sum(apple_count) as apple_count, sum(orange_count) as orange_count
from (
	select
		isnull(b.apple_count, 0) + isnull(c.apple_count, 0) as apple_count,
		isnull(b.orange_count, 0) + isnull(c.orange_count, 0) as orange_count
	from Boxes B
	left join Chests C on B.chest_id=C.chest_id
) sq 
--
Create table  Followers(user_id int, follower_id int)
Truncate table Followers
insert into Followers (user_id, follower_id) values ('0', '1')
insert into Followers (user_id, follower_id) values ('1', '0')
insert into Followers (user_id, follower_id) values ('2', '0')
insert into Followers (user_id, follower_id) values ('2', '1')
--

select
	user_id,
	count(follower_id) as followers_count
from Followers F
group by user_id
order by 1

--
--Create table Employees(employee_id int, name varchar(20), reports_to int, age int)
--DROP table Employees
--insert into Employees (employee_id, name, reports_to, age) values ('9', 'Hercy', Null , '43')
--insert into Employees (employee_id, name, reports_to, age) values ('6', 'Alice', '9', '41')
--insert into Employees (employee_id, name, reports_to, age) values ('4', 'Bob', '9', '36')
--insert into Employees (employee_id, name, reports_to, age) values ('2', 'Winston', Null, '37')

--
with cte as (
	select
		E.age as employee_age,
		M.employee_id as manager_id,
		M.name as manager_name
	from Employees E
	left join Employees M on M.employee_id = E.reports_to
	where M.employee_id is not null
)
select 
	manager_id as employee_id,
	manager_name as name,
	count(1) as reports_count,
	cast(ROUND(avg(employee_age * 1.00), 0) as int) as average_age 
from cte
group by manager_id, manager_name
order by manager_id

--
	select
		M.employee_id,
		M.name,
		count(1) as reports_count,
		cast(ROUND(avg(E.age * 1.00), 0) as int) as average_age 
	from Employees E
	left join Employees M on M.employee_id = E.reports_to
	where M.employee_id is not null
	group by M.employee_id, M.name
	order by M.employee_id

--Create table  Employees(emp_id int, event_day date, in_time int, out_time int)
--DROP table Employees
--insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '4', '32')
--insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-11-28', '55', '200')
--insert into Employees (emp_id, event_day, in_time, out_time) values ('1', '2020-12-3', '1', '42')
--insert into Employees (emp_id, event_day, in_time, out_time) values ('2', '2020-11-28', '3', '33')
--insert into Employees (emp_id, event_day, in_time, out_time) values ('2', '2020-12-9', '47', '74')

select
	event_day as day,
	emp_id,
	sum(out_time - in_time) as total_time
from Employees
group by 	emp_id, event_day

--Create table  LogInfo (account_id int, ip_address int, login datetime, logout datetime)
--Truncate table LogInfo
--insert into LogInfo (account_id, ip_address, login, logout) values ('1', '1', '2021-02-01 09:00:00', '2021-02-01 09:30:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('1', '2', '2021-02-01 08:00:00', '2021-02-01 11:30:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('2', '6', '2021-02-01 20:30:00', '2021-02-01 22:00:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('2', '7', '2021-02-02 20:30:00', '2021-02-02 22:00:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('3', '9', '2021-02-01 16:00:00', '2021-02-01 16:59:59')
--insert into LogInfo (account_id, ip_address, login, logout) values ('3', '13', '2021-02-01 17:00:00', '2021-02-01 17:59:59')
--insert into LogInfo (account_id, ip_address, login, logout) values ('4', '10', '2021-02-01 16:00:00', '2021-02-01 17:00:00')
--insert into LogInfo (account_id, ip_address, login, logout) values ('4', '11', '2021-02-01 17:00:00', '2021-02-01 17:59:59')

select
distinct
	A.account_id
from LogInfo A
join LogInfo B on A.account_id= B.account_id
where A.ip_address!=B.ip_address and (B.login between A.login and A.logout or B.logout between A.login and A.logout)


--Create table  Products (product_id int, low_fats Varchar(20), recyclable varchar(10))
--DROP table Products
--insert into Products (product_id, low_fats, recyclable) values ('0', 'Y', 'N')
--insert into Products (product_id, low_fats, recyclable) values ('1', 'Y', 'Y')
--insert into Products (product_id, low_fats, recyclable) values ('2', 'N', 'Y')
--insert into Products (product_id, low_fats, recyclable) values ('3', 'Y', 'Y')
--insert into Products (product_id, low_fats, recyclable) values ('4', 'N', 'N')

select
	product_id
from Products
where low_fats = 'Y' and recyclable = 'Y'


--Create table Tasks (task_id int, subtasks_count int)
--Create table Executed (task_id int, subtask_id int)
--Truncate table Tasks
--insert into Tasks (task_id, subtasks_count) values ('1', '3')
--insert into Tasks (task_id, subtasks_count) values ('2', '2')
--insert into Tasks (task_id, subtasks_count) values ('3', '4')
--Truncate table Executed
--insert into Executed (task_id, subtask_id) values ('1', '2')
--insert into Executed (task_id, subtask_id) values ('3', '1')
--insert into Executed (task_id, subtask_id) values ('3', '2')
--insert into Executed (task_id, subtask_id) values ('3', '3')
--insert into Executed (task_id, subtask_id) values ('3', '4')
----
with cte_subtasks as 
(
	select task_id, 1 as subtask_id from tasks
	UNION ALL
	select task_id, subtask_id + 1 from cte_subtasks T1 where subtask_id < (select subtasks_count from Tasks T2 where T1.task_id=T2.task_id)
)
select * 
from cte_subtasks c1 where c1.subtask_id not in (select subtask_id from Executed C2 where c1.task_id=c2.task_id)
order by 1, 2
--
--Create table  Products (product_id int, store varchar(20), price int)
--DROP table Products
--insert into Products (product_id, store, price) values ('0', 'store1', '95')
--insert into Products (product_id, store, price) values ('0', 'store3', '105')
--insert into Products (product_id, store, price) values ('0', 'store2', '100')
--insert into Products (product_id, store, price) values ('1', 'store1', '70')
--insert into Products (product_id, store, price) values ('1', 'store3', '80')
--
/* Write your T-SQL query statement below */
/*
select
	distinct product_id,
	(select price from products sq1 where store='store1' and sq1.product_id = p.product_id) as store1,
	(select price from products sq1 where store='store2' and sq1.product_id = p.product_id) as store2,
	(select price from products sq1 where store='store3' and sq1.product_id = p.product_id) as store3
from Products P
*/

--Sol-2
select
	product_id,
	max(case when store='store1' then price else null end)  as store1,
	max(case when store='store2' then price else null end)  as store2,	
	max(case when store='store3' then price else null end)  as store3
from Products
group by product_id

--Create table  Players (player_id int, player_name varchar(20))
--Create table Championships (year int, Wimbledon int, Fr_open int, US_open int, Au_open int)
--Truncate table Players
--insert into Players (player_id, player_name) values ('1', 'Nadal')
--insert into Players (player_id, player_name) values ('2', 'Federer')
--insert into Players (player_id, player_name) values ('3', 'Novak')
--Truncate table Championships
--insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2018', '1', '1', '1', '1')
--insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2019', '1', '1', '2', '2')
--insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2020', '2', '1', '2', '2')
--
--> solution-1
with cte_tournament as (
	select
		year, Wimbledon as player_id
	from Championships 
	UNION ALL
	select
		year, Fr_open as player_id
	from Championships 
	UNION ALL
	select
		year, US_open as player_id
	from Championships 
	UNION ALL
	select
		year, Au_open as player_id
	from Championships
)
select 
	C.player_id,
	player_name,
	count(1) as grand_slams_count 
from cte_tournament C
join Players P on C.player_id=P.player_id
group by C.player_id, player_name

--> solution- 2
--with cte_tournament as (
--	select tournament, player_id 
--	from
--	(	select
--			wimbledon,
--			fr_open,
--			US_open,
--			Au_open
--		from Championships
--	) P
--	UNPIVOT
--	(
--		player_id for tournament in (wimbledon, fr_open, US_open, Au_open)
--	) as upvt
--) 
--select 
--	C.player_id,
--	player_name,
--	count(1) as grand_slams_count 
--from cte_tournament C
--join Players P on C.player_id=P.player_id
--group by C.player_id, player_name

Create table  Employee (employee_id int, department_id int, primary_flag varchar(10))
DROP table Employee
insert into Employee (employee_id, department_id, primary_flag) values ('1', '1', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('2', '1', 'Y')
insert into Employee (employee_id, department_id, primary_flag) values ('2', '2', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('3', '3', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '2', 'N')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '3', 'Y')
insert into Employee (employee_id, department_id, primary_flag) values ('4', '4', 'N')
--

select
	employee_id,
	department_id
from Employee
where primary_flag='Y'
UNION
select
	employee_id,
	max(department_id)
from Employee
group by employee_id
having count(department_id) = 1

--Create table Products (product_id int, store1 int, store2 int, store3 int)
--DROP table Products
--insert into Products (product_id, store1, store2, store3) values ('0', '95', '100', '105')
--insert into Products (product_id, store1, store2, store3) values ('1', '70', null, '80')
--
with cte_products as (
	select 
		product_id,
		'store1' as store,
		store1 as price
	from Products
	UNION ALL
	select 
		product_id,
		'store2' as store,
		store2 as price
	from Products
	UNION ALL
	select 
		product_id,
		'store3' as store,
		store3 as price
	from Products
) select * from cte_products where price is not null order by 1, 2


Create table  Playback(session_id int,customer_id int,start_time int,end_time int)
Create table Ads (ad_id int, customer_id int, timestamp int)
Truncate table Playback
insert into Playback (session_id, customer_id, start_time, end_time) values ('1', '1', '1', '5')
insert into Playback (session_id, customer_id, start_time, end_time) values ('2', '1', '15', '23')
insert into Playback (session_id, customer_id, start_time, end_time) values ('3', '2', '10', '12')
insert into Playback (session_id, customer_id, start_time, end_time) values ('4', '2', '17', '28')
insert into Playback (session_id, customer_id, start_time, end_time) values ('5', '2', '2', '8')
DROP table Ads
insert into Ads (ad_id, customer_id, timestamp) values ('1', '1', '5')
insert into Ads (ad_id, customer_id, timestamp) values ('2', '2', '17')
insert into Ads (ad_id, customer_id, timestamp) values ('3', '2', '20')
--
with cte_ads as (
	select distinct
		session_id
	from Playback P
	join Ads A on P.customer_id=A.customer_id
	where timestamp between start_time and end_time
)
select session_id from Playback where session_id not in (select session_id from cte_ads)

--Create table  Contests (contest_id int, gold_medal int, silver_medal int, bronze_medal int)
--Create table  Users (user_id int, mail varchar(50), name varchar(30))
--DROP table Contests
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('190', '1', '5', '2')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('191', '2', '3', '5')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('192', '5', '2', '3')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('193', '1', '3', '5')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('194', '4', '5', '2')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('195', '4', '2', '1')
--insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('196', '1', '5', '2')
--DROP table Users
--insert into Users (user_id, mail, name) values ('1', 'sarah@leetcode.com', 'Sarah')
--insert into Users (user_id, mail, name) values ('2', 'bob@leetcode.com', 'Bob')
--insert into Users (user_id, mail, name) values ('3', 'alice@leetcode.com', 'Alice')
--insert into Users (user_id, mail, name) values ('4', 'hercy@leetcode.com', 'Hercy')
--insert into Users (user_id, mail, name) values ('5', 'quarz@leetcode.com', 'Quarz')
--
with cte1 as (
	select
		contest_id,
		medals,
		user_id
	from Contests
	unpivot (user_id for medals in (gold_medal, silver_medal, bronze_medal)) as unpvt
), cte2 as (
	select
		*,
		contest_id - LAG(contest_id, 2) over (partition by user_id order by contest_id) as diff
	from cte1
), cte3 as (
	select user_id
	from cte2
	where diff = 2
	UNION
	select user_id
	from cte1
	group by user_id, medals
	having count(user_id) >= 3 and  medals= 'gold_medal'
)
select name, mail
from cte3 c join users u on c.user_id=u.user_id

--Create table Customers (customer_id int, year int, revenue int)
--DROP table Customers
--insert into Customers (customer_id, year, revenue) values ('1', '2018', '50')
--insert into Customers (customer_id, year, revenue) values ('1', '2021', '30')
--insert into Customers (customer_id, year, revenue) values ('1', '2020', '70')
--insert into Customers (customer_id, year, revenue) values ('2', '2021', '-50')
--insert into Customers (customer_id, year, revenue) values ('3', '2018', '10')
--insert into Customers (customer_id, year, revenue) values ('3', '2016', '50')
--insert into Customers (customer_id, year, revenue) values ('4', '2021', '20')

with cte as (
select
	customer_id,
	revenue
from Customers
where year= 2021
)
select customer_id from cte where revenue > 0

--Create table Transactions (transaction_id int, day datetime, amount int)
--DROP table Transactions
--insert into Transactions (transaction_id, day, amount) values ('8', '2021-4-3 15:57:28', '57')
--insert into Transactions (transaction_id, day, amount) values ('9', '2021-4-28 08:47:25', '21')
--insert into Transactions (transaction_id, day, amount) values ('1', '2021-4-29 13:28:30', '58')
--insert into Transactions (transaction_id, day, amount) values ('5', '2021-4-28 16:39:59', '40')
--insert into Transactions (transaction_id, day, amount) values ('6', '2021-4-29 23:39:28', '58')

with cte1 as (
	select
		transaction_id,
		convert(varchar(10), day, 121) as date,
		amount
	from Transactions
), cte2 as  (
	select 
		date,
		max(amount) as max_amount
	from cte1
	group by date
) 
select 
	transaction_id
from cte1 c1 where amount= (select max_amount from cte2  c2 where c1.date=c2.date) 
order by transaction_id

--Create table  Days (day date)
--Truncate table Days
--insert into Days (day) values ('2022-04-12')
--insert into Days (day) values ('2021-08-09')
--insert into Days (day) values ('2020-06-26')

--
select
	datename(weekday, day) + ', ' + 
	datename(month, day) + ' ' + 
	cast(day(day) as varchar(3)) + ', ' + 
	cast(year(day) as varchar(5)) as day
from days

select format(day, 'D' ,'en-US') from days

--Create table OrdersDetails (order_id int, product_id int, quantity int)
--Truncate table OrdersDetails
--insert into OrdersDetails (order_id, product_id, quantity) values ('1', '1', '12')
--insert into OrdersDetails (order_id, product_id, quantity) values ('1', '2', '10')
--insert into OrdersDetails (order_id, product_id, quantity) values ('1', '3', '15')
--insert into OrdersDetails (order_id, product_id, quantity) values ('2', '1', '8')
--insert into OrdersDetails (order_id, product_id, quantity) values ('2', '4', '4')
--insert into OrdersDetails (order_id, product_id, quantity) values ('2', '5', '6')
--insert into OrdersDetails (order_id, product_id, quantity) values ('3', '3', '5')
--insert into OrdersDetails (order_id, product_id, quantity) values ('3', '4', '18')
--insert into OrdersDetails (order_id, product_id, quantity) values ('4', '5', '2')
--insert into OrdersDetails (order_id, product_id, quantity) values ('4', '6', '8')
--insert into OrdersDetails (order_id, product_id, quantity) values ('5', '7', '9')
--insert into OrdersDetails (order_id, product_id, quantity) values ('5', '8', '9')
--insert into OrdersDetails (order_id, product_id, quantity) values ('3', '9', '20')
--insert into OrdersDetails (order_id, product_id, quantity) values ('2', '9', '4')

with cte_avg as (
	select
		sum(quantity) * 1.00 / count(distinct product_id) as avg_quantity
	from OrdersDetails
	group by order_id
)
select distinct c1.order_id
from OrdersDetails c1
where c1.quantity > (select max(avg_quantity) from cte_avg)
=======
>>>>>>> main

Create table  Employees (employee_id int, name varchar(30), salary int)
DROP table Employees
insert into Employees (employee_id, name, salary) values ('2', 'Meir', '3000')
insert into Employees (employee_id, name, salary) values ('3', 'Michael', '3800')
insert into Employees (employee_id, name, salary) values ('7', 'Addilyn', '7400')
insert into Employees (employee_id, name, salary) values ('8', 'Juan', '6100')
insert into Employees (employee_id, name, salary) values ('9', 'Kannon', '7700')
insert into Employees (employee_id, name, salary) values ('3', 'michael', '3800')
--

select
	employee_id,
	case when employee_id % 2 != 0 and name not like 'M%' then salary else 0 end as bonus
from Employees
order by employee_id

--Create table Employees (employee_id int, name varchar(30), salary int)
--DROP table Employees
--insert into Employees (employee_id, name, salary) values ('2', 'Meir', '3000')
--insert into Employees (employee_id, name, salary) values ('3', 'Michael', '3000')
--insert into Employees (employee_id, name, salary) values ('7', 'Addilyn', '7400')
--insert into Employees (employee_id, name, salary) values ('8', 'Juan', '6100')
--insert into Employees (employee_id, name, salary) values ('9', 'Kannon', '7400')

with cte_salary_cnt as (
	select
		salary,
		count(1) as salary_cnt
	from Employees
	group by salary
), cte_emp_salary as (
	select
		E.*,
		salary_cnt
	from Employees E
	join cte_salary_cnt c on E.salary=c.salary
)
select 
	employee_id,
	name,
	salary,
	dense_rank() over (order by salary) as team_id
from cte_emp_salary 
where salary_cnt <> 1
order by team_id, employee_id

Create table Logins (user_id int, time_stamp datetime)
Truncate table Logins
insert into Logins (user_id, time_stamp) values ('6', '2020-06-30 15:06:07')
insert into Logins (user_id, time_stamp) values ('6', '2021-04-21 14:06:06')
insert into Logins (user_id, time_stamp) values ('6', '2019-03-07 00:18:15')
insert into Logins (user_id, time_stamp) values ('8', '2020-02-01 05:10:53')
insert into Logins (user_id, time_stamp) values ('8', '2020-12-30 00:46:50')
insert into Logins (user_id, time_stamp) values ('2', '2020-01-16 02:49:50')
insert into Logins (user_id, time_stamp) values ('2', '2019-08-25 07:59:08')
insert into Logins (user_id, time_stamp) values ('14', '2019-07-14 09:00:00')
insert into Logins (user_id, time_stamp) values ('14', '2021-01-06 11:59:59')

select user_id, time_stamp as last_stamp
from (
	select
		user_id,
		time_stamp,
		DENSE_RANK() over (partition by user_id order by time_stamp desc) as rn
	from Logins
	where year(time_stamp) = 2020
) sq where rn= 1


--Create table  Accounts (account_id int, income int)
--Truncate table Accounts
--insert into Accounts (account_id, income) values ('3', '108939')
--insert into Accounts (account_id, income) values ('2', '12747')
--insert into Accounts (account_id, income) values ('8', '87709')
--insert into Accounts (account_id, income) values ('6', '91796')

--with cte_accounts as (
--	select
--		account_id,
--		case when income < 20000 then 'Low Salary'
--				when income > 50000 then 'High Salary'
--				else 'Average Salary' end as category
--	from Accounts
--), cte_account_count as (
--	select category, count(account_id) as accounts_count
--	from cte_accounts group by category
--), 

with cte_category as (
	select 'Low Salary' as category union select 'Average Salary' union select 'High Salary'
)
select cc.category, isnull(ca.accounts_count, 0) as accounts_count
from cte_category cc 
left join 
	( select category, count(1) as accounts_count from
		( 
			select
				case when income < 20000 then 'Low Salary'
						when income > 50000 then 'High Salary'
						WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
				end as category
			from Accounts
		) sq group by category
	) ca on cc.category=ca.category

select
	'Low Salary' as category, count(1) as accounts_count
from accounts where income < 20000
UNION
select
	'Average Salary' as category, count(1) as accounts_count
from accounts where income BETWEEN 20000 AND 50000
UNION
select
	'High Salary' as category, count(1) as accounts_count
from accounts where income > 50000 

/* Write your T-SQL query statement below */
WITH CTE AS(
    SELECT
    *,
    CASE WHEN income < 20000 THEN 'Low Salary' 
         WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
         WHEN income > 50000 THEN 'High Salary'
    END AS category
FROM
    Accounts
),
CTE2 AS(
    SELECT 'Low Salary' AS category
    UNION 
    SELECT 'Average Salary'
    UNION
    SELECT 'High Salary'
)
SELECT
    c1.category,
    COUNT(income) AS accounts_count
FROM
    CTE2 AS c1
LEFT JOIN
    CTE AS c2 
ON
    c1.category = c2.category
GROUP BY
    c1.category

--Create table Signups (user_id int, time_stamp datetime)
--Create table  Confirmations (user_id int, time_stamp datetime, action varchar(30))
--Truncate table Signups
--insert into Signups (user_id, time_stamp) values ('3', '2020-03-21 10:16:13')
--insert into Signups (user_id, time_stamp) values ('7', '2020-01-04 13:57:59')
--insert into Signups (user_id, time_stamp) values ('2', '2020-07-29 23:09:44')
--insert into Signups (user_id, time_stamp) values ('6', '2020-12-09 10:39:37')
--Truncate table Confirmations
--insert into Confirmations (user_id, time_stamp, action) values ('3', '2021-01-06 03:30:46', 'timeout')
--insert into Confirmations (user_id, time_stamp, action) values ('3', '2021-07-14 14:00:00', 'timeout')
--insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-12 11:57:29', 'confirmed')
--insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-13 12:58:28', 'confirmed')
--insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-14 13:59:27', 'confirmed')
--insert into Confirmations (user_id, time_stamp, action) values ('2', '2021-01-22 00:00:00', 'confirmed')
--insert into Confirmations (user_id, time_stamp, action) values ('2', '2021-02-28 23:59:59', 'timeout')
----
with cte_confirmation as (
	select
		user_id,
		sum(case when action = 'timeout' then 1 else 0 end) as timeout_cnt,
		sum(case when action = 'confirmed' then 1 else 0 end) as confirmed_cnt
	from Confirmations
	group by user_id
)
select 
	S.user_id,
	cast(isnull(case when confirmed_cnt + timeout_cnt = 0 then 1.00 else (confirmed_cnt * 1.00 / (confirmed_cnt + timeout_cnt)) end, 0.00) as decimal(5,2)) as  confirmation_rate
from Signups S
Left Join cte_confirmation C on S.user_id = C.user_id