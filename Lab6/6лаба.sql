use UNIVER;

-- 1,2 :

select AUDITORIUM.AUDITORIUM_TYPE , min(AUDITORIUM_CAPACITY) [����������� �����������],
max(AUDITORIUM_CAPACITY) [������������ �����������] , 
avg(AUDITORIUM_CAPACITY) [������� �����������]  , 
count(AUDITORIUM_CAPACITY) [����������� ��������� ���������] ,
 sum(AUDITORIUM_CAPACITY) [����� ���������������]
from AUDITORIUM  inner join AUDITORIUM_TYPE on
AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE
group by AUDITORIUM.AUDITORIUM_TYPE

-- ��� ���� ��:
use �����������_�����

select max(ITEMS.Cost) , min(ITEMS.Cost) , avg(ITEMS.Cost) , count(ITEMS.Item_Name) , sum(ITEMS.Cost) from ITEMS
inner join Transactions on Transactions.Item_ID = ITEMS.ID


use UNIVER


-- 3: 

select  * from ( select
case 
when (PROGRESS.NOTE between 6 and 7 ) then '6-7'
when (PROGRESS.NOTE between 8 and 9) then '8-9'
when (PROGRESS.NOTE between 4 and 5) then '4-5'
end [������],
count(PROGRESS.NOTE) [����������� ������]
from PROGRESS
group by case
when (PROGRESS.NOTE between 6 and 7 ) then '6-7'
when (PROGRESS.NOTE between 8 and 9) then '8-9'
when (PROGRESS.NOTE between 4 and 5) then '4-5'
end) as a
order by case a.������
               when '6-7' then 3
               when '8-9' then 2
               when '4-5' then 4
               when '10' then 1
               end


			   -- ��� ���� ��:
use �����������_�����

select * from (select  case 
when (ITEMS.Cost between 10 and 15) then '10-15'
when (ITEMS.Cost between 16 and 25) then '16-25'
when (ITEMS.Cost > 25) then '25>'
end [����],
count (ITEMS.Item_Name)[�����������]
from ITEMS
group by case 
when (ITEMS.Cost between 10 and 15) then '10-15'
when (ITEMS.Cost between 16 and 25) then '16-25'
when (ITEMS.Cost > 25) then '25>'
end  ) as b
order by case b.���� 
when '10-15' then 3
when '16-26' then 2
when '25>' then 1
end

use UNIVER



-- 4:

select 
a.FACULTY ,  round(avg(cast(p.NOTE as float(4))), 2) [������] , (2014 - g.YEAR_FIRST)[����] , g.PROFESSION
from FACULTY a 
inner join GROUPS g on a.FACULTY = g.FACULTY 
inner join STUDENT s on s.IDGROUP = g.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT
group by a.FACULTY  , g.YEAR_FIRST , g.PROFESSION
order by ������ desc


-- ��� ���� ��:
use �����������_�����

select 
 round(avg(cast(p.Cost as float(4))), 2) [����] 
from ITEMS p
inner join Transactions t on t.Item_ID = p.ID
order by ���� desc

use UNIVER


-- 5: 

select 
a.FACULTY ,  round(avg(cast(p.NOTE as float(4))), 2) [������] , (2014 - g.YEAR_FIRST)[����] , g.PROFESSION
from FACULTY a 
inner join GROUPS g on a.FACULTY = g.FACULTY 
inner join STUDENT s on s.IDGROUP = g.IDGROUP
inner join PROGRESS p on p.IDSTUDENT = s.IDSTUDENT and p.SUBJECT in ('��','����')
group by a.FACULTY  , g.YEAR_FIRST , g.PROFESSION
order by ������ desc

-- ��� ���� ��:
use �����������_�����


select 
 round(avg(cast(p.Cost as float(4))), 2) [����] 
from ITEMS p
inner join Transactions t on t.Item_ID = p.ID and p.ID >= 2
order by ���� desc


use UNIVER


-- 6:

select GROUPS.FACULTY, PROFESSION.PROFESSION_NAME , avg(PROGRESS.NOTE) [�������]
from PROGRESS ,GROUPS 
inner join FACULTY   on FACULTY.FACULTY = GROUPS.FACULTY and GROUPS.FACULTY = '���'
inner join STUDENT  on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
group by GROUPS.FACULTY, PROFESSION.PROFESSION_NAME



-- ��� ���� ��:
use �����������_�����


select CUSTOMERS.Buyer_Name from CUSTOMERS 
inner join Transactions on Transactions.Buyer_ID = CUSTOMERS.Buyer_ID and CUSTOMERS.Buyer_ID  in (1,2)
group by Buyer_Name

use UNIVER



-- 7:


select PROGRESS.NOTE , count(STUDENT.IDSTUDENT)[����������� ���������] from PROGRESS
inner join STUDENT on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
group by PROGRESS.NOTE
having PROGRESS.NOTE in (8,9)
order by PROGRESS.NOTE desc


-- ��� ���� ��:
use �����������_�����
   
   select count(ITEMS.Item_Name) [�����������] from ITEMS 
   group by ID 
   having  ID in (1,3)




















	




