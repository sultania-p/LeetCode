

/*
Assume you are given the table below on Uber transactions made by users. Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.
*/


with cte_tran as  (
  SELECT
    *, row_number() over(PARTITION BY user_id order by transaction_date) as rn
  FROM transactions
)
select user_id, spend, transaction_date from cte_tran 
where rn = 3

-- select * from transactions;