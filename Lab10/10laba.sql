 -- 1:
 use UNIVER
exec sp_helpindex 'AUDITORIUM_TYPE';
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex  'TEACHER'


 use tempdb 
 create table #local (
 id int ,
 msg varchar(50)
 );

 declare 
 @ci varchar = 'C: ',
 @i int = 0,
 @c int = 0;
 while @c < 1000 
 begin
  set @i = @i + 5;
 insert  #local(id,msg) values(@i , replicate('ВЛАД', 2))
  if (@c % 100 = 0)begin print @ci print  @c end;
 set @c = @c + 1;
 end

 select id  , msg from #local where id between 1500 and 2000 order by id 
 checkpoint;
 dbcc dropcleanbuffers;

 create clustered index #local_cl on #local(id asc)
  select id  , msg from #local where id between 1500 and 2000 order by id 

 drop index #local_cl on #local
 drop table #local


 -- Для моей бд

 use Лемешевский_Склад
SET IDENTITY_INSERT ITEMS  ON 
 declare 
 @iter int = 0
 while @iter < 30
 begin
 insert dbo.ITEMS(ID,Item_Name) 
 values(floor(300000*rand()) , REPLICATE('BANANAA',1))
 set @iter = @iter + 1;
 end

 select ITEMS.ID ,ITEMS.Item_Name from ITEMS
 where ID between 10 and 30


  checkpoint;
 dbcc dropcleanbuffers;

  create clustered index #item_cl on ITEMS(ID , Item_Name);

  select ITEMS.ID ,ITEMS.Item_Name from ITEMS
 where ID between 10 and 30

 drop index #item_cl on ITEMS

-- 2: 

 use tempdb 
 create table #local2 (
 id int ,
 msg varchar(50)
 );

 declare 
  @ci2 varchar = 'C: ',
 @c2 int = 0;
 while @c2< 1000 
 begin
 insert  #local2(id,msg) values(floor(3000*rand()) , replicate('ВЛАД', 2))
  if (@c2 % 100 = 0) print @ci2 print @c2;
 set @c2 = @c2 + 1;
 end
 SELECT * from  #local2 where id  between 1500 and 4500 ;  

 checkpoint;
  dbcc dropcleanbuffers;

 create index #LOC on #local2(id);
 create index #LOC_NONCLU on #local2(id,msg);

  SELECT * from  #local2 where id  between 1500 and 4500 ;  
  drop table #local2;


   -- Для моей бд

 use Лемешевский_Склад
SET IDENTITY_INSERT ITEMS  ON 
 declare 
 @iter2 int = 0,
 @newId2 int = 5;
 while @iter2 < 1000
 begin
 set @newId2 = @newId2 + 5
 insert dbo.ITEMS(ID,Item_Name) 
 values(@newId2 , REPLICATE('BANANAA',1))
 set @iter2 = @iter2 + 1;
 end

 select ITEMS.ID ,ITEMS.Item_Name from ITEMS
 where ID between 10 and 30


  checkpoint;
 dbcc dropcleanbuffers;

 create index #item_cl2 on ITEMS(ID , Item_Name);

  select ITEMS.ID ,ITEMS.Item_Name from ITEMS
 where ID between 10 and 30

 drop index #item_cl2 on ITEMS


  -- 3:


 use tempdb 
 create table #local3 (
 id int ,
 msg varchar(50)
 );

 declare 
  @ci3 varchar = 'C: ',
 @c3 int = 0;
 while @c3< 1000 
 begin
 insert  #local3(id,msg) values(floor(3000*rand()) , replicate('ВЛАД', 1))
  if (@c3 % 100 = 0) print @ci3 print @c3;
 set @c3 = @c3 + 1;
 end
  SELECT * from  #local3 where id < 1500;  
   checkpoint;
  dbcc dropcleanbuffers;
 create index #loc_tkey on #local3(id) include (msg);

 SELECT * from  #local3 where id < 1500;  


 drop #loc_tkey on #local3


  -- Для моей бд

 use Лемешевский_Склад
