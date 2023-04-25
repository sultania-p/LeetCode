



/*
Write an SQL query to report the shortest distance between any two points from the Point table.

The query result format is in the following example.
*/


/* Write your T-SQL query statement below */
select
    min(abs(p1.x-p2.x)) as shortest
from point p1
cross join point p2
where p1.x <> p2.x