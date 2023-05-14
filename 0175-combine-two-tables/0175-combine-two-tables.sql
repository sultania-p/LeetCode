# Write your MySQL query statement below
/* Write your T-SQL query statement below */
select
p.firstname, p.lastname, A.city, A.state
from Person P left join Address A on P.personid = A.personid