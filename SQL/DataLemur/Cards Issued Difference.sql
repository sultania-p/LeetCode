
/*
Your team at JPMorgan Chase is soon launching a new credit card, and to gain some context, you are analyzing how many credit cards were issued each month.

Write a query that outputs the name of each credit card and the difference in issued amount between the month with the most cards issued, and the least cards issued. Order the results according to the biggest difference.
*/


select card_name, (max_card - min_card) as difference
from 
(SELECT
  card_name,
  MAX(issued_amount) as max_card,
  MIN(issued_amount) as min_card
FROM monthly_cards_issued
group by card_name
) sq order by 2 DESC