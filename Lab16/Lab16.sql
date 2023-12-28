-- 1:

use UNIVER
go
select * from TEACHER
where TEACHER.PULPIT = 'ИСиТ' 
for XML PATH('Преподаватель'), root('Список_преподавателей') ,
elements

-- Для моей бд: 

use Лемешевский_Склад_2
go
select * from ITEMS
for XML PATH('Продкт'), root('Список_продкутов') ,elements
go
use UNIVER

-- 2:

select AUDITORIUM.AUDITORIUM , AUDITORIUM_TYPE.AUDITORIUM_TYPE 
from AUDITORIUM
inner join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
and AUDITORIUM_TYPE.AUDITORIUM_TYPE like 'ЛК%'
for XML AUTO , root('Список_аудиторий') ,elements



-- 3:

declare @h int = 0
declare @x varchar(3000) = 
'<?xml version="1.0" encoding="windows-1251" ?>
<SUBJECTS>
  <SUBJECT SUBJECT="ВМ" SUBJECT_NAME="Владоматика" PULPIT="ИСиТ"/>
  <SUBJECT SUBJECT="НМ" SUBJECT_NAME="Никитоматика" PULPIT="ИСиТ"/>
  <SUBJECT SUBJECT="НТ" SUBJECT_NAME="Нано-технологии" PULPIT="ИСиТ"/>
</SUBJECTS>
';
exec sp_xml_preparedocument @h output, @x;
insert SUBJECT
select [SUBJECT] , [SUBJECT_NAME] , [PULPIT] 
from openxml(@h,'/SUBJECTS/SUBJECT',0)
with([SUBJECT] char(10),[SUBJECT_NAME] varchar(100),[PULPIT] char(20))
select * from SUBJECT where SUBJECT.PULPIT = 'ИСиТ'
exec sp_xml_removedocument @h

-- Для моей бд: 

use Лемешевский_Склад_2
go
declare @hi int = 0 ,
@xi  varchar(3000) =
'
<?xml version="1.0" encoding="windows-1251" ?>
<Список_продуктов>
  <Продукт ID="56" Item_Name="laba16"  Cost="50.000" Opisanie="Good" Save_Place="Minsk" Item_Count="21" Cell_Number="1"/>
</Список_продуктов>
'
exec sp_xml_preparedocument @hi output , @xi
insert ITEMS 
select [ID] ,[Item_Name] , [Cost] , [Opisanie] , [Save_Place] , [Item_Count] , [Cell_Number]
from openxml(@hi, '/Список_продуктов/Продукт',0)
with([ID] int ,[Item_Name] nvarchar(50) , [Cost] smallmoney , [Opisanie] nvarchar(100), [Save_Place] nvarchar(20), [Item_Count] int, [Cell_Number] int)
select * from ITEMS;
exec sp_xml_removedocument @hi
go
use UNIVER


-- 4:
use UNIVER
go
insert into STUDENT(IDGROUP, NAME, BDAY, INFO)
values(
2,
'Лемешевский Александр Олегович',
'2004-04-25',
'
<студент>
   <паспорт серия="MP" номер="76589918" дата="25.04.2004"/>
   <телефон>293074700</телефон>
   <адрес>
      <страна>Беларусь</страна>
	  <область>7</область>
      <город>Минск</город>
	  <улица>Якуба Коласа</улица>
	  <дом>21</дом>
	  <квартира>2</квартира>
   </адрес>
</студент>
'
)
go
select * from STUDENT where BDAY = '2004-04-25'
go
update STUDENT set INFO = '
<студент>
   <паспорт серия="MP" номер="76589918" дата="25.04.2004"/>
   <телефон>293074700</телефон>
   <адрес>
      <страна>Беларусь</страна>
	   <область>3</область>
      <город>Пинск</город>
	  <улица>Цветочная</улица>
	  <дом>2</дом>
	  <квартира>0</квартира>
   </адрес>
</студент>
' where STUDENT.NAME like 'Лемешевский%'
go
select * from STUDENT where BDAY = '2004-04-25'
go
select STUDENT.NAME , STUDENT.INFO.value('(/студент/паспорт/@серия)[1]','varchar(10)') [серия паспорта] ,
STUDENT.INFO.value('(/студент/паспорт/@номер)[1]','varchar(15)') [номер паспорта], 
STUDENT.INFO.query('/студент/адрес') [адрес]
from STUDENT 
 where STUDENT.NAME like 'Лемешевский%'
go
delete STUDENT  where STUDENT.NAME like 'Лемешевский%'

-- 5:

use UNIVER
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="студент">  
       <xs:complexType><xs:sequence>
       <xs:element name="паспорт" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="серия" type="xs:string" use="required" />
       <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="дата"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
   <xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="область" type="xs:integer"/>
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';
go
alter table STUDENT drop column INFO
go
alter table STUDENT add  INFO xml(Student)
go
drop xml schema collection Student

-- 7:

use UNIVER
go
select 
rtrim(f.FACULTY) as [@код] ,
(
 select count(*) from PULPIT
 where PULPIT.FACULTY = f.FACULTY
 for XML PATH('') , TYPE
) as [колличество_кафедр] ,
(
select rtrim(PULPIT.PULPIT) as [@код] ,
(
select 
rtrim(TEACHER.TEACHER) as [@код],
rtrim(TEACHER.TEACHER_NAME)
from TEACHER
where TEACHER.PULPIT = PULPIT.PULPIT
for XML PATH('преподаватель'), type
) as [преподаватели]
from PULPIT
where PULPIT.FACULTY = f.FACULTY
for XML PATH('кафедра'),type
) as [кафедры]
from FACULTY f
for XML PATH('факультет'), root('университет') , TYPE

