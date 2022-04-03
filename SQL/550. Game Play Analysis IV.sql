/*
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, 
rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least 
two consecutive days starting from their first login date, then divide that number by the total number of players.

The query result format is in the following example.

insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5')
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-02', '6')
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-04', '2')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-05', '12')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-06', '7')
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-26', '17')
*/
---
select date(event_date)+1 from Activity;

select cast(user_cnt_login_nxt_day*1.0/total_users as decimal(3,2)) as fraction from 
(
select count(distinct A1.player_id) as user_cnt_login_nxt_day, (select count(distinct player_id) from Activity) as total_users
from Activity A1
Inner Join Activity A2 on A2.event_date = dateadd(dd, 1, A1.event_date) and A1.player_id = A2.player_id
) main


--select ROUND(COUNT(DISTINCT A2.player_id) *1.0/ COUNT(DISTINCT A1.player_id), 2) AS "fraction"
--from Activity A1
--LEFT Join 
--	(select player_id, min(event_date) as first_date from Activity group by player_id) A2
--	on datediff(dd, A1.event_date, A2.first_date)=1 and A1.player_id = A2.player_id

