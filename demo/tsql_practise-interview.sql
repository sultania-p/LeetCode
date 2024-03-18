
-- Print all the employee name with empno less than or euqal to 15000
begin
	declare @emp_no int = 15000
	declare @emp_name varchar(50)
	
	while @emp_no <= 15005
		begin
			select
				@emp_no= emp_no,
				@emp_name = emp_fname + emp_lname
			from employee
			where emp_no= @emp_no

			print 'employee id - ' + cast(@emp_no as varchar(10)) + ' has name: ' + @emp_name

			set @emp_no +=1
		end
end

-- adding column
alter table employee add salary int;
update employee set salary = 5000 where dept_no = 'D5'

-- exception handling
begin try
	update employee set salary = 'qwe' where emp_no = 15000
end try

begin catch
	select 
		@@ERROR as error,
		ERROR_LINE() ,
		ERROR_MESSAGE(),
		ERROR_SEVERITY()
end catch

-- create proocedure to get department wise total salary
alter procedure dept_salary @dept char(4), @salary int output
as
begin
		select
			@dept = dept_no,
			@salary = sum(salary)
		from employee
		where dept_no = @dept
		group by dept_no
end

begin
	declare @dept_no char(4) = 'D2';
	declare @salary_total int;

	exec dept_salary @dept_no, @salary_total output
	print 'Department - ' + @dept_no + ' has total salary of ' + cast(@salary_total as varchar(30))
end

-- create procedure to get particular employee
alter procedure sp_GetEmployee (@emp_no int)
as
begin
	select * from employee where emp_no = @emp_no
end

exec sp_GetEmployee @emp_no = 15001

-- create function // scalar and table valued
create function fn_emp_tax (@salary int) returns numeric(10,2)
as
begin
	return @salary * 1.00 * 0.10
end;

begin
	select emp_no, emp_fname + emp_lname as full_name, dbo.fn_emp_tax(salary) as tax  from employee;
end

-- table valued function
create function fn_dept_D1 (@dept_no char(4)) returns table
as
return 
	select * from employee where dept_no = @dept_no

select * from dbo.fn_dept_D1('D2')

select * from employee

-- nocount - supress the row affected count in console
-- encyption - encrypts the statement or script of the procedure
create or alter procedure sp_proc @input int, @output output
with encryption
as
begin
	set nocount on
	-- write logic....

end

-- rename proc
sp_rename 'old_proc_name', 'new_proc_name'

begin transaction
save transaction sp_1
delete  from employee where id=1

save transaction sp_2
delete  from employee where id=2

rollback transaction sp2
--->> only id=1 is deleted

---'

use sample;
GO

CREATE TABLE DB_Errors
         (ErrorID        INT IDENTITY(1, 1),
          UserName       VARCHAR(100),
          ErrorNumber    INT,
          ErrorState     INT,
          ErrorSeverity  INT,
          ErrorLine      INT,
          ErrorProcedure VARCHAR(MAX),
          ErrorMessage   VARCHAR(MAX),
          ErrorDateTime  DATETIME)
GO

select * from employee
select * from dbo.DB_Errors

alter procedure sp_errohandling 
	@empno int
as 
SET NOCOUNT ON
	begin try
		IF (select count(*) from employee where emp_no = @empno) = 0
			RAISERROR ('EMployee id does not exist', 11, 1)
		
	end	try

	begin catch
		insert into dbo.DB_Errors 
		values (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
		);

		declare @errormessage varchar(50) = ERROR_MESSAGE()
		declare @errorseverity int = ERROR_SEVERITY()
		declare @errorstate int = ERROR_STATE()

		raiserror (@errormessage, @errorseverity, @errorstate)

	end catch
GO

exec sp_errohandling 15455

/*  -- in catch block

	if XACT_STATE() = -1	-- error in commit transaction
		rollback transaction
	if XACT_STATE() = 1		-- commit success
		commit transaction
*/

select format(getdate(), 'MM/dd/yyyy') as dateformated
select format(123, 'C', 'en-us')	-- culture

-- N' make sure the string is used as Unicode string.. National Language Character Set
select * from employee where emp_fname = N'John'

select format(cast('07:35' as time), N'hh\:mm')
select format(SYSDATETIME(), N'hh\:mm tt')

declare @string varchar(50) = 'Zebra'
select @string, CHARINDEX('z', @string , 0)	-- case insensitive search
select CHARINDEX('B', @string collate Latin1_General_CS_AS);	--case sensitive search
select CHARINDEX('B', @string collate Latin1_General_CI_AS);	--case insensitive search
--
declare @input varchar(50)
set @input = '     This uses Left and trim functions   '
select LEFT('ELephant', 3)
select @input, LTRIM(@input)
select RTRIM(@input)

declare @nstring nchar(8);
set @nstring = N'København';
select substring(@nstring, 2, 1)
select UNICODE(substring(@nstring, 2, 1))
select nchar(UNICODE(substring(@nstring, 2, 1)))

declare @pat varchar(30) = 'Interesting data'
select PATINDEX('%ter%', @pat)	-- returns index of first repeating pattern in the expression

select REPLACE('This is test' collate LATIN1_General_CI_AS, 'TES', 'xxx')	-- replace a set of characters found in sequence by some other string

select REPLICATE('0', 3) + 'T'	-- replicate a desired cahracter for n times
select DATALENGTH('Elephant1')	-- calculate length of string
select REVERSE('House')	-- revers a string
select 'Sultania' + ',' + SPACE(1) + 'Piyush'	-- repeats no of spaces

select str(123.45, 6, 1)	--Returns character data converted from numeric data. 

select STRING_AGG(convert(nvarchar(max), emp_fname), ',') from employee
select STRING_AGG(convert(nvarchar(max), emp_fname), char(13)) from employee
select STRING_AGG(convert(nvarchar(max), emp_fname), char(13) + char(10)) from employee

-- char(13) -- carriage return brings the cursor to beginning of current line
-- adding char(10) to char(13) crete new line sequence CRLF (Line Feed)
select STUFF('Information', 3, 4, 'QWERTY')

select emp_no, salary,
	LEAD(salary, 1, 0) over (order by emp_no) as sal_lead
from employee

select emp_no, salary, sum(salary) over (order by emp_no) from employee