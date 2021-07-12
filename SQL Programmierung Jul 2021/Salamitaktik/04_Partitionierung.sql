--seit SQL 2016 SP1 ist auch die SSEX fast auf Ent Niveau


--Dateigruppen

/*


DB  ldf Datei Logfile 
und mdf  Datendatei
..weitere ndf..

*/

create table test (id int) on [PRIMARY]

create table test3 (id int) on 'c:flöaksöl\öldkalösd.ndf'


create table test2 (id int) on HOT

---4 Dgruppen
--bis100  bis200 bis5000 rest

--Zuerst F() für Zahlenstrahl

--------100---------------200------------------
--  1           2                     3


create partition function fZahl(int)
as
RANGE LEFT FOR VALUES(100,200)


select $partition.fzahl(117) -- 2


--Part Schema
create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
---                     1    2     3

create table ptab(
				  id int identity
				, nummer int
				, spx char(4100)
				) on schZahl(nummer)

set statistics io, time off
set showplan_Xml off
set nocount on

declare @i as int=1

while @i <=20000
	begin
			insert into ptab values(@i,'XY')
			set @i=@i+1
	end

set statistics io, time on

select * from ptab where nummer = 117 -- Lesevorgänge: 100,
select * from ptab where id = 117


--Grenzen sind extrem einfach manipulierbar
--Archivierung







