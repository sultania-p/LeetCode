

/*
The distance between two points p1(x1, y1) and p2(x2, y2) is sqrt((x2 - x1)2 + (y2 - y1)2).

Write an SQL query to report the shortest distance between any two points from the Point2D table. Round the distance to two decimal points.

The query result format is in the following example.
*/


/* Write your T-SQL query statement below */
/* Write your T-SQL query statement below */
with cte_short as
(    select distinct
        p1.x as x1, p1.y as y1,
        p2.x as x2, p2.y as y2
    from Point2D p1
    cross join Point2D p2
    where (p1.x <> p2.x or p1.y <> p2.y)
 )
select MIN(ROUND(sqrt(square(x2-x1) + square(y2-y1)), 2)) as shortest
from cte_short