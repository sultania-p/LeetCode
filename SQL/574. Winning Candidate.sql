/*
Table: Candidate

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
+-------------+----------+
id is the primary key column for this table.
Each row of this table contains information about the id and the name of a candidate.
 

Table: Vote

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| candidateId | int  |
+-------------+------+
id is an auto-increment primary key.
candidateId is a foreign key to id from the Candidate table.
Each row of this table determines the candidate who got the ith vote in the elections.
 

Write an SQL query to report the name of the winning candidate (i.e., the candidate who got the largest number of votes).

The test cases are generated so that exactly one candidate wins the elections.

The query result format is in the following example.

 

Example 1:

Input: 
Candidate table:
+----+------+
| id | name |
+----+------+
| 1  | A    |
| 2  | B    |
| 3  | C    |
| 4  | D    |
| 5  | E    |
+----+------+
Vote table:
+----+-------------+
| id | candidateId |
+----+-------------+
| 1  | 2           |
| 2  | 4           |
| 3  | 3           |
| 4  | 2           |
| 5  | 5           |
+----+-------------+
Output: 
+------+
| name |
+------+
| B    |
+------+
Explanation: 
Candidate B has 2 votes. Candidates C, D, and E have 1 vote each.
The winner is candidate B.


*/
Create table  Candidate (id int, name varchar(255))
Create table Vote (id int, candidateId int)
Truncate table Candidate
insert into Candidate (id, name) values ('1', 'A')
insert into Candidate (id, name) values ('2', 'B')
insert into Candidate (id, name) values ('3', 'C')
insert into Candidate (id, name) values ('4', 'D')
insert into Candidate (id, name) values ('5', 'E')
Truncate table Vote
insert into Vote (id, candidateId) values ('1', '2')
insert into Vote (id, candidateId) values ('2', '4')
insert into Vote (id, candidateId) values ('3', '3')
insert into Vote (id, candidateId) values ('4', '2')
insert into Vote (id, candidateId) values ('5', '5')
--
select * from Candidate;
select * from Vote;

select top 1 sq.name from (
select C.name, count(1) as vote_cnt
from Candidate C LEFT JOIN Vote V on C.id = V.candidateId
GROUP BY c.name
) SQ order by vote_cnt desc
