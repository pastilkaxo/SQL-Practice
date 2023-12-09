-- 1:

use UNIVER


declare @c int , @t char(5) = 'n'
SET IMPLICIT_TRANSACTIONS ON
insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
values('test-1',20,'ЛК','ЛК'),
       ('test-2',20,'ЛК','ЛК'),
	   ('test-3',20,'ЛК','ЛК')
set @c = (select count(*) from AUDITORIUM)
if @t = 'y' 
begin
commit;
select @c as [Колличество аудиторий] , string_agg(rtrim(AUDITORIUM.AUDITORIUM), ',')  from AUDITORIUM
end
else
begin
rollback;
print 'Произошел rollback'
end
SET IMPLICIT_TRANSACTIONS OFF

delete from AUDITORIUM where AUDITORIUM like 'test%'


-- Для моей бд:
use Лемешевский_Склад_2

declare @c2 int , @t2 char(5) = 'y'
SET IMPLICIT_TRANSACTIONS ON
delete ITEMS where ITEMS.Item_Name = 'test'
insert ITEMS(ID,Item_Name,Cost,Opisanie,Save_Place,Item_Count,Cell_Number)
values(5,'test',25,'New test','Minsk',4,2)
set @c2 = (select count(*) from ITEMS)
if @t2 = 'y' 
begin
commit;
select @c2 as [Колличество аудиторий] , string_agg(rtrim(ITEMS.Item_Name), ',')  from ITEMS
end
else
begin
rollback;
print 'Произошел rollback'
end
SET IMPLICIT_TRANSACTIONS OFF

use UNIVER


-- 2: 

begin try 
 begin tran 

  update AUDITORIUM set AUDITORIUM_CAPACITY = 'iAmNotAValue';
 delete from AUDITORIUM where AUDITORIUM like 'test%' 

 insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
 values('new-1',20,'ЛК','ЛК'),
       ('new-1',20,'ЛК','ЛК'),
	   ('new-3',20,'ЛК','ЛК')
 commit tran
end try 
begin catch 
  print 'Ошибка в выборке ' + case 
  when error_number() = 245 
  then 'Ошибка: Приведение строки к числу'
  when error_number() = 2627 and patindex('%PK_AUDITORIUM%',error_message())>0
     then
         'Ошибка: Нарушение уникальности ключа (попытка вставить дублирующееся значение)'
    else
         'Необработанная ошибка с кодом: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)) +
              ', сообщение об ошибке: ' + ERROR_MESSAGE()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;


-- Для моей бд:
use Лемешевский_Склад_2

declare @c3 int , @t3 char(5) = 'y'
SET IMPLICIT_TRANSACTIONS ON
begin transaction
delete ITEMS where ITEMS.Item_Name = 'test'
insert ITEMS(ID,Item_Name,Cost,Opisanie,Save_Place,Item_Count,Cell_Number)
values(5,'test',25,'New test','Minsk',4,2)
set @c3 = (select count(*) from ITEMS)
if @t3 = 'y' 
begin
commit;
select @c3 as [Колличество аудиторий] , string_agg(rtrim(ITEMS.Item_Name), ',')  from ITEMS
end
else
begin
rollback;
print 'Произошел rollback'
end
SET IMPLICIT_TRANSACTIONS OFF



-- 3: 
use UNIVER
declare @point varchar(32)
begin try 
 begin tran 
 delete from AUDITORIUM where AUDITORIUM like 'test%' 
 set @point = 'p1' ; save tran @point
  delete from AUDITORIUM where AUDITORIUM like 'new%' 
  set @point = 'p2' ; save tran @point
 insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
 values('new-1',20,'ЛК','ЛК'),
       ('new-1',20,'ЛК','ЛК'),
	   ('new-3',20,'ЛК','ЛК')
set @point = 'p3' ; save tran @point
update AUDITORIUM set AUDITORIUM_CAPACITY =  21 where AUDITORIUM = 'new-2';
set @point = 'p4' ; save tran @point
 commit tran
end try 
begin catch 
  print 'Ошибка в выборке'
    if error_number() = 245 
  begin
        print 'Ошибка: Приведение строки к числу'
  end
  else if error_number() = 2627
     begin
        print 'Ошибка: Нарушение уникальности ключа (попытка вставить дублирующееся значение)'
    end
    else
    begin
        print 'Необработанная ошибка с кодом: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)) +
              ', сообщение об ошибке: ' + ERROR_MESSAGE()
    end
	if @@TRANCOUNT > 0 
	begin
	print 'Контрольная точка ' + @point;
	rollback tran @point;
	commit tran;
	end
