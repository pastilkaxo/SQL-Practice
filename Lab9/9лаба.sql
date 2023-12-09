-- 1:

declare 
@c char = 'v',
@vc varchar = '����',
@dt datetime ,
@t time ,
@i int  ,
@si smallint ,
@ti tinyint ,
@n numeric(12,5) ;

set @dt = getdate() ;
set @t = getdate();

select   @i = 10 , @si =5 , @ti = 1,@n = 12;

print 'Data: ' + cast(@i as varchar(10)) + @c + ' ' + @vc + ' '  + 
cast(@dt as varchar(50)) ;
print 'TIME:' + convert(varchar(50),@t);

select  @i [ i] , @si [si], @ti [ti], @n [n] ;

-- 2:

use UNIVER 
declare 
@all int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM ),
@avg int = (select avg(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM ),
@count int = (select count(AUDITORIUM.AUDITORIUM_TYPE) from AUDITORIUM ),
@secCap int,
@percent int 

if @all > 200 
begin
set @secCap = (select count(*) from AUDITORIUM  
where AUDITORIUM_CAPACITY < @avg);
set @percent = @secCap * 100/(select count(*) from AUDITORIUM);
select @all [�����������] , @avg [�������] ,
@count [�����������] , @secCap [������ �����������] , @percent [�������]; 
end
else 
print('����');

-- 3:

print
cast(@@ROWCOUNT as varchar) + ' ;' +
cast(@@VERSION as varchar) + ' ;' +
cast(@@SPID as varchar) +' ;' +  --  ���������� ��������� ������������� ��������, ����������� �������� �������� �����������
cast(@@ERROR as varchar) + ' ;' +
cast(@@SERVERNAME as nvarchar) + ' ;' +
cast (@@TRANCOUNT as varchar) + ' ;' +  -- ���������� ������� ����������� ����������
cast(@@FETCH_STATUS as varchar) + ' ;' +
cast(@@NESTLEVEL as varchar);  -- ������� ����������� ������� ���������



-- 4: 
--4.1:

declare 
@number int ,
@x int , 
@z float ,
@e float = exp(2.718);

set @number = 3; 
set @x = 2; 
if @number > @x 
begin
set @z = POWER(sin(@number),2);
print 'Z:' + convert(varchar,@z);
end 
else if (@number < @x) 
begin
set @z = 4 * (@number + @x) 
print 'Z:' + convert(varchar(50),@z);
end
else if(@number = @x) 
begin
set @z = 1 -  POWER(@e , @x -2);
print 'Z:' + convert(varchar(10),@z);
end

-- 4.2 
declare 
@name char(10) = '���������',
@surname char(10) = '�����������',
@fatherName char(10) = '��������';

print @surname + ' ' + @name + ' ' + 
@fatherName 

print @surname + ' ' + substring(@name , 1 ,1)+'.' + substring(@fatherName,1,1)+'.';



-- 4.3 

use UNIVER
declare 
@curDate date = getdate()
select STUDENT.BDAY ,STUDENT.NAME , datediff(year, STUDENT.BDAY , @curDate)  [�������] from STUDENT
where MONTH(STUDENT.BDAY) > MONTH(@curDate);




-- 4.4 :
use UNIVER
declare
@group int = 2;
select TIMETABLE.DAY_NAME , TIMETABLE.SUBJECT , @group [������] from TIMETABLE
where TIMETABLE.IDGROUP = @group and TIMETABLE.SUBJECT like '����'



-- 5: 

declare 
@student int = 1001 ,
@note int;

if @student <= 1005 
begin 
select @note = PROGRESS.NOTE from PROGRESS 
where PROGRESS.IDSTUDENT = @student
select @note [NOTE]
end
else 
print '�� � ��� ���������'


-- 6:
declare 
@facName varchar(50) = '��'

if @facName = '��'
begin
select 
case 
 when PROGRESS.NOTE  in(6,7) then '6-7'
 when PROGRESS.NOTE  in(8,9) then '8-9'
 else '������ ��������'
 end ������ , count(*) as [����������� ���������]
 from PROGRESS 
 where exists (select GROUPS.FACULTY from GROUPS where GROUPS.FACULTY = @facName)
  group by  case 
 when PROGRESS.NOTE  in(6,7) then '6-7'
 when PROGRESS.NOTE  in(8,9) then '8-9'
 else '������ ��������'
 end 
end
else print '������ ���������� ���'


-- 7: 
use tempdb
create table #Test (
ID int , Name varchar(50) , Age int )
declare 
@counter int = 1
while @counter <= 5 
begin
insert #Test(ID,Name,Age) 
values (@counter , NULL , @counter + 10)
set @counter += 1
end
select * from #Test

drop table #Test

-- 8: 

declare 
@numerator int = 0;
while @numerator != 5
begin
set @numerator += 1;
print 'NUM is now: ' + convert(varchar,@numerator)

end
if @numerator = 5 
return

-- 9:
use �����������_�����
begin try 
update ITEMS set Cost = '� ������!' where Save_Place like '�%'
end try
begin CATCH 
print ERROR_NUMBER() -- ��� ��������� ������
print ERROR_MESSAGE() -- ��������� �� ������
print ERROR_LINE() -- ����� ������ ��������� ������
print ERROR_PROCEDURE() -- ��� ��������� ��� NULL
print ERROR_SEVERITY() -- ������� ����������� ������
print ERROR_STATE() -- ����� ������
end CATCH

select * from ITEMS








