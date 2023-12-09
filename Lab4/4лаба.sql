

-- 1:
use UNIVER
SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
 from AUDITORIUM_TYPE inner join AUDITORIUM  on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE;



 -- Для моей бд: 

 use Лемешевский_Склад_2
 
 select ITEMS.ID , ITEMS.Item_Name , ITEMS.Cost 
 from ITEMS inner join Transactions on ITEMS.ID = Transactions.Item_ID




 --  2:
use UNIVER
 SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
 from AUDITORIUM_TYPE inner join AUDITORIUM  on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE 
 and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME Like '%компьютер%';

 -- Для моей БД: 

  use Лемешевский_Склад_2

  
 select ITEMS.ID , ITEMS.Item_Name , ITEMS.Cost 
 from ITEMS inner join Transactions on ITEMS.ID = Transactions.Item_ID and ITEMS.Item_Name like '%ban%'


 
 --  3: 
 use UNIVER
 select STUDENT.NAME,
       FACULTY.FACULTY,
       PULPIT.PULPIT,
       PROFESSION.PROFESSION_NAME,
       SUBJECT.SUBJECT_NAME,
 case 
 when (PROGRESS.NOTE = 6) then 'шесть'
 when (PROGRESS.NOTE = 7) then 'семь'
 when (PROGRESS.NOTE = 8) then 'восемь'
end [MARK] 
from PROGRESS 
inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
inner join [SUBJECT] on [SUBJECT].[SUBJECT] = PROGRESS.[SUBJECT]
inner join PULPIT on PULPIT.PULPIT = [SUBJECT].PULPIT
inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY
where PROGRESS.NOTE between 6 and 8
ORDER by PROGRESS.NOTE asc


-- Для моей БД: 

use Лемешевский_Склад_2

select ITEMS.Item_Name  ,CUSTOMERS.Buyer_Name, CUSTOMERS.Buyer_ID ,
case 
when( ITEMS.Cost <= 30 ) then 'Дешевый продукт'
when (ITEMS.Cost > 30 ) then 'Дорогой продукт'
end [Качество]
from ITEMS
inner join  CUSTOMERS on CUSTOMERS.Buyer_ID = ITEMS.ID



-- 4:
use UNIVER
select   PULPIT.PULPIT_NAME , isnull(TEACHER.TEACHER_NAME,'***')[Препод] 
from PULPIT left outer join  TEACHER  on PULPIT.PULPIT = TEACHER.PULPIT ;

-- Для моей БД:

use Лемешевский_Склад

select ITEMS.Description,  Transactions.Order_date , isnull( ITEMS.Item_Name , 'Deleted')[Продукт]
from ITEMS left outer join Transactions on Transactions.Item_ID = ITEMS.ID


-- Коммутитиваность
use UNIVER
select [NAME], YEAR_FIRST from STUDENT full  join GROUPS G on STUDENT.IDGROUP = G.IDGROUP
select [NAME], YEAR_FIRST from GROUPS full  join STUDENT S on GROUPS.IDGROUP = S.IDGROUP



-- 5.1: 
use UNIVER
 select  STUDENT.[NAME] ,  YEAR_FIRST from STUDENT 
 FULL outer join  GROUPS G on  STUDENT.IDGROUP = G.IDGROUP 
 where STUDENT.NAME is not null


 -- Для моей БД:

 use Лемешевский_Склад
 select ITEMS.Item_Name [ПРОДУКТ] , CUSTOMERS.Buyer_Name from ITEMS 
 full outer join CUSTOMERS on CUSTOMERS.Buyer_ID = ITEMS.ID
 where  ITEMS.Item_Name is null


 -- 5.2: 
 USE UNIVER
 select AUDITORIUM.AUDITORIUM_NAME , AUDITORIUM_TYPE.AUDITORIUM_TYPE from AUDITORIUM 
 full outer join AUDITORIUM_TYPE 
 on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE 
 where AUDITORIUM is null and AUDITORIUM_TYPE.AUDITORIUM_TYPE is not null

 -- Для моей БД:
use Лемешевский_Склад
 select ITEMS.Item_Name [ПРОДУКТ] , CUSTOMERS.Buyer_Name from ITEMS 
 full outer join CUSTOMERS on CUSTOMERS.Buyer_ID = ITEMS.ID
 where  ITEMS.Item_Name is null and CUSTOMERS.Buyer_Name is not null

 -- 5.3: 
  use UNIVER
  SELECT TEACHER.TEACHER_NAME [Имя] , TEACHER.PULPIT [Кафедра]  
  FROM PULPIT FULL outer join TEACHER on  PULPIT.PULPIT = TEACHER.PULPIT 
  where TEACHER.TEACHER_NAME is not null 

  -- Для моей БД:

