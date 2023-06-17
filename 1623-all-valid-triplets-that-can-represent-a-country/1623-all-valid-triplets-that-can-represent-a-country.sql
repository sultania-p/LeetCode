/* Write your T-SQL query statement below */

select
	A.student_name as member_A,
	B.student_name as member_B,
	C.student_name as member_C
from SchoolA A
cross join SchoolB B
cross join SchoolC C
where (A.student_id <> B.student_id and B.student_id <> C.student_id and C.student_id <> A.student_id)
and (A.student_name <> B.student_name and B.student_name <> C.student_name and C.student_name <> A.student_name)
