/* Write your T-SQL query statement below */
with cte_tournament as (
	select
		year, Wimbledon as player_id
	from Championships 
	UNION ALL
	select
		year, Fr_open as player_id
	from Championships 
	UNION ALL
	select
		year, US_open as player_id
	from Championships 
	UNION ALL
	select
		year, Au_open as player_id
	from Championships
)
select 
	C.player_id,
	player_name,
	count(1) as grand_slams_count 
from cte_tournament C
join Players P on C.player_id=P.player_id
group by C.player_id, player_name