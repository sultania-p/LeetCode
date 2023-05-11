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

select * from Customer

Begin Transaction
	save transaction s1
		delete from Customer where customer_id=2
		PRINT @@trancount

	save transaction s2
		delete from Customer where customer_id=1

	rollback transaction s2
	commit

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