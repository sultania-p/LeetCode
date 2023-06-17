/* Write your T-SQL query statement below */

	select
		M.employee_id,
		M.name,
		count(1) as reports_count,
		cast(ROUND(avg(E.age * 1.00), 0) as int) as average_age 
	from Employees E
	left join Employees M on M.employee_id = E.reports_to
	where M.employee_id is not null
	group by M.employee_id, M.name
	order by M.employee_id