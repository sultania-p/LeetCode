/* Write your T-SQL query statement below */
with cte_subtasks as 
(
	select task_id, 1 as subtask_id from tasks
	UNION ALL
	select task_id, subtask_id + 1 from cte_subtasks T1 where subtask_id < (select subtasks_count from Tasks T2 where T1.task_id=T2.task_id)
)
select * 
from cte_subtasks c1 where c1.subtask_id not in (select subtask_id from Executed C2 where c1.task_id=c2.task_id)
order by 1, 2