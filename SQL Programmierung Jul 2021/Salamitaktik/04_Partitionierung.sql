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
select * from ptab where id = 117 --20000


--Grenzen sind extrem einfach manipulierbar
--Archivierung


select * from ptab where nummer = 1117  --19800

-----------100------200-------------5000  ----------

--neue Grenze
--ptab  f()  schZahl

--ptab  egal.. 
--zuerst das schema

--Dgruppe zu Schema hinzufügen
alter partition scheme schZahl next used bis5000


select $partition.fzahl(nummer),
	min(nummer), max(nummer), count(*)
from ptab
group by $partition.fzahl(nummer)

--neue Grenze 5000
alter partition function fzahl()
		split range(5000)

select * from ptab where nummer = 1117 --4800 Seiten

--Tipp: die Partitionen verhalten sich wie Tabellen

----100-------200---------------5000--------------

--Grenze 100 entfernen...
--ptab  f() schema

--f()  

alter partition function fzahl() merge range(100)

select * from ptab where nummer =117

--------200-------------5000-------------


select * from ptab where id = 100
--Idee : DS die man nicht mehr braucht.. archivieren

--TSQL verschiebe DS von a nach b

/****** Object:  PartitionScheme [schZahl]    Script Date: 12.07.2021 13:56:46 ******/
CREATE PARTITION SCHEME [schZahl] 
AS 
PARTITION [fZahl] TO ([bis200], [bis5000], [rest])

/****** Object:  PartitionFunction [fZahl]    Script Date: 12.07.2021 13:57:31 ******/
CREATE PARTITION FUNCTION [fZahl](int) AS
RANGE LEFT FOR VALUES (200, 5000)
GO

--Archivtabelle

create table archiv --muss auf DGruppen liegen, die später geswitched wird
		( id int not null
		, nummer int
		, spx char(4100)) ON bis200


alter table ptab switch partition 1 to archiv--


--100 MB/sek
--10000000000000000 MB Bereich 1 ..2ms

select * from archiv

select * from ptab where nummer = 117


--Wieviele Teile kann man machen: 15000 pro Tabelle
















--Jahresweise
create partition function fZahl(datetime)
as
RANGE LEFT FOR VALUES('31.12.2021 23:59:59.999','')

----abisM   NbisR  SbisZ
create partition function fZahl(varchar(50))
as
RANGE LEFT FOR VALUES('MZZZZZZZ','S')


select $partition.fzahl(117) -- 2


--Part Schema
create partition scheme schZahl
as
partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])

--ist auch gut.. weil sich die kleine Teile wie kleine Tabellen verhalten

-----