-- 6: 
use UNIVER

SELECT AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
 from AUDITORIUM_TYPE cross join  AUDITORIUM  
 where AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE;

 -- Для моей БД:

 use Лемешевский_Склад_2

 select ITEMS.ID, ITEMS.Item_Name , ITEMS.Cost, Transactions.Order_date
 from ITEMS cross join Transactions where ITEMS.ID = Transactions.Item_ID







 -- ну я бы дальше не смотрел конечно , ответ же был хороший ,  но .......

 -- 8*:

 use UNIVER;

 
/*
create table TIMETABLE
(
    DAY_NAME   nvarchar(2) check (DAY_NAME in ('пн', 'вт', 'ср', 'чт', 'пт', 'сб')),
    LESSON     int check (LESSON between 1 and 4),
    TEACHER		char(10) foreign key references TEACHER (TEACHER),
    AUDITORIUM char(20) foreign key references AUDITORIUM (AUDITORIUM),
    SUBJECT    char(10) foreign key references SUBJECT (SUBJECT),
    IDGROUP    int foreign key references GROUPS (IDGROUP),
)
insert into TIMETABLE
values ('пн', 1, 'СМЛВ', '313-1', 'СУБД', 2),
       ('пн', 2, 'СМЛВ', '313-1', 'ОАиП', 4),
       ('пн', 1, 'МРЗ', '324-1', 'СУБД', 6),
       ('пн', 3, 'УРБ', '324-1', 'ПИС', 4),
       ('пн', 1, 'УРБ', '206-1', 'ПИС', 10),
       ('пн', 4, 'СМЛВ', '206-1', 'ОАиП', 3),
       ('ср', 1, 'БРКВЧ', '301-1', 'СУБД', 7),
       ('пн', 4, 'БРКВЧ', '301-1', 'ОАиП', 7),
       ('ср', 2, 'БРКВЧ', '413-1', 'СУБД', 8),
       ('чт', 2, 'ДТК', '423-1', 'СУБД', 7),
       ('пн', 4, 'ДТК', '423-1', 'ОАиП', 2),
       ('вт', 1, 'СМЛВ', '313-1', 'СУБД', 2),
       ('вт', 2, 'СМЛВ', '313-1', 'ОАиП', 4),
       ('вт', 3, 'УРБ', '324-1', 'ПИС', 4),
       ('вт', 4, 'СМЛВ', '206-1', 'ОАиП', 3);


*/
-- 1

select distinct AUDITORIUM from TIMETABLE
where DAY_NAME = 'вт' and LESSON = 2 
and AUDITORIUM not in (
select distinct AUDITORIUM 
from TIMETABLE 
where DAY_NAME = 'вт' and LESSON = 1 and LESSON = 3 );

-- 2 

select distinct AUDITORIUM from TIMETABLE
where DAY_NAME = 'ср' and LESSON = 2 
and AUDITORIUM not in (
select distinct AUDITORIUM 
from TIMETABLE 
where DAY_NAME = 'ср' and LESSON = 2 and  IDGROUP = 7 );

-- 3 

select GROUPS.IDGROUP,DAY_NAME, case
           when ( count(*)= 0) then 4
           when ( count(*)= 1) then 3
           when ( count(*)= 2) then 2
           when ( count(*)= 3) then 1
           when ( count(*)= 4) then 0
           end [Кол-во окон]
FROM  GROUPS inner join TIMETABLE T on GROUPS.IDGROUP = T.IDGROUP
group by GROUPS.IDGROUP,DAY_NAME
order by GROUPS.IDGROUP

-- 4
SELECT TEACHER.TEACHER_NAME, TIMETABLE.DAY_NAME, TIMETABLE.LESSON
	FROM TIMETABLE cross JOIN TEACHER
WHERE 
  TIMETABLE.TEACHER != TEACHER.TEACHER;
-- 5
select GROUPS.IDGROUP,TIMETABLE.DAY_NAME, TIMETABLE.LESSON
	from TIMETABLE CROSS JOIN GROUPS
where 
  TIMETABLE.IDGROUP != GROUPS.IDGROUP;