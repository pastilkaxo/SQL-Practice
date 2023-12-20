-- 1:
--1.1
use UNIVER 
go 
create procedure PSSUBJECT as
begin
declare @n int = (select count(*) from SUBJECT)
select SUBJECT.SUBJECT [���] , SUBJECT.SUBJECT_NAME [����������], SUBJECT.PULPIT [�������] 
from SUBJECT
return @n
end;
go
declare @c int;
exec  @c = PSSUBJECT;
print '���-�� ����� ���. ������: ' + cast(@c as varchar(5));

-- drop procedure PSSUBJECT

-- ��� ���� ��

use �����������_�����_2
go
create procedure PSITEMS as 
begin select ITEMS.Item_Name [�������] , ITEMS.Cost [���� ��������] 
from ITEMS
end
go
declare @ci int = (select count(*) from ITEMS)
exec PSITEMS
print '���-�� �����: ' + cast(@ci as varchar(5));
-- 2 

USE UNIVER
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure PSSUBJECT  @p varchar(20) = null , @k int output as
begin
set @p = '����'
set @k = (select count(*) from SUBJECT where SUBJECT.PULPIT = @p)
select SUBJECT.SUBJECT [���] , SUBJECT.SUBJECT_NAME [����������], SUBJECT.PULPIT [�������] 
from SUBJECT 
where SUBJECT.PULPIT = @p
end;

declare @b int , @l int;
exec @b = PSSUBJECT @k=@l output; 
print '���-�� ����� ���. ������(2): ' + cast(@l as varchar(5));
go



-- ��� ���� ��

use �����������_�����_2
go
create procedure PSITEMS2 as 
begin select ITEMS.Item_Name [�������] , ITEMS.Cost [���� ��������] 
from ITEMS
end
go
declare @ci2 int = (select count(*) from ITEMS)
exec PSITEMS2
print '���-�� �����: ' + cast(@ci2 as varchar(5));

-- 3:
USE UNIVER
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure PSSUBJECT  @p varchar(20) = null  as
begin
set @p = '����'
declare @k varchar(10);
set @k = (select count(*) from SUBJECT where SUBJECT.PULPIT = @p)
select SUBJECT.SUBJECT [���] , SUBJECT.SUBJECT_NAME [����������], SUBJECT.PULPIT [�������] 
from SUBJECT 
where SUBJECT.PULPIT = @p
end;
go

use tempdb
create table #SUBJECT ( 
SUBJECT varchar(20) primary key ,
SUBJECT_NAME varchar(100),
PULPIT varchar(20) 
)
go
use UNIVER
insert #SUBJECT exec PSSUBJECT;

select * from #SUBJECT
drop table #SUBJECT
go


-- ��� ���� ��

use �����������_�����_2
go
create procedure PSITEMS3 as 
begin select ITEMS.Item_Name [�������] , ITEMS.Cost [���� ��������] 
from ITEMS
end
go
declare @ci3 int = (select count(*) from ITEMS)
exec PSITEMS3
print '���-�� �����: ' + cast(@ci3 as varchar(5));

-- 4:

use UNIVER
go
create procedure PAUDITORIUM_INSERT 
@a char(20),@n varchar(50),@c int = 0,@t char(10) as 
begin try
insert into AUDITORIUM(AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY,AUDITORIUM_TYPE)
values(@a,@n,@c,@t)
return 1
end try
begin catch
print 'err num: ' + cast(error_number() as varchar(6));
print 'err msg: ' + error_message();
print 'err level: ' + cast(error_severity() as varchar(6));
if ERROR_PROCEDURE() is not null 
print 'ERROR: ' + error_procedure();
return -1 
end catch;
go
delete AUDITORIUM where AUDITORIUM = '227-1'
declare @cn int;
exec @cn = PAUDITORIUM_INSERT @a = '227-1' , @n = '227-1', @c = 10,@t = '��'
print 'err num: ' + cast(@cn as varchar(10));

select * from AUDITORIUM
drop procedure PAUDITORIUM_INSERT
go


-- ��� ���� ��

use �����������_�����_2
go
create procedure PSITEMS4 as 
begin select ITEMS.Item_Name [�������] , ITEMS.Cost [���� ��������] 
from ITEMS
end
go
declare @ci4 int = (select count(*) from ITEMS)
exec PSITEMS4
print '���-�� �����: ' + cast(@ci4 as varchar(5));

-- 5:

use UNIVER 
go
create procedure SUBJECT_REPORT @p char(10)as
begin try 
declare @nz char(20), @t char(300) = '',@n int = 0;
declare SubjectDitst cursor for 
select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p;
open SubjectDitst
fetch SubjectDitst into @nz;
print '����������: ';
while @@FETCH_STATUS = 0
begin 
set @t = RTRIM(@nz) + ', ' + @t
fetch SubjectDitst into @nz
end 
print @t;
close SubjectDitst;
deallocate SubjectDitst;
set @n = (select count(SUBJECT.SUBJECT) from SUBJECT where SUBJECT.PULPIT = @p) 
return @n;
end try 
begin catch
if not exists (select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p)
 print '������ � ����������' + error_procedure();
