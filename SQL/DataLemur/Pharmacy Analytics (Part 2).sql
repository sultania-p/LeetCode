/*
CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find out which manufacturer is associated with the drugs that were not profitable and how much money CVS lost on these drugs. 

Output the manufacturer, number of drugs and total losses. Total losses should be in absolute value. Display the results with the highest losses on top.
*/

SELECT
  manufacturer,
  count(1) as durg_count,
  sum(cogs - total_sales) as total_loss
FROM pharmacy_sales
where cogs > total_sales
group by manufacturer
order by 3 desc;