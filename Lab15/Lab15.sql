-- 1:
use UNIVER
go
create table TR_AUDIT(
ID int identity, -- number
STMT varchar(20) -- DML oper
check (STMT in ('INS','DEL','UPD')),
TRNAME varchar(50), -- trigger name
CC varchar(300) -- comment
);

go
create trigger TR_TEACHER_INS on TEACHER after insert as
declare @n1 varchar(100) , @n2 char(1) , @n3 char(20) , @in varchar(300);
print 'Вставка в TEACHER:';
set @n1 = (select [TEACHER_NAME] from inserted);
set @n2 = (select [GENDER] from inserted);
set @n3 = (select [PULPIT] from inserted);
set @in = @n1 +' : ' + @n2 + ' : ' + @n3;
insert into TR_AUDIT(STMT,TRNAME,CC) values ('INS','TR_TEACHER_INS',@in);
return;

insert into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values (
'ЛЕМШ',
'Лемешевский Владислав Олегович',
'м',
'ИСиТ'
)
select * from TR_AUDIT



-- 2:

go
create trigger TR_TEACHER_DEL on TEACHER after DELETE
as
declare @n1 varchar(100) , @n2 char(1) , @n3 char(20) , @in varchar(300);
print 'Удаление в TEACHER:';
set @n1 = (select [TEACHER_NAME] from deleted);
set @n2 = (select [GENDER] from deleted);
set @n3 = (select [PULPIT] from deleted);
set @in = @n1 +' : ' + @n2 + ' : ' + @n3;
insert into TR_AUDIT(STMT,TRNAME,CC) values ('DEL','TR_TEACHER_DEL',@in);
return;

delete TEACHER where TEACHER.TEACHER = 'ЛЕМШ'
select * from TR_AUDIT

-- 3:

go
create trigger TR_TEACHER_UPD  on TEACHER after UPDATE 
as 
declare @n1 varchar(100) , @n2 varchar(100) , @in varchar(300);
print 'Обновление в TEACHER:';
select @n1 = TEACHER from deleted
select @n2 = TEACHER from inserted
set @in = @n1 +' : ' + @n2 
insert into TR_AUDIT(STMT,TRNAME,CC) values ('UPD','TR_TEACHER_UPD',@in);
return;

update TEACHER set TEACHER.TEACHER = 'ЛЕМЕШ' where TEACHER.TEACHER = 'ЛЕМШ'
select * from TR_AUDIT

drop trigger TR_TEACHER_UPD 


-- 4:

go
create trigger TR_TEACHER on TEACHER after INSERT,DELETE,UPDATE
as
declare @ins int = (select count(*) from inserted)
declare @del int = (select count(*) from deleted)
declare @n1 varchar(100) , @n2 char(1) , @n3 char(20) , @in varchar(300);
if @ins > 0 and @del < 0
begin
print 'Вставка в TEACHER:';
set @n1 = (select [TEACHER_NAME] from inserted);
set @n2 = (select [GENDER] from inserted);
set @n3 = (select [PULPIT] from inserted);
set @in = @n1 +' : ' + @n2 + ' : ' + @n3;
insert into TR_AUDIT(STMT,TRNAME,CC) values ('INS','TR_TEACHER_INS',@in);
end
else if @ins = 0 and @del > 0 
begin
print 'Удаление в TEACHER:';
set @n1 = (select [TEACHER_NAME] from deleted);
set @n2 = (select [GENDER] from deleted);
set @n3 = (select [PULPIT] from deleted);
set @in = @n1 +' : ' + @n2 + ' : ' + @n3;
insert into TR_AUDIT(STMT,TRNAME,CC) values ('DEL','TR_TEACHER_DEL',@in);
end
else if @ins  > 0 and @del > 0
begin
print 'Обновление в TEACHER:';
select @n1 = TEACHER from deleted
select @n2 = TEACHER from inserted
set @in = @n1 +' : ' + @n2 
insert into TR_AUDIT(STMT,TRNAME,CC) values ('UPD','TR_TEACHER_UPD',@in);
end
return;

