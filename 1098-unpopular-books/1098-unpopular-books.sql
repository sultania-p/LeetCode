/* Write your T-SQL query statement below */
select book_id, name
from books 
where datediff(month, available_from, '2019-06-23') >1 
and book_id not in (
	select 
		book_id
	from orders o
	where dispatch_date between dateadd(year, -1, '2019-06-23') and '2019-06-23'
	group by book_id
	having sum(quantity) >= 10
)