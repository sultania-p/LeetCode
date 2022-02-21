Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. Note that you are supposed to write a DELETE statement and not a SELECT one.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Person table:
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Output: 
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.

Create table Person (Id int, Email varchar(255))
Truncate table Person
insert into Person (id, email) values ('1', 'john@example.com')
insert into Person (id, email) values ('2', 'bob@example.com')
insert into Person (id, email) values ('3', 'john@example.com')
insert into Person (id, email) values ('4', 'bob@example.com')
insert into Person (id, email) values ('5', 'piyush@example.com')

select * from Person
---
delete from Person where id in 
(
	select distinct id from Person P where P.email in 
		(
			select email from Person group by email
			having count(*) > 1
		) and id in (select max(id) from Person group by email)
)

2nd approach

select * from Person P1 where P1.id not in
(
	select p2.id from person p1
	inner join Person p2 on p1.email = p2.email and P1.id < p2.id
)