end catch;


-- Для моей бд:
use Лемешевский_Склад_2

declare @c4 int , @t4 char(5) = 'y'
SET IMPLICIT_TRANSACTIONS ON
begin transaction
delete ITEMS where ITEMS.Item_Name = 'test'
insert ITEMS(ID,Item_Name,Cost,Opisanie,Save_Place,Item_Count,Cell_Number)
values(5,'test',25,'New test','Minsk',4,2)
set @c4 = (select count(*) from ITEMS)
if @t4 = 'y' 
begin
commit;
select @c4 as [Колличество аудиторий] , string_agg(rtrim(ITEMS.Item_Name), ',')  from ITEMS
end
else
begin
rollback;
print 'Произошел rollback'
end
SET IMPLICIT_TRANSACTIONS OFF




-- 4: 
-- каждая транзакция видит незафиксированные изменения другой транзакции
-- A: 
use UNIVER
set transaction isolation level READ UNCOMMITTED 
begin tran 
-------------------------- t1 ------------------
select @@SPID [connection id], 'insert AUDITORIUM' 'result' , * from AUDITORIUM
                                             where AUDITORIUM = '4task-2'
select 'update AUDITORIUM' 'result' , AUDITORIUM.AUDITORIUM_CAPACITY ,AUDITORIUM.AUDITORIUM 
from AUDITORIUM where AUDITORIUM.AUDITORIUM like '4task%'
commit 

-------------------------- t2 ------------------
-- B: 

begin tran 
  delete AUDITORIUM where AUDITORIUM like '4task%'
 insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
 values('4task-1',20,'ЛК','ЛК'),
       ('4task-2',20,'ЛК','ЛК'),
	   ('4task-3',20,'ЛК','ЛК')
update AUDITORIUM set AUDITORIUM_CAPACITY =  21 where AUDITORIUM = '4task-2';

-------------------------- t1 ------------------
-------------------------- t2 ------------------
rollback



-- Для моей бд:
use Лемешевский_Склад_2

declare @c5 int , @t5 char(5) = 'y'
SET IMPLICIT_TRANSACTIONS ON
begin transaction
delete ITEMS where ITEMS.Item_Name = 'test'
insert ITEMS(ID,Item_Name,Cost,Opisanie,Save_Place,Item_Count,Cell_Number)
values(5,'test',25,'New test','Minsk',4,2)
set @c5 = (select count(*) from ITEMS)
if @t5 = 'y' 
begin
commit;
select @c5 as [Колличество аудиторий] , string_agg(rtrim(ITEMS.Item_Name), ',')  from ITEMS
end
else
begin
rollback;
print 'Произошел rollback'
end
SET IMPLICIT_TRANSACTIONS OFF


--только зафиксированные изменения из других транзакций
-- 5: 
use UNIVER
-- A:

set transaction isolation level READ COMMITTED 
begin tran
select * from AUDITORIUM where AUDITORIUM_CAPACITY < 30
-------------------------- t1 ------------------
-------------------------- t2 ------------------
select 'update AUDITORIUM' 'result', count(*) from AUDITORIUM where AUDITORIUM.AUDITORIUM like 'task5%'
commit 

-- B: 

begin tran
-------------------------- t1 ------------------
update AUDITORIUM set AUDITORIUM = 'task5-1' where AUDITORIUM = '111-1'
commit
-------------------------- t2 ------------------




-- Для моей бд:
use Лемешевский_Склад_2

declare @c6 int , @t6 char(5) = 'y'
SET IMPLICIT_TRANSACTIONS ON
begin transaction
delete ITEMS where ITEMS.Item_Name = 'test'
insert ITEMS(ID,Item_Name,Cost,Opisanie,Save_Place,Item_Count,Cell_Number)
values(5,'test',25,'New test','Minsk',4,2)
set @c6 = (select count(*) from ITEMS)
if @t6 = 'y' 
begin
commit;
select @c6 as [Колличество аудиторий] , string_agg(rtrim(ITEMS.Item_Name), ',')  from ITEMS
end
else
begin
rollback;
print 'Произошел rollback'
end
SET IMPLICIT_TRANSACTIONS OFF


