/* Write your T-SQL query statement below */
with cte_tournament as (
	select tournament, player_id 
	from
	(	select
			wimbledon,
			fr_open,
			US_open,
			Au_open
		from Championships
	) P
	UNPIVOT
	(
		player_id for tournament in (wimbledon, fr_open, US_open, Au_open)
	) as upvt
) 
select 
	C.player_id,
	player_name,
	count(1) as grand_slams_count 
from cte_tournament C
join Players P on C.player_id=P.player_id
group by C.player_id, player_name