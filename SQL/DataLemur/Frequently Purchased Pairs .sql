
/*
Assume you are given the following tables on Walmart transactions and products. Find the number of unique product combinations that are purchased in the same transaction.

For example, if there are 2 transactions where apples and bananas are bought, and another transaction where bananas and soy milk are bought, my output would be 2 to represent the 2 unique combinations.

Assumptions:

For each transaction, a maximum of 2 products is purchased.
You may or may not need to use the products table.
*/



SELECT 
  count(distinct concat(t1.product_id, t2.product_id)) as unique_pairs
FROM transactions t1
join transactions t2 
  on t1.transaction_id = t2.transaction_id
  and t1.product_id > t2.product_id




