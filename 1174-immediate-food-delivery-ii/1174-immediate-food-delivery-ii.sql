/* Write your T-SQL query statement below */
WITH cte_first_order
     AS (SELECT DISTINCT delivery_id,
                         customer_id,
                         order_date,
                         Min(order_date)
                           OVER (
                             partition BY customer_id
                             ORDER BY order_date) first_order,
                         CASE
                           WHEN order_date = customer_pref_delivery_date THEN
                           'Y'
                           ELSE 'N'
                         END                      AS immediate_order_flag
         FROM   delivery)
SELECT CASE
         WHEN Count(1) = 0 THEN 0.00
         ELSE Cast(Sum(CASE
                         WHEN immediate_order_flag = 'Y' THEN 1.00
                         ELSE 0
                       END) * 100 / Count(1) AS DECIMAL(5, 2))
       END AS immediate_percentage
FROM   cte_first_order c
WHERE  c.order_date = c.first_order 