-- Team Scores in Football Tournament

-- Write your MySQL query statement below
with cte as
(
select host_team,
case
when host_goals>guest_goals then 3
when host_goals=guest_goals then 1
else 0
end as num_points
from Matches

UNION ALL

select guest_team,
case
when host_goals<guest_goals then 3
when host_goals=guest_goals then 1
else 0
end as num_points

from Matches
)

select team_id, team_name , IFNULL(sum(num_points),0) as num_points from Teams t
left join cte a
on a.host_team=t.team_id

group by team_id
order by num_points desc, team_id asc
 

-- Tournament Winners
select group_id, player_id from (
	select p.group_id, ps.player_id, sum(ps.score) as score from Players p,
	    (select first_player as player_id, first_score as score from Matches
	    union all
	    select second_player, second_score from Matches) ps
	where p.player_id = ps.player_id
	group by ps.player_id order by group_id, score desc, player_id) top_scores
group by group_id


--Monthly Transactions I

SELECT DATE_FORMAT(trans_date, '%Y-%m') month,
       country,
       COUNT(state) trans_count,
       SUM(state = 'approved') approved_count,
       SUM(amount) trans_total_amount,
       SUM(IF(state = 'approved', amount, 0)) approved_total_amount
FROM transactions
GROUP BY 1, 2

--Last Person to Fit in the Bus
With cte as
(
select turn, person_id as id, person_name, weight, sum(weight) over (order by turn) as Total_Weight   from Queue
) 

Select person_name from cte
Where Total_Weight=(select Max(Total_Weight) from cte where Total_Weight<=1000 )
