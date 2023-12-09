-- 1 

select * from ITEMS;

-- 2 

select Item_Name,Cost from ITEMS;

-- 3

select count(*) Item_Name from CUSTOMERS;

-- 4

UPDATE ITEMS set Cost = 25 where Item_Count<=15;
select Item_Name,Cost from ITEMS where Cost < 30; 


