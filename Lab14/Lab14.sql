-- 1:
use UNIVER
go 
create function COUNT_STUDENT(@f varchar(20)) returns int
as begin
declare @rc int = 0;
set @rc = (
select count(*) from STUDENT
inner join  GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP 
inner join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY
where GROUPS.FACULTY = @f);
return @rc
end;
go
declare @s int = dbo.COUNT_STUDENT('ТОВ');
print 'Колличество студентов на фк-те:' + cast(@s as varchar(10));
go
alter function COUNT_STUDENT(@f varchar(20) = null ,@p varchar(20) = null) 
returns int 
as begin
declare @rc int = 0;
set @rc = (
select count(*) from STUDENT
inner join  GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP 
inner join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY
inner join PULPIT on PULPIT.FACULTY = FACULTY.FACULTY
where GROUPS.FACULTY = @f and PULPIT.PULPIT = @p);
return @rc
end;
go
declare @s int = dbo.COUNT_STUDENT('ИТ','ИСиТ');
print 'Колличество студентов на фк-те:' + cast(@s as varchar(10));


-- 2:

use UNIVER
go
create function FSUBJECTS ( @p varchar(20)) returns varchar(300) 
as begin
declare @s varchar(20);
declare @ts varchar(300) = 'Дисциплины: ';
declare TotalSubjects cursor local static
for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p;
open TotalSubjects;
fetch TotalSubjects into @s
while @@FETCH_STATUS = 0 
begin
set @ts = @ts + ', ' + rtrim(@s);
fetch TotalSubjects into @s;
end
return @ts;
end;
go
select PULPIT , dbo.FSUBJECTS(PULPIT.PULPIT) from PULPIT

drop function dbo.FSUBJECTS

-- 3:
go
use UNIVER
go
create function FFACPUL (@fk varchar(20),@pk varchar(20)) returns table
as return
 select FACULTY.FACULTY , PULPIT.PULPIT from FACULTY  
left outer join PULPIT on FACULTY.FACULTY= PULPIT.FACULTY
where FACULTY.FACULTY = ISNULL(@fk,FACULTY.FACULTY)
and
PULPIT.PULPIT = isnull(@pk,PULPIT.PULPIT)
go
select * from dbo.FFACPUL(null,null)
select * from dbo.FFACPUL('ИТ',null)
select * from dbo.FFACPUL(null,'ЛМиЛЗ')
select * from dbo.FFACPUL('ИТ','ИСиТ')

drop function dbo.FFACPUL

-- 4:
use UNIVER
go
create function FCTEACHER(@pk varchar(20)) returns int 
as begin
declare @rc int = (select count(TEACHER.TEACHER) from TEACHER where TEACHER.PULPIT = isnull(@pk,TEACHER.PULPIT)) ;
return @rc
end;
go
select PULPIT , dbo.FCTEACHER(PULPIT.PULPIT) [Кол-во преподов] from PULPIT
select dbo.FCTEACHER(null) 
drop function dbo.FCTEACHER


