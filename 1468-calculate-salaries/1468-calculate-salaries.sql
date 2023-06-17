/* Write your T-SQL query statement below */
with cte_tax_rate as (
	select
	company_id,
	case when max(salary) < 1000 then 0
		when max(salary) between 1000 and 10000 then 24
		else 49 end as tax_rate
	from Salaries 
	group by company_id
)
select 
	S.company_id,
	employee_id,
	employee_name,
	cast(ROUND(S.salary * 1.00 * (100 - tax_rate) / 100, 0) as integer) as salary
from Salaries S 
join cte_tax_rate C on S.company_id=C.company_id
