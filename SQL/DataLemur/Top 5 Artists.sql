
/*
Assume there are three Spotify tables containing information about the artists, songs, and music charts. Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times. From now on, we'll refer to this ranking number as "song appearances".

Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, but the rank of who has the most appearances). The order of the rank should take precedence.

For example, Ed Sheeran's songs appeared 5 times in Top 10 list of the global song rank table; this is the highest number of appearances, so he is ranked 1st. Bad Bunny's songs appeared in the list 4, so he comes in at a close 2nd.

Assumptions:

If two artists' songs have the same number of appearances, the artists should have the same rank.
The rank number should be continuous (1, 2, 2, 3, 4, 5) and not skipped (1, 2, 2, 4, 5).
*/



with cte_spotify_1 as 
( SELECT 
    artist_name,
    count(1) filter (where rank <= 10) as rank_cnt
  FROM global_song_rank gsr
  join songs s on gsr.song_id=s.song_id
  join artists a on a.artist_id=s.artist_id
  where gsr.rank<=10
  group by artist_name
), 
cte_spotify_2 as 
(
  select artist_name,
    dense_rank() over ( ORDER BY rank_cnt DESC) as artist_rank
  from cte_spotify_1
)
select * from cte_spotify_2 where artist_rank <= 5