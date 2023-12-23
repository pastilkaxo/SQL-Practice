-- 1:
use EXAM
go
create procedure TASK_ONE @N varchar(15) as
begin
select b.NAME,b.REP_OFFICE from SALESREPS b
inner join OFFICES on OFFICES.OFFICE = b.REP_OFFICE
and b.NAME not like @N 
where  exists (
select SALESREPS.REP_OFFICE from SALESREPS where SALESREPS.NAME like @N and SALESREPS.REP_OFFICE = b.REP_OFFICE 
)
end;
go
exec TASK_ONE @N = '%Smith'
drop procedure TASK_ONE

-- 2:

use EXAM
go
create function TASK_TWO (@sn varchar(15)) returns varchar(20) 
as 
begin
declare New cursor local static
for select SUBSTRING(SALESREPS.NAME,5,10) from SALESREPS 
inner join SALESREPS b on b.MANAGER = SALESREPS.EMPL_NUM and b.NAME like @sn
open New
declare @cn varchar(20)
fetch New into @cn
return @cn
end;
go
select dbo.TASK_TWO('Mary Jones') [Фамилия начальника]
drop function TASK_TWO