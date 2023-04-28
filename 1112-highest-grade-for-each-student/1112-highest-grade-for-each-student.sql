/* Write your T-SQL query statement below */
select student_id, min(course_id) as course_id, grade
	from (
	select 
		student_id,
		course_id,
		grade,
		dense_rank() over (partition by student_id order by grade desc) rn
	from Enrollments e
	) sq where sq.rn=1 group by student_id, grade
	order by 1 asc