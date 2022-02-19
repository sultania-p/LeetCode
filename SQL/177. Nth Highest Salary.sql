-- 177. Nth Highest Salary 

/*Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

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
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+

*/

CREATE or Alter FUNCTION getNthHighestSalary (@N INT) 
RETURNS INT AS
BEGIN

        /* Write your T-SQL query statement below. */
		declare @salary int
		
        If @N = 1
            begin
            SET  @salary = (select max(salary) from employee)
            end 
        else if @N = 2
            begin
            set @salary = (select max(salary) from employee where salary < (select max(salary) from employee)  )      
            end
return @salary

END;

select [dbo].[getNthHighestSalary](3) as getNthHighestSalary 