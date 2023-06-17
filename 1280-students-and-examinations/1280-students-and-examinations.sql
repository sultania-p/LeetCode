/* Write your T-SQL query statement below */
with cte_sub_available as 
(
	select 
		student_id,
		subject_name,
		count(1) as attended_exams
	from
		Examinations e
	group by student_id, subject_name
)
select 
	s.student_id,
	s.student_name,
	sb.subject_name,
	isnull(c.attended_exams, 0) as attended_exams
from Students s
cross join Subjects sb
left join cte_sub_available c on s.student_id=c.student_id and sb.subject_name=c.subject_name
order by 	s.student_id, sb.subject_name