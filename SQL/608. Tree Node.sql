/*
Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write an SQL query to report the type of each node in the tree.

Return the result table in any order.

The query result format is in the following example.*/


/* Write your T-SQL query statement below */

select 
    t1.id,
    case when t1.p_id is null then 'Root'
            when t1.id not in (select distinct p_id from tree where p_id is not null) then 'Leaf'
            else 'Inner'
    end as type 
from tree t1