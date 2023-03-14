/*
Write an SQL query to report all the consecutive available seats in the cinema.

Return the result table ordered by seat_id in ascending order.

The test cases are generated so that more than two seats are consecutively available.

The query result format is in the following example.
*/

/* Write your T-SQL query statement below */

select
    distinct
    c1.seat_id
from cinema c1
join cinema c2
    on (c1.seat_id = c2.seat_id + 1 and c1.free = 1 and c2.free =1)
    or (c1.seat_id = c2.seat_id - 1 and c1.free = 1 and c2.free =1)


-- select distinct 
--     c1.seat_id
-- from cinema c1 
-- CROSS join cinema c2
-- WHERE abs(C1.seat_id-c2.seat_id)=1
-- and c1.free=1 and c2.free=1
