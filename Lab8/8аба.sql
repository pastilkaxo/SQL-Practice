-- 1:


CREATE VIEW  �������������
as select TEACHER.TEACHER [��� �������],
TEACHER.TEACHER_NAME [���],
TEACHER.PULPIT [��� �������] from TEACHER;

select * from �������������

drop view �������������

-- ��� ��:

use �����������_����� 
go
create view ������
as select ITEMS.Item_Name [��� ������] 
from  ITEMS
go
select * from ������

drop view ������

-- 2:

create view ����������������� 
as  
select FACULTY_NAME ,
count(PULPIT.PULPIT) [����������� ������]
from PULPIT 
inner join FACULTY on FACULTY.FACULTY = PULPIT.FACULTY 
group by FACULTY_NAME


select * from �����������������

drop view �����������������

-- ��� ��� ��:

use �����������_����� 
go
create view ItemsTrans 
as select Transactions.Item_ID, Transactions.Buyer_ID 
, count(ITEMS.ID)[��] from Transactions
inner join ITEMS on ITEMS.ID = Transactions.Item_ID
group by Item_ID,Buyer_ID
go 
select * from ItemsTrans




--  3:

create view [���������] (AUDITORIUM_TYPE,AUDITORIUM)
as select  
AUDITORIUM.AUDITORIUM_TYPE , 
AUDITORIUM.AUDITORIUM
from AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like '��%' WITH CHECK OPTION

INSERT  ��������� VALUES ('��','413')
DELETE FROM ��������� where AUDITORIUM='413'
UPDATE ��������� SET  AUDITORIUM = '402' 
WHERE AUDITORIUM_TYPE = '��'


select * from ���������

drop view ���������

-- ��� ���� ��:

use �����������_����� 
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

create view �������������������
as select 
AUDITORIUM.AUDITORIUM ,
AUDITORIUM.AUDITORIUM_TYPE
from AUDITORIUM 
where AUDITORIUM.AUDITORIUM_TYPE like '��%'


select * from �������������������

drop view �������������������

-- ��� ���� ��:

use �����������_����� 
go
create view Items3 (Item_Name,ID)
as select ITEMS.ID, ITEMS.Item_Name  from ITEMS
where ITEMS.ID in (1,2);

select  * from Items3


-- 5:

create view ���������� 
as select 
top 15 SUBJECT.SUBJECT , SUBJECT.SUBJECT_NAME ,SUBJECT.PULPIT 
from SUBJECT 
order by SUBJECT.SUBJECT_NAME

select * from ����������

drop view ����������

-- my bd

create view Five
as select
top 2 CUSTOMERS.Buyer_Name from CUSTOMERS
order by Buyer_Name

select * from Five



-- 6:
alter view ����������������� with schemabinding
as select dbo.FACULTY.FACULTY_NAME ,
count(dbo.PULPIT.PULPIT) [����������� ������],
dbo.FACULTY.FACULTY
from dbo.PULPIT 
inner join dbo.FACULTY on FACULTY.FACULTY = PULPIT.FACULTY 
group by dbo.FACULTY.FACULTY_NAME , dbo.FACULTY.FACULTY

select * from �����������������

drop view �����������������

-- ��� ���� ��

alter view Five with schemabinding
as select
 count(dbo.CUSTOMERS.Buyer_ID) [New]  from dbo.CUSTOMERS

select * from Five



-- 8:


create view ���������� as
select a.AUDITORIUM [���������], a.DAY_NAME [����], isnull(a.SUBJECT, 0) [�������], a.IDGROUP [������]
from TIMETABLE a

select * from ����������
pivot (count (����) for [�������] in ([����], [����], [���])) as PVT

select * from ����������
pivot(count([������]) for [����] in ([��],[��],[��]) ) as PVT2


select * from ����������

drop view ����������