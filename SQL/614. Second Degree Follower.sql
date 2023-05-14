Create table Follow (followee varchar(255), follower varchar(255))
Truncate table Follow
insert into Follow (followee, follower) values ('Alice', 'Bob')
insert into Follow (followee, follower) values ('Bob', 'Cena')
insert into Follow (followee, follower) values ('Bob', 'Donald')
insert into Follow (followee, follower) values ('Donald', 'Edward')

select * from Follow

select 
	followee as follower,
	count(1) as num
from Follow
where followee in (select follower from Follow)
group by followee
order by 1