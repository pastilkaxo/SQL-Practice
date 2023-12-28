-- 1:

use UNIVER
go
select * from TEACHER
where TEACHER.PULPIT = '����' 
for XML PATH('�������������'), root('������_��������������') ,
elements

-- ��� ���� ��: 

use �����������_�����_2
go
select * from ITEMS
for XML PATH('������'), root('������_���������') ,elements
go
use UNIVER

-- 2:

select AUDITORIUM.AUDITORIUM , AUDITORIUM_TYPE.AUDITORIUM_TYPE 
from AUDITORIUM
inner join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
and AUDITORIUM_TYPE.AUDITORIUM_TYPE like '��%'
for XML AUTO , root('������_���������') ,elements



-- 3:

declare @h int = 0
declare @x varchar(3000) = 
'<?xml version="1.0" encoding="windows-1251" ?>
<SUBJECTS>
  <SUBJECT SUBJECT="��" SUBJECT_NAME="�����������" PULPIT="����"/>
  <SUBJECT SUBJECT="��" SUBJECT_NAME="������������" PULPIT="����"/>
  <SUBJECT SUBJECT="��" SUBJECT_NAME="����-����������" PULPIT="����"/>
</SUBJECTS>
';
exec sp_xml_preparedocument @h output, @x;
insert SUBJECT
select [SUBJECT] , [SUBJECT_NAME] , [PULPIT] 
from openxml(@h,'/SUBJECTS/SUBJECT',0)
with([SUBJECT] char(10),[SUBJECT_NAME] varchar(100),[PULPIT] char(20))
select * from SUBJECT where SUBJECT.PULPIT = '����'
exec sp_xml_removedocument @h

-- ��� ���� ��: 

use �����������_�����_2
go
declare @hi int = 0 ,
@xi  varchar(3000) =
'
<?xml version="1.0" encoding="windows-1251" ?>
<������_���������>
  <������� ID="56" Item_Name="laba16"  Cost="50.000" Opisanie="Good" Save_Place="Minsk" Item_Count="21" Cell_Number="1"/>
</������_���������>
'
exec sp_xml_preparedocument @hi output , @xi
insert ITEMS 
select [ID] ,[Item_Name] , [Cost] , [Opisanie] , [Save_Place] , [Item_Count] , [Cell_Number]
from openxml(@hi, '/������_���������/�������',0)
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
'����������� ��������� ��������',
'2004-04-25',
'
<�������>
   <������� �����="MP" �����="76589918" ����="25.04.2004"/>
   <�������>293074700</�������>
   <�����>
      <������>��������</������>
	  <�������>7</�������>
      <�����>�����</�����>
	  <�����>����� ������</�����>
	  <���>21</���>
	  <��������>2</��������>
   </�����>
</�������>
'
)
go
select * from STUDENT where BDAY = '2004-04-25'
go
update STUDENT set INFO = '
<�������>
   <������� �����="MP" �����="76589918" ����="25.04.2004"/>
   <�������>293074700</�������>
   <�����>
      <������>��������</������>
	   <�������>3</�������>
      <�����>�����</�����>
	  <�����>���������</�����>
	  <���>2</���>
	  <��������>0</��������>
   </�����>
</�������>
' where STUDENT.NAME like '�����������%'
go
select * from STUDENT where BDAY = '2004-04-25'
go
select STUDENT.NAME , STUDENT.INFO.value('(/�������/�������/@�����)[1]','varchar(10)') [����� ��������] ,
STUDENT.INFO.value('(/�������/�������/@�����)[1]','varchar(15)') [����� ��������], 
STUDENT.INFO.query('/�������/�����') [�����]
from STUDENT 
 where STUDENT.NAME like '�����������%'
go
delete STUDENT  where STUDENT.NAME like '�����������%'

-- 5:

use UNIVER
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="�������">  
       <xs:complexType><xs:sequence>
       <xs:element name="�������" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="�����" type="xs:string" use="required" />
       <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="����"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
   <xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�������" type="xs:integer"/>
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
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
rtrim(f.FACULTY) as [@���] ,
(
 select count(*) from PULPIT
 where PULPIT.FACULTY = f.FACULTY
 for XML PATH('') , TYPE
) as [�����������_������] ,
(
select rtrim(PULPIT.PULPIT) as [@���] ,
(
select 
rtrim(TEACHER.TEACHER) as [@���],
rtrim(TEACHER.TEACHER_NAME)
from TEACHER
where TEACHER.PULPIT = PULPIT.PULPIT
for XML PATH('�������������'), type
) as [�������������]
from PULPIT
where PULPIT.FACULTY = f.FACULTY
for XML PATH('�������'),type
) as [�������]
from FACULTY f
for XML PATH('���������'), root('�����������') , TYPE

