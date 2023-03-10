/*
Write a query to find the top 2 power users who sent the most messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending count of the messages.

Assumption:

No two users has sent the same number of messages in August 2022.
*/

select sender_id, count(1) message_count from
(
  SELECT
    sender_id,
    message_id
  FROM messages
  where date_part('month', sent_date) = 8 and date_part('year', sent_date) = 2022
) sq group by sender_id order by 2 desc limit 2