-- 6:
use UNIVER
go
create function STUDENT_counter (@f varchar(20)) returns int 
as begin
declare @rc int = 0;
set @rc = (select count(STUDENT.IDSTUDENT) from STUDENT
inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP and 
GROUPS.FACULTY = @f
);
return @rc
end;
go
create function PULPIT_COUNTER (@f varchar(20)) returns int 
as begin
declare @rc int = 0;
set @rc = (select count(PULPIT.PULPIT) from PULPIT where PULPIT.FACULTY = @f
);
return @rc
end;
go
create function GROUP_counter (@f varchar(20)) returns int 
as begin
declare @rc int = 0;
set @rc = (select count(GROUPS.IDGROUP) from GROUPS
where GROUPS.FACULTY = @f
);
return @rc
end;
go
create function PROFESSTION_counter (@f varchar(20)) returns int 
as begin
declare @rc int = 0;
set @rc = (select count(PROFESSION.PROFESSION) from PROFESSION 
where PROFESSION.FACULTY = @f
);
return @rc
end;            
go
create function FACULTY_REPORT(@c int) returns @fr table                                        -- total
( [Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, 
[Количество студентов] int, [Количество специальностей] int )
as begin 
declare cc CURSOR static for 
select FACULTY from FACULTY 
where dbo.STUDENT_counter(FACULTY) > @c; 
declare @f varchar(30);
open cc;  
fetch cc into @f;
while @@fetch_status = 0
begin
insert @fr values( 
@f, 
dbo.PULPIT_COUNTER(@f),
dbo.GROUP_counter(@f),
dbo.STUDENT_counter(@f),
dbo.PROFESSTION_counter(@f)
); 
 fetch cc into @f;  
 end;   
return; 
end;
go
select * from dbo.FACULTY_REPORT(1)
drop function dbo.STUDENT_counter
drop function dbo.PULPIT_COUNTER
drop function dbo.GROUP_counter
drop function dbo.PROFESSTION_counter
drop function dbo.FACULTY_REPORT
go

-- 7: 


use UNIVER
go
create function FSUBJECTS ( @p varchar(20)) returns varchar(300)  -- 1 функиция FSSUBJECTS
as begin
declare @s varchar(20);
declare @ts varchar(300) = 'Дисциплины: ';
declare TotalSubjects cursor local static
for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p;
open TotalSubjects;
fetch TotalSubjects into @s
while @@FETCH_STATUS = 0 
begin
set @ts = @ts + ', ' + rtrim(@s);
fetch TotalSubjects into @s;
end
return @ts;
end;
go
create function FFACPUL (@fk varchar(20),@pk varchar(20)) returns table     -- 2я функия FFACPUL
as return
 select FACULTY.FACULTY , PULPIT.PULPIT from FACULTY  
left outer join PULPIT on FACULTY.FACULTY= PULPIT.FACULTY
where FACULTY.FACULTY = ISNULL(@fk,FACULTY.FACULTY)
and
PULPIT.PULPIT = isnull(@pk,PULPIT.PULPIT)
go
create function FCTEACHER(@pk varchar(20)) returns int 
as begin
declare @rc int = (select count(TEACHER.TEACHER) from TEACHER where TEACHER.PULPIT = isnull(@pk,TEACHER.PULPIT)) ;
return @rc
end;
go
create procedure PRINT_REPORTX @f char(10) = null , @p char(10) = null
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
            select *,
			   dbo.FSUBJECTS(@selected_p) as [Дисциплины(1)],
               dbo.FCTEACHER(@selected_p) as [Количество преподавателей]
            from dbo.FFACPUL(@f, @selected_p);
        end
      if @f is not null and @p is not null
begin
    set @n = (select count(PULPIT.PULPIT) from PULPIT where PULPIT.FACULTY = @f);
    select *,
           dbo.FSUBJECTS(@p) as [Дисциплины(2)],
           dbo.FCTEACHER(@p) as [Количество преподавателей]
    from dbo.FFACPUL(@f, @p);
end

       if @f is null and @p is not null
begin
    set @f = (select PULPIT.FACULTY from PULPIT where PULPIT.PULPIT = @p);
    set @n = (select count(PULPIT.PULPIT) from PULPIT where PULPIT.FACULTY = @f);
    select *,
           dbo.FSUBJECTS(@p) as [Дисциплины(3)],
           dbo.FCTEACHER(@p) as [Количество преподавателей]
    from dbo.FFACPUL(@f, @p);
end
    end try
    begin catch
	 if @p is not null and  not exists (select PULPIT.PULPIT from PULPIT where PULPIT.PULPIT = @p)
	 begin
	  print 'Ошибка в параметрах: '
	end
	 print 'err num: ' + cast(error_number() as varchar(6));
     print 'err msg: ' + error_message();
     print 'err level: ' + cast(error_severity() as varchar(6));
     if ERROR_PROCEDURE() is not null 
       print 'Ошибка в параметрах: ' + error_procedure();
     return -1
    end catch
end
go

exec PRINT_REPORTX @f='ИТ', @p ='ИСиТ';

select * from PULPIT where PULPIT.FACULTY = 'ИЭФ'

drop procedure PRINT_REPORTX
drop function dbo.FFACPUL
drop function dbo.FCTEACHER
drop function dbo.FSUBJECTS

