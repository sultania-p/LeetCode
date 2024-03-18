

/*
CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find the total sales of drugs for each manufacturer. Round your answer to the closest million, and report your results in descending order of total sales.

Because this data is being directly fed into a dashboard which is being seen by business stakeholders, format your result like this: "$36 million".
*/



SELECT 
  manufacturer,
  '$' || (ROUND(sum(total_sales) / 1000000)::text) || ' million' as sale
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) desc
