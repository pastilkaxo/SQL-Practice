use Лемешевский_Склад_2

alter Table StorageCells add Cell_Id int;

alter Table StorageCells drop column Cell_Id;

alter Table CUSTOMERS add AGE int  default 18 check (AGE in (18 , 20));




/* alter Table CUSTOMERS drop column AGE; */