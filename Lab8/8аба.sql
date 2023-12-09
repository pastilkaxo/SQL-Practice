-- 1:


CREATE VIEW  Преподователи
as select TEACHER.TEACHER [Код препода],
TEACHER.TEACHER_NAME [Имя],
TEACHER.PULPIT [Код кафедры] from TEACHER;

select * from Преподователи

drop view Преподователи

-- Моя бд:

use Лемешевский_Склад 
go
create view Товары
as select ITEMS.Item_Name [Имя товара] 
from  ITEMS
go
select * from Товары

drop view Товары

-- 2:

create view КолличествоКафедр 
as  
select FACULTY_NAME ,
count(PULPIT.PULPIT) [Колличество кафедр]
from PULPIT 
inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY 
group by FACULTY_NAME


select * from КолличествоКафедр

drop view КолличествоКафедр

-- Для мой бд:

use Лемешевский_Склад 
go
create view ItemsTrans 
as select Transactions.Item_ID, Transactions.Buyer_ID 
, count(ITEMS.ID)[ИД] from Transactions
inner join ITEMS on ITEMS.ID = Transactions.Item_ID
group by Item_ID,Buyer_ID
go 
select * from ItemsTrans




--  3:

create view [Аудитории] (AUDITORIUM_TYPE,AUDITORIUM)
as select  
AUDITORIUM.AUDITORIUM_TYPE , 
AUDITORIUM.AUDITORIUM
from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%' WITH CHECK OPTION

INSERT  Аудитории VALUES ('ЛК','413')
DELETE FROM Аудитории where AUDITORIUM='413'
UPDATE Аудитории SET  AUDITORIUM = '402' 
WHERE AUDITORIUM_TYPE = 'ЛК'


select * from Аудитории

drop view Аудитории

-- Для моей бд:

use Лемешевский_Склад 
go
create view Items2 (Item_Name,ID)
as select ITEMS.ID, ITEMS.Item_Name  from ITEMS
where ITEMS.ID in (1,2);


INSERT  Items2 VALUES ('4','4')
DELETE FROM Items2 where ITEMS.ID='4'
UPDATE Items2 SET  ITEMS.ID = '402' 
WHERE ITEMS.ID = '3'

select * from Items2

drop view ItemsTrans



-- 4:

create view ЛекционныеАудитории
as select 
AUDITORIUM.AUDITORIUM ,
AUDITORIUM.AUDITORIUM_TYPE
from AUDITORIUM 
where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%'


select * from ЛекционныеАудитории

drop view ЛекционныеАудитории

-- Для моей БД:

use Лемешевский_Склад 
go
create view Items3 (Item_Name,ID)
as select ITEMS.ID, ITEMS.Item_Name  from ITEMS
where ITEMS.ID in (1,2);

select  * from Items3


-- 5:

create view Дисциплины 
as select 
top 15 SUBJECT.SUBJECT , SUBJECT.SUBJECT_NAME ,SUBJECT.PULPIT 
from SUBJECT 
order by SUBJECT.SUBJECT_NAME

select * from Дисциплины

drop view Дисциплины

-- my bd

create view Five
as select
top 2 CUSTOMERS.Buyer_Name from CUSTOMERS
order by Buyer_Name

select * from Five



-- 6:
alter view КолличествоКафедр with schemabinding
as select dbo.FACULTY.FACULTY_NAME ,
count(dbo.PULPIT.PULPIT) [Колличество кафедр],
dbo.FACULTY.FACULTY
from dbo.PULPIT 
inner join dbo.FACULTY on FACULTY.FACULTY = PULPIT.FACULTY 
group by dbo.FACULTY.FACULTY_NAME , dbo.FACULTY.FACULTY

select * from КолличествоКафедр

drop view КолличествоКафедр

-- Для моей БД

alter view Five with schemabinding
as select
 count(dbo.CUSTOMERS.Buyer_ID) [New]  from dbo.CUSTOMERS

select * from Five



-- 8:


create view Расписание as
select a.AUDITORIUM [Аудитория], a.DAY_NAME [День], isnull(a.SUBJECT, 0) [Предмет], a.IDGROUP [Группа]
from TIMETABLE a

select * from Расписание
pivot (count (День) for [Предмет] in ([СУБД], [ОАиП], [ПИС])) as PVT

select * from Расписание
pivot(count([Группа]) for [День] in ([пн],[вт],[ср]) ) as PVT2


select * from Расписание

drop view Расписание