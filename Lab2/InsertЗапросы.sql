

insert into StorageCells(Cell_Number,Cell_Count)
values
  (1, 200),
  (2, 150),
  (3, 100);

insert into ITEMS(ID,Item_Name,Item_Count,Cost,Opisanie,Save_Place,Cell_Number)
values 
  (1 , 'Grysha' , 20 , 50 , 'New,bright' , 'Minsk' , 1 ),
  (2 , 'Arbyz' , 15 , 35 , 'New,bright' , 'Pinsk' , 2 ),
  (3 , 'Vishna' , 10 , 40 , 'New,bright' , 'Moskva' , 3 );
insert into CUSTOMERS(Buyer_ID,Buyer_Name,Aress,Phone_Number,AGE)
values
  (1 , 'Vlad' , 'Minsk' , 294076577,18),
  (2 , 'Dima' , 'Piter' , 297876577,18),
  (3 , 'Max' , 'Globin' , 29353577,20);
insert into Transactions(Order_ID,Order_date,Buyer_ID,Item_ID,Item_Count)
values
  (1, '2024-04-25', 2 , 2 , 10),
  (2 , '2023-06-23', 1,3,20),
  (3, '2024-04-12',3,1,30);

