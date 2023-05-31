/* Write your T-SQL query statement below */

with cte as (
	select
		AStart.machine_id,
		AStart.process_id,
		AStart.timestamp as timestamp_start,
		AEnd.timestamp as timestamp_end,
		AEnd.timestamp - AStart.timestamp as processing_time 
	from Activity AStart
	inner join Activity AEnd on AStart.machine_id=AEnd.machine_id and AStart.process_id=AEnd.process_id and AStart.activity_type<>AEnd.activity_type and AStart.timestamp<AEnd.timestamp
)
select
	machine_id,
	cast(ROUND(SUM(processing_time) * 1.00 / count(process_id), 3) as decimal(5, 3)) as processing_time 
from cte
group by machine_id