return -1;
end catch

declare @rc int;
exec @rc = SUBJECT_REPORT @p='����';
print 'count total: ' + cast(@rc as varchar(10));

drop procedure SUBJECT_REPORT
go





-- ��� ���� ��

use �����������_�����_2
go
create procedure PSITEMS5 as 
begin select ITEMS.Item_Name [�������] , ITEMS.Cost [���� ��������] 
from ITEMS
end
go
declare @ci5 int = (select count(*) from ITEMS)
exec PSITEMS5
print '���-�� �����: ' + cast(@ci5 as varchar(5));
-- 6:


use UNIVER
go
create procedure PAUDITORIUM_INSERT 
@a char(20),@n varchar(50),@c int = 0,@t char(10) as 
begin try
insert into AUDITORIUM(AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY,AUDITORIUM_TYPE)
values(@a,@n,@c,@t)
return 1
end try
begin catch
print 'err num: ' + cast(error_number() as varchar(6));
print 'err msg: ' + error_message();
print 'err level: ' + cast(error_severity() as varchar(6));
if ERROR_PROCEDURE() is not null 
print 'ERROR: ' + error_procedure();
if @@TRANCOUNT > 0 rollback tran;
return -1 
end catch;
go
create procedure PAUDITORIUM_INSERTX @a char(20),@n varchar(50),@c int = 0,@t char(10), @tn varchar(50)
as 
begin try
set transaction isolation level SERIALIZABLE;          
begin tran
insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME)
values (@t , @tn)
exec PAUDITORIUM_INSERT @a , @n , @c,@t 
commit tran
return 1;
end try 
begin catch
    print '����� ������  : ' + cast(error_number() as varchar(6));
    print '���������     : ' + error_message();
    print '�������       : ' + cast(error_severity()  as varchar(6));
 if ERROR_PROCEDURE() is not null 
print '��� ��������� : ' + error_procedure();
 return -1;
end catch
go
delete AUDITORIUM where AUDITORIUM = '229-1'
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE.AUDITORIUM_TYPE = '���'
declare @rc int ;
exec @rc = PAUDITORIUM_INSERTX @a = '229-1' , @n = '229-1', @c = 10,@t = '���',@tn = '����������'
print 'err num: ' + cast(@rc as varchar(10));

select * from AUDITORIUM

go
drop procedure PAUDITORIUM_INSERT
drop procedure PAUDITORIUM_INSERTX
go

-- 8:

use UNIVER
go
create procedure PRINT_REPORT @f char(10) = null , @p char(10) = null
as 
begin
    begin try
        declare @n int;
		declare @selected_p char(100) = '';
        if @f is not null and @p is null
        begin 
	        set @selected_p = (select STRING_AGG(SUBSTRING(rtrim(PULPIT),1,4),',')
                               from PULPIT 
                               where PULPIT.FACULTY = @f);
            set @n = (select count(PULPIT.PULPIT) from PULPIT where PULPIT.FACULTY = @f);
			print '���������: ' + isnull(@f,'none');
			print '�������: ' + @selected_p
            print '���������� ������(1): ' + cast(@n as varchar(10));
        end
        if @f is not null and @p is not null
        begin
			set @selected_p = rtrim(@p) + ', ' + @selected_p
            set @n = (select count(PULPIT.PULPIT) from PULPIT where PULPIT.FACULTY = @f);
			print '���������: ' + isnull(@f,'none');
			print '�������: ' + @selected_p
            print '���������� ������(2): ' + cast(@n as varchar(10));
        end

        if @f is null and @p is not null 
        begin
	         set @f = (select PULPIT.FACULTY from PULPIT where PULPIT.PULPIT = @p)
            set @n = (select count(PULPIT.PULPIT) from PULPIT where PULPIT.FACULTY = @f);
			print '���������: ' + isnull(@f,'none');
			set @selected_p = rtrim(@p) + ', ' + @selected_p
			print '�������: ' + isnull(@selected_p,'none');
            print '���������� ������(3): ' + cast(@n as varchar(10));
        end
    end try
    begin catch
	 if @p is not null and  not exists (select PULPIT.PULPIT from PULPIT where PULPIT.PULPIT = @p)
	 begin
	  print '������ � ����������: '
	end
	 print 'err num: ' + cast(error_number() as varchar(6));
     print 'err msg: ' + error_message();
     print 'err level: ' + cast(error_severity() as varchar(6));
     if ERROR_PROCEDURE() is not null 
       print '������ � ����������: ' + error_procedure();
     return -1
    end catch
end
go

exec PRINT_REPORT @f='��', @p =  null;

select * from PULPIT where PULPIT.FACULTY = '���'

drop procedure PRINT_REPORT