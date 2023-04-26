Create table  Seat (id int, student varchar(255))
Truncate table Seat
insert into Seat (id, student) values ('1', 'Abbot')
insert into Seat (id, student) values ('2', 'Doris')
insert into Seat (id, student) values ('3', 'Emerson')
insert into Seat (id, student) values ('4', 'Green')
insert into Seat (id, student) values ('5', 'Jeames')

select * from Seat

with cte_seat as (
	select id, case when id % 2 <>0 then id+1 else id-1 end as new_id
			,student from seat)
select
	s1.id,
		case when s2.student is null then s1.student else s2.student end as student
from cte_seat s1
left join seat s2 on s1.new_id = s2.id;

-- Alternative// using window function
select id,
		case when id % 2<>0 then r_next else r_prev end as student
from (
	select 
		id, student, 
		lead(student, 1, student) over ( order by id) as r_next,
		lag(student, 1, student) over ( order by id) as r_prev
	from Seat
) sq
