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