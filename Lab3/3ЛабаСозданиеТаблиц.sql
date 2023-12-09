
use master;
go

create database Лемешевский_Склад_2 on primary 
(
    name = N'Лемешевский_Склад_2_mdf',
    filename = N'C:\Users\Влад\Desktop\BD\емешевский_Склад_2_mdf.mdf',
    size = 10MB, 
    maxsize = unlimited,
    filegrowth = 1024KB 
),
filegroup FileGroup1
(
    name = N'Лемешевский_Склад_2_fg1_1',
    filename = N'C:\Users\Влад\Desktop\BD\емешевский_Склад_2_fg1_1.ndf',
    size = 10MB,
    maxsize = 1GB, 
    filegrowth = 25% 
),
(
    name = N'Лемешевский_Склад_2_fg1_2',
    filename = N'C:\Users\Влад\Desktop\BD\емешевский_Склад_2_fg1_2.ndf',
    size = 10MB,
    maxsize = 1GB,
    filegrowth = 25% 
)
log on 
(
    name = N'Лемешевский_Склад_2_log',
    filename = N'C:\Users\Влад\Desktop\BD\емешевский_Склад_2_log.ldf',
    size = 10MB,
    maxsize = 2048GB, 
    filegrowth = 10% 
);



use Лемешевский_Склад_2;

create table StorageCells(
Cell_Number int primary key not null,
Cell_Count int 
) on FileGroup1;

create table ITEMS (
  ID int  primary key not null,
  Item_Name nvarchar(50) not null,
  Cost smallmoney not null,
  Opisanie nvarchar(100) not null,
  Save_Place nvarchar(20) not null,
  Item_Count int not null,
  Cell_Number int not null foreign key references StorageCells(Cell_Number)
)on FileGroup1;
create table CUSTOMERS(
Buyer_ID int primary key not null,
Buyer_Name nvarchar(50) not null,
Phone_Number bigint not null,
Aress nchar(10) not null
) on FileGroup1;

create table Transactions(
Order_ID int primary key not null ,
Order_date date not null,
Buyer_ID int not null foreign key references CUSTOMERS(Buyer_ID),
Item_ID int not null foreign key references ITEMS(ID),
Item_Count int not null
) on FileGroup1;




