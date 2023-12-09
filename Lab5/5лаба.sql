-- 1: 

use UNIVER; 


select PULPIT.PULPIT_NAME, FACULTY.FACULTY , FACULTY.FACULTY_NAME from PULPIT , FACULTY
where  PULPIT.FACULTY = FACULTY.FACULTY 
and 
FACULTY.FACULTY_NAME in ( select FACULTY_NAME from  FACULTY  where FACULTY.FACULTY_NAME like '%технологии%' 
or  FACULTY.FACULTY_NAME like '%технология%')


-- Для мой бд

use Лемешевский_Склад 

select ITEMS.Item_Name , CUSTOMERS.Buyer_Name from ITEMS ,CUSTOMERS
where CUSTOMERS.Buyer_ID = ITEMS.ID
and 
CUSTOMERS.Buyer_Name in ( select Buyer_Name from CUSTOMERS where Buyer_Name like '%трий%' )


-- 2: 
use UNIVER

select PULPIT.PULPIT_NAME, FACULTY.FACULTY , FACULTY.FACULTY_NAME 
from PULPIT inner join  FACULTY 
on  PULPIT.FACULTY = FACULTY.FACULTY  
where FACULTY.FACULTY_NAME in
( select FACULTY_NAME from  FACULTY  where FACULTY.FACULTY_NAME like '%технологии%' or  FACULTY.FACULTY_NAME like '%технология%' );

-- Для мой бд
use Лемешевский_Склад 

select ITEMS.Item_Name ,Transactions.Item_ID, CUSTOMERS.Buyer_Name from ITEMS ,CUSTOMERS
inner join  Transactions
on CUSTOMERS.Buyer_ID = Transactions.Item_ID
where 
CUSTOMERS.Buyer_Name in ( select Buyer_Name from CUSTOMERS where Buyer_Name like '%трий%')


use UNIVER
-- 3:

select PULPIT.PULPIT_NAME, FACULTY.FACULTY , FACULTY.FACULTY_NAME 
from PULPIT inner join  FACULTY 
on  PULPIT.FACULTY = FACULTY.FACULTY  
  where FACULTY.FACULTY_NAME like '%технологии%' or  FACULTY.FACULTY_NAME like '%технология%';


  -- Для мой бд


  use Лемешевский_Склад 

select ITEMS.Item_Name ,Transactions.Item_ID, CUSTOMERS.Buyer_Name from ITEMS ,CUSTOMERS
inner join  Transactions
on CUSTOMERS.Buyer_ID = Transactions.Item_ID
 where Buyer_Name like '%трий%'


use UNIVER


-- 4:


select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM a
where AUDITORIUM = (select top(1) AUDITORIUM from AUDITORIUM aa
where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE 
order by AUDITORIUM_CAPACITY desc) order by AUDITORIUM_CAPACITY desc;


-- Для мой бд


  use Лемешевский_Склад 
select Cost , Item_Count , Item_Name from ITEMS a
where  Item_Name = (select top 1 Item_Name from ITEMS aa 
where aa.Cost = a.Cost
order by Item_Count desc)order by Item_Count desc

use UNIVER


-- 5:


select FACULTY.FACULTY_NAME  from FACULTY
where not exists (select * from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY);

-- Для мой бд

 use Лемешевский_Склад 

 select ITEMS.Item_Name from ITEMS 
 where not exists ( select * from Transactions where Transactions.Item_ID = Item_ID)


use UNIVER



-- 6: проверить

select top 1
         (select avg(PROGRESS.NOTE) from PROGRESS where  PROGRESS.SUBJECT like '%ОАиП%' ) [ОАиП] ,
		 (select avg(PROGRESS.NOTE) from PROGRESS where  PROGRESS.SUBJECT like 'БД' ) [БД] ,
		 (select avg(PROGRESS.NOTE) from PROGRESS where  PROGRESS.SUBJECT like '%СУБД%' ) [СУБД] 
   
   -- Для мой бд


   
 use Лемешевский_Склад 

select top 1
      (select avg(ITEMS.Cost) from ITEMS where  ITEMS.Item_Name like '%а%' ) [Total sum]

use UNIVER



-- 7

select  SUBJECT, NOTE from  PROGRESS a
where  NOTE>=all ( select NOTE from PROGRESS where SUBJECT = a.SUBJECT) order by NOTE desc

-- Для мой бд

 use Лемешевский_Склад 

select Item_Name , Item_Count from ITEMS a
where Item_Count >=all (select Item_Count from ITEMS where Item_Name = a.Item_Name);

use UNIVER



-- 8:

select  IDSTUDENT, SUBJECT , NOTE from PROGRESS a
where NOTE =any (select NOTE from PROGRESS where  IDSTUDENT = a.IDSTUDENT );

-- Для мой бд


 use Лемешевский_Склад 

select Item_Name , Item_Count from ITEMS a
where Item_Count =any (select Item_Count from ITEMS where Item_Name = a.Item_Name);

use UNIVER



-- 10:

select NAME , BDAY from STUDENT a 
 where BDAY in (select  BDAY from STUDENT aa
     where a.BDAY = aa.BDAY and  a.NAME != aa.NAME) order by BDAY;
