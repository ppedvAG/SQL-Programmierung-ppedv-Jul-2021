/*
Gr IX
NGR IX

eindeutiger IX
zusammengesetzter IX
IX mit eingeschl Spalten
ind Sicht
gefilterter IX
partitionierter IX

abdeckender IX = ideale IX

realer hypothetischer IX (Tool)

Columnstore










Gr IX = Tabelle in sortierter Form
nur einmal pro Tabelle
besonders geeignet für Bereichsabfragen auch gut bei =


N Gr IX= Kopie der Daten mit Suchstrukturen
auch 1000 mal pro Tabelle
gut bei rel geringer Ergebnismenge.. was ist relativ gering: auch ca 1%


..entscheidend: where 
	>
	<
	!=
	like 'A%'
	like '%A'
	between
	in
	=


eindeutiger IX (gr oder nicht Gruppiert)




*/

select * from best --CL IX SCAN.. why?????????
--der PK wird automatisch als CL IX angelegt, was aber nicht sein muss!!
--der muss ja nur eindeutig

--best practice.. Lege zuerst den GR IX an, dann den PK

select * from customers

insert into Customers (CustomerID, CompanyName) values ('ppedv', 'bbedv ag')

select * from orders


set statistics io, time on


select id from ku1 where id = 100 --muss ein TBALE SCAN --56867  200ms 

--immer zuerst festlegen, worauf wir den CL IX setzen
--Orderdate ersviert für CL IX

--NIX_ID eindeutig
select id from ku1 where id = 100 --reiner IX Seek --3 Seiten 0 ms



select id, freight from ku1 where id = 100 --IX SEEK mit Lookup --4 Seiten 0 ms

select id, freight from ku1 where id < 12000 --jetzt schon Table Scan

--Wir wollen LOOKUP vermeiden!!

--neuer IX: NIX_ID_FR (eindeutig)... zusammengesetzer IX (mehr Schlüsselspalten)

select id, freight from ku1 where id = 100 --IX SEEK 3 Seiten

select id, freight from ku1 where id < 512000 --auch hier noch reiner IX SEEK


--wiede rmit Lookup
--zusam. IX hat Limits: max 16 Spalten, max 900bytes
--besser mit IX mit eingeschlossene SPalten
--NIX_ID_i_FRCICY
select id, freight, City, country from ku1 where id = 100

--
select country, city, SUM(unitprice*quantity) from ku1
where EmployeeID = 3 and CustomerID like 'A%'
group by Country, city



--TIPP:: alle palten des where als Schlüsselspalten.. die selektivere zuerst
--alle Spalten des SELECT als "Spalten  enthalten" mit rein

CREATE NONCLUSTERED INDEX [NIX_EIDCID_I_UPQUCICY] ON [dbo].[ku1]
(
	[CustomerID] ASC,
	[EmployeeID] ASC
)
INCLUDE([City],[Country],[UnitPrice],[Quantity]) 
GO


select * from ku1 where City = 'London' and Country='UK'
--Reihenfolge der Schlüsselspalten: CITY COUNTRY



--jetzt mit OR..kein Vorschlag mehr von SQL Server

select country, city, SUM(unitprice*quantity) from ku1
where EmployeeID = 3 or CustomerID like 'A%'
group by Country, city
--es müssten zwei IX sein...

--Immer Klammer setzen
select country, city, SUM(unitprice*quantity) from ku1
where EmployeeID = 3 or CustomerID like 'A%' and Freight < 0.01
group by Country, city

select country, city, SUM(unitprice*quantity) from ku1
where (EmployeeID = 3 or CustomerID like 'A%') and Freight < 0.01
group by Country, city

--

select country, COUNT(*) from ku1
group by country


--Sicht 
create view vDemo with schemabinding
as
select country, COUNT_BIG(*) as Anzahl from dbo.ku1
group by country;
GO

select * from vdemo

select country, COUNT(*) from ku1
group by country

--automatische Unterschieben geht nur bei Ent Version
--das Ding ist extrem penible.. soviele Randbegdingen , dass es meist nicht klappt



--Hat sich das gelohnt: IX der gefiltert wird.. nur Datansätze aus UK zb

--Alternative ist der IX mit allen Ländern
--es könnte, dass dieser gefilterte IX nicht besser ist, als der der allen Länder beinhaltet

USE [Northwind]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [NonClusteredIndex-20210713-121406]    Script Date: 13.07.2021 12:23:18 ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210713-121406] ON [dbo].[ku1]
(
	[Freight] ASC,
	[Country] ASC
)
INCLUDE([CustomerID],[City]) 
WHERE ([country]='UK')



select freight, city, customerid
from ku1
where 
		Freight <10 and Country ='UK'

--der gefilterte IX ist dann von Vorteil, wenn wir weniger Ebenen im Ix bekommen


--COLUMNSTORE

--Where, AGG 
select top 3 * from ku1

--wilde Frage: Menge > 10, Schnitt des Preises , pro Produkt

select k.ProductName, AVG(unitprice) from ku1 k
where k.Quantity > 10
group by k.ProductName
--, CPU-Zeit = 187 ms, verstrichene Zeit = 176 ms.   6000 Seiten

--idealer IX: NIX_QU_i_PNUP


select * into ku2 from ku1


select k.ProductName, AVG(unitprice) from ku2 k
where k.Quantity > 10
group by k.ProductName

--ca 0 ms ... ca 0 Lesevorgänge
--Tabelle Ku1 = 320MB + 260 IX daten
--Tabelle Ku2 mit CSIX  3,5MB --komprimiert--nochmal komprimiert 3,2

--ku2 braucht immer noch ca 0 bis 6ms.. keine logschen Lesevorgänge


select k.ProductName, AVG(unitprice) from ku2 k
where k.EmployeeID =2
group by k.ProductName

--SuperIX aber Wartungspflichtig


--

--BackgroundInfo

/*
Reorg rebuild

200MB Heap
1 GR + 2 NG IX--> 363MB

Rebuild

Online  oder Offline
Tempdb od ohne TempDb

aufwendigste Variation: Online mit TempDB   1100MB
wenig aufwendig: ohne tempdb Offline:  890MB

jeden Tag IX Warting



*/



select * from ku1 where productname = 'XY' -- 56867


dbcc showcontig('ku1')
--- Gescannte Seiten.............................: 41080
--- Mittlere Seitendichte (voll).....................: 98.15%

--die zusätzlichen Seiten erklären sich aus der später hinzugefügten ID Spalte
--aber 15000 Seiten ????



--besser als der dbcc...
select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku1'),NULL, NULL, 'detailed')

--forward Record count: 15787 .. wie bekommen wir das weg: Gruppierter Index

select * from ku1 where ProductName ='XY'

--jede Tabelle sollte einen CL IX haben.. wenn nicht, dan Erklärung





