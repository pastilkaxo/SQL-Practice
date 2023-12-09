use UNIVER

-- 1:

declare @subs varchar(250) , @s varchar(250) = ''
declare isit2 cursor 
for
select SUBJECT.SUBJECT from SUBJECT
where SUBJECT.PULPIT = 'ИСиТ'
open isit2
fetch isit2 into @subs 
print 'Дисциплины кафедры ИСиТ'
while @@FETCH_STATUS = 0
begin 
set @s = rtrim(@subs) + ',' + @s;
fetch isit2 into @subs
end
print @s
close isit2

-- Для моей бд

use Лемешевский_Склад 
declare @it char(20) ,@al char (20) = ''
declare items2 cursor
for 
select ITEMS.Item_Name from ITEMS
open items2 
fetch items2 into @it
print 'Items:'
while @@FETCH_STATUS =0 
begin
set @al = rtrim(@it)  +',' + @al
fetch items2 into @it
end
print @al
close items2

use UNIVER



-- 2:
-- local
declare Dists cursor local
for 
select PROGRESS.IDSTUDENT , PROGRESS.NOTE from PROGRESS
declare @st char(1000) , @cena real
open Dists
fetch Dists into @st,@cena 
select @st [IDSTUDENT] , cast(@cena as varchar(60)) [NOTE]
go
declare @st char(100) , @cena real
open Dists
fetch Dists into @st,@cena;
select @st [IDSTUDENT] , cast(@cena as varchar(60)) [NOTE]
go

-- global 

declare Dists cursor global
for 
select PROGRESS.IDSTUDENT , PROGRESS.NOTE from PROGRESS
declare @st char(1000) , @cena real
open Dists
fetch Dists into @st,@cena 
select @st [IDSTUDENT] , cast(@cena as varchar(60)) [NOTE]
go
declare @st char(100) , @cena real
open Dists
fetch Dists into @st,@cena;
select @st [IDSTUDENT] , cast(@cena as varchar(60)) [NOTE]
close Dists
deallocate Dists
go


-- Для моей бд
use Лемешевский_Склад 
declare @it2 char(20) ,@al2 char (20) = ''
declare items2 cursor
for 
select ITEMS.Item_Name from ITEMS
open items2 
fetch items2 into @it2
print 'Items:'
while @@FETCH_STATUS =0 
begin
set @al2 = rtrim(@it2)  +',' + @al2
fetch items2 into @it2
end
print @al2
close items2

use UNIVER




-- 3:

-- static
declare @ad char(100), @aname char(100) , @acap char(100) 
declare Auds cursor local static 
for 
select AUDITORIUM.AUDITORIUM , AUDITORIUM.AUDITORIUM_NAME , AUDITORIUM_CAPACITY from AUDITORIUM 
where AUDITORIUM.AUDITORIUM_CAPACITY < 40 
open Auds
print 'Аудитории:' + cast(@@CURSOR_ROWS as varchar(5));
insert AUDITORIUM(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_CAPACITY)
values('111-1', 'ЛК',39)
update AUDITORIUM set AUDITORIUM_CAPACITY = 15 where AUDITORIUM = '111-1'
fetch Auds into @ad ,@aname , @acap
while @@FETCH_STATUS = 0 
begin
print @ad + @aname + @acap
fetch Auds into @ad ,@aname , @acap
end
close Auds
delete AUDITORIUM where AUDITORIUM = '111-1'

-- dynamic

declare @ad2 char(10), @aname2 char(10) , @acap2 char(10) 
declare Auds cursor local dynamic 
for 
select AUDITORIUM.AUDITORIUM , AUDITORIUM.AUDITORIUM_NAME , AUDITORIUM_CAPACITY from AUDITORIUM 
where AUDITORIUM.AUDITORIUM_CAPACITY < 40 
open Auds
print 'Аудитории:' + cast(@@CURSOR_ROWS as varchar(5));
insert AUDITORIUM(AUDITORIUM,AUDITORIUM_NAME,AUDITORIUM_CAPACITY)
values('111-1', 'ЛК',39)
update AUDITORIUM set AUDITORIUM_CAPACITY = 15 where AUDITORIUM = '111-1'
fetch Auds into @ad2 ,@aname2 , @acap2
while @@FETCH_STATUS = 0 
begin
print @ad2 + @aname2 + @acap2
fetch Auds into @ad2 ,@aname2 , @acap2
end
close Auds
delete AUDITORIUM where AUDITORIUM = '111-1'


-- Для моей бд

