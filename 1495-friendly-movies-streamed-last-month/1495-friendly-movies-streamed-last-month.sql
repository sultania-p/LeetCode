/* Write your T-SQL query statement below */
select 
	distinct title
from TVProgram T
join (
	select
		content_id,
		title
	from Content
	where Kids_content='Y' and content_type='Movies'
) C on cast(T.content_id as varchar(30)) = C.content_id
where program_date between '2020-06-01' and '2020-06-30'