--предотвратить феномен неповторяющегося чтения. Т.е. мы не видим в
-- исполняющейся транзакции измененные и удаленные записи другой транзакцией
-- 6: 

use UNIVER
--A: 
set transaction isolation level  REPEATABLE READ  
begin tran 
select * from AUDITORIUM 
-------------------------- t1 ------------------
-------------------------- t2 ------------------
select case 
when AUDITORIUM.AUDITORIUM = 'task6-1'  then 'insert AUDITORIUM' else ''
end 'result', * from AUDITORIUM where AUDITORIUM = 'task6-1';
commit;


-- B: 

begin tran 
-------------------------- t1 ------------------
delete AUDITORIUM where AUDITORIUM like 'task6%'
 insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
 values('task6-1',20,'ЛК','ЛК')
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM = 'task6-1'
delete AUDITORIUM where AUDITORIUM = 'task6-1'
commit;
-------------------------- t2 ------------------
rollback;


-- Для моей бд:
use Лемешевский_Склад_2

declare @c7 int , @t7 char(5) = 'y'
SET IMPLICIT_TRANSACTIONS ON
begin transaction
delete ITEMS where ITEMS.Item_Name = 'test'
insert ITEMS(ID,Item_Name,Cost,Opisanie,Save_Place,Item_Count,Cell_Number)
values(5,'test',25,'New test','Minsk',4,2)
set @c7 = (select count(*) from ITEMS)
if @t7 = 'y' 
begin
commit;
select @c7 as [Колличество аудиторий] , string_agg(rtrim(ITEMS.Item_Name), ',')  from ITEMS
end
else
begin
rollback;
print 'Произошел rollback'
end
SET IMPLICIT_TRANSACTIONS OFF


-- при котором транзакции ведут себя 
-- как будто ничего более не существует, никакого влияния друг на друга нет.
-- 7: 

use UNIVER
-- A:
set transaction isolation level SERIALIZABLE 
begin tran 
delete AUDITORIUM where AUDITORIUM = 'task7-1'
 insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
 values('task7-1',20,'ЛК','ЛК')
 update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM = 'task7-1'
 select * from AUDITORIUM where AUDITORIUM = 'task7-1'
 -------------------------- t1 ------------------
  select * from AUDITORIUM where AUDITORIUM = 'task7-1'
  -------------------------- t2 ------------------
 commit

 -- B: 
 set transaction isolation level READ COMMITTED 
begin tran 
delete AUDITORIUM where AUDITORIUM = 'task7-1'
 insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
 values('task7-1',20,'ЛК','ЛК')
 update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM = 'task7-1'
 select * from AUDITORIUM where AUDITORIUM = 'task7-1'
 -------------------------- t1 ------------------
 commit
   select * from AUDITORIUM where AUDITORIUM = 'task7-1'
   -------------------------- t2 ------------------
 delete AUDITORIUM where AUDITORIUM = 'task7-1'


 
-- Для моей бд:
use Лемешевский_Склад_2

declare @c8 int , @t8 char(5) = 'y'
SET IMPLICIT_TRANSACTIONS ON
begin transaction
delete ITEMS where ITEMS.Item_Name = 'test'
insert ITEMS(ID,Item_Name,Cost,Opisanie,Save_Place,Item_Count,Cell_Number)
values(5,'test',25,'New test','Minsk',4,2)
set @c8 = (select count(*) from ITEMS)
if @t8 = 'y' 
begin
commit;
select @c8 as [Колличество аудиторий] , string_agg(rtrim(ITEMS.Item_Name), ',')  from ITEMS
end
else
begin
rollback;
print 'Произошел rollback'
end
SET IMPLICIT_TRANSACTIONS OFF




 -- 8: 
 use UNIVER

 begin tran 
  delete AUDITORIUM where AUDITORIUM = 'task8-1'
 insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
 values('task8-1',20,'ЛК','ЛК')
 begin tran 
  update AUDITORIUM set AUDITORIUM_CAPACITY = 66 where AUDITORIUM = 'task8-1'
  commit

  if @@trancount > 0 
  begin
  rollback;
  print 'Was rollback with 1 inner tran'
  end;
  else
  begin
  select * from AUDITORIUM
  end