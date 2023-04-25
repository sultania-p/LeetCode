/*

Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".

Return the result table in any order.

The query result format is in the following example.
*/

/* Write your T-SQL query statement below */

select name
from salesperson
where sales_id not in (
    select 
        o.sales_id
    from
    orders o where com_id in (select com_id from company where name = 'RED')
)