insert into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values (
'ЛЕМШ',
'Лемешевский Владислав Олегович',
'м',
'ИСиТ'
)

delete TEACHER where TEACHER.TEACHER = 'ЛЕМШ'

update TEACHER set TEACHER.TEACHER = 'ЛЕМЕШ' where TEACHER.TEACHER = 'ЛЕМШ'
select * from TR_AUDIT

-- для моей бд -----------------------------
go
use Лемешевский_Склад_2
go
create table TR_ITEM(
ID int identity, -- number
STMT varchar(20) -- DML oper
check (STMT in ('INS','DEL','UPD')),
TRNAME varchar(50), -- trigger name
CC varchar(300) -- comment
);
go
create trigger TR_ITEMS on ITEMS after INSERT,DELETE,UPDATE
as
declare @ins int = (select count(*) from inserted)
declare @del int = (select count(*) from deleted)
declare @n1 nvarchar(50) , @n2 smallmoney , @n3 nvarchar(100) , @in varchar(300);
if @ins > 0 and @del < 0
begin
print 'Вставка в ITEMS:';
set @n1 = (select [Item_Name] from inserted);
set @n2 = (select [Cost] from inserted);
set @n3 = (select [Opisanie] from inserted);
set @in = @n1 +' : ' + cast(@n2 as varchar(10)) + ' : ' + @n3;
insert into TR_ITEM(STMT,TRNAME,CC) values ('INS','TR_TEACHER_INS',@in);
end
else if @ins = 0 and @del > 0 
begin
print 'Удаление в ITEMS:';
set @n1 = (select [Item_Name] from deleted);
set @n2 = (select [Cost] from deleted);
set @n3 = (select [Opisanie] from deleted);
set @in = @n1 +' : ' + cast(@n2 as varchar(10)) + ' : ' + @n3;
insert into TR_ITEM(STMT,TRNAME,CC) values ('DEL','TR_TEACHER_INS',@in);
end
else if @ins  > 0 and @del > 0
begin
print 'Обновление в ITEMS:';
select @n1 = Item_Name from deleted
select @n2 = Item_Name from inserted
set @in = @n1 +' : ' + @n2 
insert into TR_ITEM(STMT,TRNAME,CC) values ('UPD','TR_TEACHER_INS',@in);
end
return;
go
insert ITEMS(ID,Item_Name,Cost,Opisanie,Save_Place,Item_Count,Cell_Number)
values (555,'LABA155',255,'GOOD5','Minsk5',12,3)
delete ITEMS where  ID = 555
select * from TR_ITEM
go
drop trigger TR_ITEMS
go
use UNIVER




-- 5:--------------------------

go
insert into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values (
1,2,3,4
)

select * from TR_AUDIT

-- 6:

go
create trigger TR_TEACHER_DEL1 on TEACHER after DELETE 
as
print 'TR_TEACHER_DEL1'
return;
go
create trigger TR_TEACHER_DEL2 on TEACHER after DELETE
as
print 'TR_TEACHER_DEL2'
return;
go
create trigger TR_TEA_CHER_DEL3 on TEACHER after DELETE
as
print 'TR_TEA_CHER_DEL3'
return;
go
exec sp_settriggerorder @triggername = 'TR_TEA_CHER_DEL3', @order = 'First',@stmttype ='DELETE';
go
exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL2', @order = 'Last',@stmttype ='DELETE';
go
select t.name ,e.type_desc from sys.triggers t 
inner join sys.trigger_events e on t.object_id = e.object_id
where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE';

insert into TEACHER(TEACHER,TEACHER_NAME,GENDER,PULPIT)
values (
'ЛЕМШ',
'Лемешевский Владислав Олегович',
'м',
'ИСиТ'
)

