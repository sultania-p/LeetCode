/*

Assume you are given the table containing information on Amazon customers and their spending on products in various categories.

Identify the top two highest-grossing products within each category in 2022. Output the category, product, and total spend.

*/

with cte_items as (
  SELECT
    category,
    product,
    sum(spend) as total_spend,
    RANK() over(partition by category order by sum(spend) desc) as rn
  FROM product_spend
  where extract('year' from transaction_date)=2022
  group by category, product
)
select category, product, total_spend from cte_items
where rn <=2