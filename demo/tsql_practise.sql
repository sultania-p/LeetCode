select * from [dbo].[Employee]
begin
	begin try
		declare @employee_name varchar(20)
		declare @exp_years int
		declare @proficiency varchar(10)
		declare @id int = 1

		while @id <=2
			begin
				select @employee_name=name,
						@exp_years=experience_years	
				from  [dbo].[Employee]
				where employee_id=@id;
					if @exp_years < 1
						begin
							set @proficiency = 'Fresher'
						end
					else if @exp_years between 1 and 5
						begin 
							set @proficiency = 'Mid Senior'
						end
					else
						begin
							set @proficiency = 'Executive'
						end
				--print @employee_name + 'is a ' + @proficiency + ' employee'
				print @employee_name + ' has employee id - ' + @id
				set @id+=1
			end
	end try
	begin catch
		select
			@@ERROR as Error,
			ERROR_LINE() as ErrorLine,
			ERROR_NUMBER() as ErrorNumber,
			ERROR_MESSAGE() as ErrorMessage,
			ERROR_PROCEDURE() as ErrorProcedure,
			ERROR_SEVERITY() as ErrorSeverity,
			ERROR_STATE() as ErrorState;
	End catch
end
go


---
BEGIN TRY
	select 1/0;
END TRY
BEGIN CATCH
	select
		@@ERROR as Error,
		ERROR_LINE() as ErrorLine,
		ERROR_NUMBER() as ErrorNumber,
		ERROR_MESSAGE() as ErrorMessage,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_SEVERITY() as ErrorSeverity,
		ERROR_STATE() as ErrorState;
END CATCH

----
-- Transaction with Commit and Rollback
-- Transaction with SavePoint ( Commit and Rollback Included)
drop table Customer
create table Customer (id int, name varchar(20))
insert into Customer values (1, 'Mark'), (2, 'Jim')

select * from Customer
---
begin transaction 
	delete from Customer where id = 2;
	print @@trancount
	commit
--
Begin Transaction
	save transaction s1
		delete from Customer where customer_id=2
		PRINT @@trancount

	save transaction s2
		delete from Customer where customer_id=1

	rollback transaction s2
	commit
end
--
-- Cursor - Update or select record one by one from a table
-->> Declare Cursor -> Open -> Fetch (Pointer) -> Close (Terminate the cursor) -> Deallocate
create table tbl_employees
(
	EmpId int,
	FirstName varchar(20),
	Salary numeric(20,2),
	Department int
);
INSERT INTO tbl_employees values 
									(1, 'Jack', 2000, 10),
									(2, 'Kate', 3000, 20),
									(3, 'Mark', 4000, 30),
									(4, 'Piyush', 10000, 30),
									(5, 'Samual', 6000, 30);

select * from tbl_employees

begin
	declare @id int
	declare @name varchar(20)
	declare @salary numeric(20,2)

	declare empcur cursor for
		select EmpId, FirstName, Salary from tbl_employees where Department = 30;
	open empcur;
	fetch next from empcur into @id, @name, @salary;
	while @@FETCH_STATUS = 0
		begin
			print @name + ' earns ' + cast(@salary as varchar)
			fetch next from empcur into @id, @name, @salary;
		end
	close empcur;
	deallocate empcur;
end

-- 
--Stored Procedure - Using Input and Output Paramters
alter procedure sp_SampleEmpProc @empid int, @name varchar(20) output, @salary numeric(10,2) output 
as
begin
	select @name = FirstName, @salary = Salary
	from tbl_employees
	where EmpId = @empid;
end;

begin
	declare @empname varchar(20);
	declare @empsalary numeric(10,2);
	
	exec sp_SampleEmpProc 1, @empname output, @empsalary output
	print @empname + ' earns salary of ' + cast(@empsalary as varchar)
	
end

---
--Functions - Must return a value, Cannot have expcetoinal handling, Can have Select and Group
create function fn_SampleAmount (@amount numeric(10,2)) returns numeric(10,2)
as
begin
	return @amount * 0.1
end;

begin
	select	EmpId, FirstName, Salary, dbo.fn_SampleAmount(Salary) as TaxAmount
	from tbl_employees
end

--
-- Triggers- Donot need to invoke, rather called implicitly
-- WHen DDL, DML, Login etc happen triggers are invoked
-- Magic Tables-- Inserted and Deleted
select * from tbl_employees

alter trigger EmpSalCheck on tbl_Employees for update
as
begin
	declare @oldsalary numeric(10,2)
	declare @newsalary numeric(10,2)

	select @oldsalary = Salary from deleted
	select @newsalary = Salary from inserted

	if @oldsalary > @newsalary
		begin
			print 'Old Salary (' + cast(@oldsalary as varchar) + ')' + 'cannot be greater than new salary (' + cast(@newsalary as varchar) + ')' 
			rollback;
		end
end

update tbl_employees set Salary = Salary + 1 

create trigger DeleteCheck on tbl_Employees for delete
as
begin
	declare @count int;

	select @count = count(*) from deleted

	if @count > 1
		begin
			print 'Cannot delete more than 1 record at a time'
			Rollback
		end
end

delete from tbl_employees

alter trigger InsertCheck on tbl_Employees for insert
as
begin
	declare @count int;

	select @count = count(*) from inserted where Department <= 0
	if @count >= 1
		begin
			print 'Cannot insert department with invalid department id'
			rollback;
		end
end

insert into tbl_employees values (6, 'Test', '1000', 40)

select * from employee