delete TEACHER where TEACHER.TEACHER = 'ЛЕМШ'

-- 7:
go
create trigger TRAN_TRIGGER on AUDITORIUM after UPDATE
as
declare @ins int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM)
if @ins > 100
begin
raiserror('Вместимость аудиторий не может быть выше 100!',10,1);
rollback;
end
return;
go
update AUDITORIUM set AUDITORIUM_CAPACITY = 101 where AUDITORIUM.AUDITORIUM = 'task8-1'


-- 8:

go
create trigger FACULTY_INSTEAD on FACULTY instead of DELETE 
as
begin
print 'Удаление в FACULTY запрещено!';
return ;
end
go
delete FACULTY where FACULTY.FACULTY = 'ИТ'

drop trigger FACULTY_INSTEAD , TRAN_TRIGGER,TR_TEACHER_DEL1,TR_TEACHER_DEL2,TR_TEACHER_DEL3,TR_TEACHER,TR_TEACHER_UPD,TR_TEACHER_INS,TR_TEACHER_DEL


-- 9:
USE UNIVER
GO
CREATE TRIGGER TEACHER_DDL ON DATABASE FOR DDL_DATABASE_LEVEL_EVENTS  
AS   
begin
DECLARE 
@t VARCHAR(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)'),
@t1 VARCHAR(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)'),
@t2 VARCHAR(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)')
IF @t1 = 'TEACHER' and @t IN ('CREATE_TABLE', 'DROP_TABLE')
BEGIN
PRINT 'ТИП СОБЫТИЯ: '+@t;
PRINT 'ИМЯ ОБЪЕКТА: '+@t1;
PRINT 'ТИП ОБЪЕКТА: '+@t2;
RAISERROR( N'ОПЕРАЦИИ С ТАБЛИЦЕЙ TEACHER ЗАПРЕЩЕНЫ', 16, 1);  
ROLLBACK  
END
return;
end
go
drop table TEACHER
drop trigger TEACHER_DDL on database
SELECT * FROM TEACHER



-- 11*:
create table WEATHER (
    CITY VARCHAR(20),
    DATE_START DATETIME,
    DATE_END DATETIME,
    TEMPERATURE VARCHAR(10)
);
go
create trigger TR_WEATHER on WEATHER after INSERT,UPDATE 
as
begin
if exists (
select 1 from WEATHER w
inner join inserted i on w.CITY = i.CITY 
where 
(
(w.DATE_START <= i.DATE_START AND w.DATE_END >= i.DATE_START)
OR (w.DATE_START <= i.DATE_END AND w.DATE_END >= i.DATE_END)
OR (w.DATE_START >= i.DATE_START AND w.DATE_END <= i.DATE_END)
)
and w.TEMPERATURE != i.TEMPERATURE
)
begin
print 'Вставка повтора!';
rollback;
end
if exists (
select 1 from deleted w
inner join inserted i on w.CITY = i.CITY 
where 
(
(w.DATE_START <= i.DATE_START AND w.DATE_END >= i.DATE_START)
OR (w.DATE_START <= i.DATE_END AND w.DATE_END >= i.DATE_END)
OR (w.DATE_START >= i.DATE_START AND w.DATE_END <= i.DATE_END)
)
and w.TEMPERATURE != i.TEMPERATURE
)
begin
print 'Изменение повтора!';
rollback;
end
return;
end

INSERT INTO WEATHER (CITY, DATE_START, DATE_END, TEMPERATURE)
VALUES ('Могилев', '01.01.2022 00:00', '01.01.2022 23:59', '-13');

UPDATE WEATHER
SET DATE_START = '01.01.2022 05:00', DATE_END = '01.01.2022 20:00', TEMPERATURE = '-5'
WHERE CITY = 'Минск' AND DATE_START = '01.01.2022 00:00' AND DATE_END = '01.01.2022 23:59';



select * from WEATHER
drop table WEATHER

drop trigger TR_WEATHER 


