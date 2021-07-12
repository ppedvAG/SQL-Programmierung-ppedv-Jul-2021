/*

Indizes
Datentypen
Normalisierung
Schlüssel PK FK
Normalisierung
1 NF atomar jede Zelle sollte einen Wert haben
2 NF PK
3 NF alle Werte ausserhalb des PK haben keine Abhängikeit untereinander
Gengenteil: Redundanz

Unter der Haube





--wieoso sollte das so sein

Beziehungen ref Integrität.. schnell




*/

delete Customers where CustomerID = 'FISSA'


select * from orders

andreasr | ppedv.de

---Datentypen

/*
'Otto'

varchar(50)  'Otto'  4   
nvarchar(50) 'Otto'   4 * 2   8 
char(50)    'Otto                           '  50
nchar(50)   'Otto                           ' 50 *2   100


Datum
time
date  (nur Datum)
smalldatetime (auf Sekunde)
datetime  (ms)
datetime2 (ns)
datetimeoffset (ns und Zeitzone)





text()--depricated seit 2005


Daten werden 1:1 wie sie auf der HDD liegen in den RAM kopiert----!!

Alle Datensätze kommen in Tabellen, aber Tabellen bestehen aus:


Seiten und Blöcken

Eine Seite hat immer 8192bytes
Eine Seite kann max 700 DS haben
1 DS kann max 8060 bytes haben
1 Seite kann max 8072 bytes Datensätze haben
1 DS muss idR in die Seite passen











*/


select country, customerid From Customers

--geht nicht
create table t1 (id int identity, sp1 char(4100), sp2 char(4100))

create table t1 (id int identity, sp1 char(4100), sp2 varchar(4100))


use Northwind

create table t1 (id int identity, spx char(4100))


insert into t1
select 'XY'
GO 20000

set statistics io, time on --off gilt nur für diese Sitzung


select * from t1 where id =5 --logische Lesevorgänge: 20000

dbcc showcontig('t1')


--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%

--alle Bestellungen aus dem Jahr 1997
--richtig aber langsam wg IX (kann nicht gut verwendet werden)
--F im where führend dazu jeden DS genau anschauen zu müssen...
select * from orders where YEAR(OrderDate) =1997


--schnell aber falsch wg Datentyp datetime (ungenau auf 3 -4  ms genau)
select * from orders where OrderDate between '1.1.1997' and '31.12.1997 23:59:59.999'









