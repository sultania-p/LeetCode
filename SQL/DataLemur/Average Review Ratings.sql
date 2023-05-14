/*
Given the reviews table, write a query to get the average stars for each product every month.

The output should include the month in numerical value, product id, and average star rating rounded to two decimal places. Sort the output based on month followed by the product id.
*/


-- Method -1
with cte_rating as 
( SELECT
    date_part('month', submit_date) as mth,
    product_id,
    stars
  FROM reviews
)
select distinct mth, product_id,
  round(avg(stars) over (PARTITION BY mth, product_id), 2) as avg_stars
from cte_rating
order by 1, 2


-- Method-2
select 
  EXTRACT(month from submit_date), 
  product_id,
  round(avg(stars), 2) as avg_stars
from reviews
group by EXTRACT(month from submit_date), product_id
order by 1, 2