SET IDENTITY_INSERT ITEMS  ON 
 declare 
 @iter3 int = 0,
 @newId3 int = 5;
 while @iter3 < 1000
 begin
 set @newId3 = @newId3 + 5
 insert dbo.ITEMS(ID,Item_Name) 
 values(@newId3 , REPLICATE('BANANAA',1))
 set @iter3 = @iter3 + 1;
 end

 select ITEMS.ID ,ITEMS.Item_Name from ITEMS
 where ID between 10 and 30


  checkpoint;
 dbcc dropcleanbuffers;

 create index #item_cl3 on ITEMS(ID , Item_Name);

  select ITEMS.ID ,ITEMS.Item_Name from ITEMS
 where ID between 10 and 30

 drop index #item_cl3 on ITEMS





 -- 4:

 
 use tempdb 
 create table #local4 (
 id int ,
 msg varchar(50)
 );

 declare 
  @ci4 varchar = 'C: ',
 @c4 int = 0;
 while @c4< 10000
 begin
 insert  #local4(id,msg) values(floor(3000*rand()) , replicate('ВЛАД', 1))
 if (@c4 % 100 = 0) print @ci4 print @c4;
 set @c4 = @c4 + 1;
 end

SELECT id from  #local4 where id between 100  and 200 
SELECT id from  #local4 where id > 100  and id < 200
SELECT id from  #local4 where id = 1335;

  checkpoint;
  dbcc dropcleanbuffers;
  
  create index #loc_where on #local4(id) where (id > 150 ) and (id < 200)

SELECT id from  #local4 where id between 100  and 200 
SELECT id from  #local4 where id > 100  and id < 200
SELECT id from  #local4 where id = 1335;

drop index #loc_where on #local4
drop table #local4



 -- Для моей бд

 use Лемешевский_Склад
SET IDENTITY_INSERT ITEMS  ON 
 declare 
 @iter4 int = 10
 while @iter4 < 1000
 begin
 insert dbo.ITEMS(ID,Item_Name) 
 values(floor(300000*rand()) , REPLICATE('BANANAA',1))
 set @iter4 = @iter4 + 1;
 end

 select ITEMS.ID ,ITEMS.Item_Name from ITEMS
 where ID between 10 and 30


  checkpoint;
 dbcc dropcleanbuffers;

 create index #item_cl4 on ITEMS(ID) where (ID > 150 ) and (ID < 200)

  select ITEMS.ID ,ITEMS.Item_Name from ITEMS
 where ID between 10 and 30

 drop index #item_cl4 on ITEMS


-- 5:

 use tempdb 
 create table #local5 (
 id int ,
 msg varchar(50)
 );


  declare 
  @ci5 varchar = 'C: ',
 @c5 int = 0;
 while @c5<= 10000 
 begin
 insert  #local5(id,msg) values(floor(3000*rand()) , replicate('ВЛАД', 1))
 if (@c5 % 100 = 0) print @ci5 print @c5;
 set @c5 = @c5 + 1;
 end

   checkpoint;
  dbcc dropcleanbuffers;

  create index #loc_mark on #local5(id)

 SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
OBJECT_ID(N'#local5'), NULL, NULL, NULL) ss 
JOIN sys.indexes ii on ss.object_id = ii.object_id 
and ss.index_id = ii.index_id  WHERE name is not null;

insert top(200000) #local5(id , msg) select id , msg from #local5


alter index #loc_mark on #local5 reorganize 
alter index #loc_mark on #local5 rebuild with (online = off )

drop index #loc_mark on #local5 
drop table #local5 



-- 6: 

 use tempdb 
 create table #local6 (
 id int ,
 msg varchar(50)
 );

 declare 
  @ci6 varchar = 'C: ',
 @c6 int = 0;
 while @c6 < 10000 
 begin
 insert  #local6(id,msg) values(floor(3000*rand()) , replicate('ВЛАД', 1))
 if (@c6 % 100 = 0) print @ci6 print @c6;
 set @c6 = @c6 + 1;
 end

SELECT id from  #local6 where id between 100  and 200  

  checkpoint;
  dbcc dropcleanbuffers;

  create index #loc_lastkey on #local6(id) with pad_index , fillfactor = 65
  INSERT top(50) percent INTO #local6(id, msg) 
  select id,msg from #local6
  
 SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
OBJECT_ID(N'#local6'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  WHERE name is not null;

drop index #loc_lastkey on #local6
drop table #local6