use Лемешевский_Склад 
declare @it4 char(20) ,@al4 char (20) = ''
declare items2 cursor
for 
select ITEMS.Item_Name from ITEMS
open items2 
fetch items2 into @it4
print 'Items:'
while @@FETCH_STATUS =0 
begin
set @al4 = rtrim(@it4)  +',' + @al4
fetch items2 into @it4
end
print @al4
close items2

use UNIVER




-- 4:


declare Dists cursor local  scroll
for 
select PROGRESS.IDSTUDENT , PROGRESS.NOTE from PROGRESS
declare @st char(10) , @cena real
open Dists
fetch Dists into @st,@cena 
print '1 ' + @st + cast(@cena as varchar(6));
fetch last from Dists into @st,@cena;
print '2 ' + @st + cast(@cena as varchar(6));
fetch first from Dists into @st,@cena;
print '3 ' + @st + cast(@cena as varchar(6));
fetch next from Dists into @st,@cena;
print '4 ' + @st + cast(@cena as varchar(6));
fetch prior from Dists into @st,@cena;
print '5 ' + @st + cast(@cena as varchar(6));
fetch absolute 4 from Dists into @st,@cena;
print '6 ' + @st + cast(@cena as varchar(6));
fetch relative 5 from Dists into @st,@cena;
print '7 ' + @st + cast(@cena as varchar(6));
close Dists



--5:
-- KG , 1022 ,2013-05-06,5
declare @sn char(10) , @sm char(10) ;
declare New cursor local dynamic
for 
select PROGRESS.IDSTUDENT , PROGRESS.NOTE from PROGRESS for UPDATE 
open New 
fetch New into @sn , @sm
delete PROGRESS where current of New
fetch New into @sn , @sm
update PROGRESS set NOTE = NOTE + 1 where current of New
close New


-- Для моей бд
use Лемешевский_Склад 
declare @it5 char(20) ,@al5 char (20) = ''
declare items2 cursor
for 
select ITEMS.Item_Name from ITEMS
open items2 
fetch items2 into @it5
print 'Items:'
while @@FETCH_STATUS =0 
begin
set @al5 = rtrim(@it5)  +',' + @a15
fetch items2 into @it5
end
print @al5
close items2

use UNIVER



-- 6.1 :

insert PROGRESS(SUBJECT,IDSTUDENT,PDATE,NOTE)
values('ОАиП',1001,'2013-10-01',4)

declare @sid char(10) , @snote char(10) , @sgr char(10)
declare New2 cursor local dynamic 
for
select STUDENT.IDSTUDENT , PROGRESS.NOTE , GROUPS.IDGROUP from PROGRESS
inner join STUDENT on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT 
inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
where PROGRESS.NOTE = 4
open New2 
fetch New2 into @sid , @snote , @sgr
while @@FETCH_STATUS = 0
begin
delete PROGRESS where current of New2
fetch New2 into @sid , @snote , @sgr
end
close New2
deallocate New2

-- 6.2 


declare @sid2 char(10) , @snote2 char(10) , @sgr2 char(10)
declare New2 cursor local dynamic 
for
select STUDENT.IDSTUDENT , PROGRESS.NOTE , GROUPS.IDGROUP from PROGRESS
inner join STUDENT on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT 
inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
where PROGRESS.IDSTUDENT = 1014
open New2 
fetch New2 into @sid2 , @snote2 , @sgr2
UPDATE PROGRESS set NOTE = NOTE + 1
where IDSTUDENT = @sid2
close New2



-- 8:
use UNIVER
declare @fac char(10) , @kaf char(20) , @t int , @subs char(20) = ''
declare Total cursor local static 
for
select DISTINCT FACULTY.FACULTY , PULPIT.PULPIT ,count(distinct TEACHER.TEACHER) , STRING_AGG(SUBSTRING(rtrim(SUBJECT.SUBJECT),1,2),',') from FACULTY
full outer join PULPIT on PULPIT.FACULTY = FACULTY.FACULTY 
full outer join TEACHER on TEACHER.PULPIT = PULPIT.PULPIT 
full outer join SUBJECT on SUBJECT.PULPIT = PULPIT.PULPIT 
group by FACULTY.FACULTY , PULPIT.PULPIT 
open Total
fetch next from Total into @fac , @kaf ,@t ,@subs
while @@FETCH_STATUS = 0
begin

print 'Факультет: ' + @fac
print 'Кафедра:' + @kaf
print 'Колличество преподователей:' + cast(@t as varchar(6))
print 'Дисциплины: ' + isnull(@subs + ' (Длина: ' + cast(len(@subs) as varchar(6)) + ')', 'нет')
print '--------------------'
fetch next from Total into @fac , @kaf ,@t ,@subs
end
close Total
deallocate Total;

