create table employee 
   (
   id int,
   salary int
   );

   insert into employee values (1, 100);
      insert into employee values (2, 200);
	     insert into employee values (3, 300);
   select * from employee;
   delete from employee where id in (2,3)

IF exists
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

select max(Salary) as SecondHighestSalary from Employee where Salary not in (select max(Salary) from Employee)

        /*
		If @N = 1
            begin
            SET  @salary = (select max(salary) from employee)
            end 
        else if @N = 2
            begin
            set @salary = (select max(salary) from employee where salary < (select max(salary) from employee)  )      
            end
			*/