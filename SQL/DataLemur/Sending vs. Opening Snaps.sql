/*
Assume you are given the tables below containing information on Snapchat users, their ages, and their time spent sending and opening snaps. Write a query to obtain a breakdown of the time spent sending vs. opening snaps (as a percentage of total time spent on these activities) for each age group.

Output the age bucket and percentage of sending and opening snaps. Round the percentage to 2 decimal places.

Notes:

You should calculate these percentages:
time sending / (time sending + time opening)
time opening / (time sending + time opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.*/
with cte_snaps as (
  select 
      age_bucket,
      sum(case when activity_type='open' then time_spent else 0 end) as timespent_open,
      sum(case when activity_type='send' then time_spent else 0 end) as timespent_send
    FROM activities a 
    join age_breakdown ab on a.user_id = ab.user_id
    where activity_type <> 'chat'
    group by age_bucket
)
select 
  age_bucket,
  ROUND((timespent_send / (timespent_open + timespent_send)) * 100, 2) as send_perc,
  ROUND((timespent_open / (timespent_open + timespent_send)) * 100, 2) as open_perc
from cte_snaps