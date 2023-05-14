/*
Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.
*/

SELECT user_id, date_part('day', last_post - first_post) as days_between
from (
  SELECT DISTINCT
    user_id,
    MIN(post_date) over (PARTITION BY user_id) as first_post,
    MAX(post_date) over (PARTITION BY user_id) as last_post
  FROM posts
  where date_part('year', post_date) = 2021
  group by user_id, post_date
) sq where date_part('day', last_post - first_post) > 0

-- select * from posts where user_id = 151325