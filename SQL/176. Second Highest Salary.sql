Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

--Solution:
/* Write your T-SQL query statement below */

-- Inside the row_number function partition by is not a mandatory function.
IF EXISTS
(
	select SQ.salary as SecondHighestSalary
	from 
		(
		select 
		id, salary, row_number() over(order by salary desc) rn
		from Employee
		) SQ where SQ.rn=2
) 

select SecondHighestSalary from 
    (select SQ.salary as SecondHighestSalary
        from 
            (
            select 
            id, salary, row_number() over(order by salary desc) rn
            from Employee
            ) SQ where SQ.rn=2
    ) q1

else select null as SecondHighestSalary

-- OR

select max(salary)  as SecondHighestSalary  from employee where salary < 
(
select max(salary) from employee
    )