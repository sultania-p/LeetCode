Create table Employee (id int, company varchar(255), salary int)
DROP table Employee
insert into Employee (id, company, salary) values ('1', 'A', '2341')
insert into Employee (id, company, salary) values ('2', 'A', '341')
insert into Employee (id, company, salary) values ('3', 'A', '15')
insert into Employee (id, company, salary) values ('4', 'A', '15314')
insert into Employee (id, company, salary) values ('5', 'A', '451')
insert into Employee (id, company, salary) values ('6', 'A', '513')
insert into Employee (id, company, salary) values ('7', 'B', '15')
insert into Employee (id, company, salary) values ('8', 'B', '13')
insert into Employee (id, company, salary) values ('9', 'B', '1154')
insert into Employee (id, company, salary) values ('10', 'B', '1345')
insert into Employee (id, company, salary) values ('11', 'B', '1221')
insert into Employee (id, company, salary) values ('12', 'B', '234')
insert into Employee (id, company, salary) values ('13', 'C', '2345')
insert into Employee (id, company, salary) values ('14', 'C', '2645')
insert into Employee (id, company, salary) values ('15', 'C', '2645')
insert into Employee (id, company, salary) values ('16', 'C', '2652')
insert into Employee (id, company, salary) values ('17', 'C', '65')

WITH cte as
(
	select id, company, salary, 
	ROW_NUMBER() over (partition by company order by salary asc) as rn,
	count(*) over(partition by company) as tot_cnt
	from Employee
)

select company, salary
from cte 
where rn = 
	case tot_cnt%2 when 0	then cast(tot_cnt/2 as int) 
							else cast((tot_cnt/2) as int)+1 
							end
group by company, salary


--WITH people as
--(
--    SELECT
--        company,
--        COUNT(id) as ct,
--        IIF(COUNT(id) % 2 = 1, FLOOR(COUNT(id)/2) + 1, COUNT(id)/2 ) as get1,
--        IIF(COUNT(id) % 2 = 1, NULL, COUNT(id)/2 + 1 ) as get2
--    FROM Employee
--    GROUP BY company
--),
---- Use row_number to order the rows based on salary DESC (also ID desc is required, even if not specified in the problem)
--ranking AS
--(
--    SELECT *, ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary DESC, id DESC) as ranked
--    FROM Employee
--)
---- From people, select only matching company and ranking = one of the two median indexes
--SELECT r.id, r.company, r.salary
--FROM ranking as r
--INNER JOIN people as p
--    ON r.company = p.company AND (r.ranked = p.get1 OR r.ranked = p.get2)