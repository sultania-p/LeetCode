/* Write your T-SQL query statement below */
select '[0-5>' as bin, count(1) as total from  Sessions S where duration >=0 and duration < 300
UNION
select '[5-10>' as bin, count(1) as total from  Sessions S where duration >=300 and duration < 600
UNION
select '[10-15>' as bin, count(1) as total from  Sessions S where duration >=600 and duration < 900
UNION
select '15 or more' as bin, count(1) as total from  Sessions S where duration >=900