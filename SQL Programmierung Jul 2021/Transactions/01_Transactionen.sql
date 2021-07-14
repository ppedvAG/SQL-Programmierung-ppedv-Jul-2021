---Transaction

begin tran --transaction

--code: Zeile für Zeile


commit
rollback



begin tran

select * from customers
update Customers set City = 'Berlin' where CustomerID = 'ALFKI'
select * from customers
rollback

--Jede TX erzeugt Sperren...
--Jede TX die wir man uell einleiten muss manuell beendet werden

--READ COMMITED default: Lesen nach COMMIT/ROLLBACK
set transaction isolation level read committed


--DS können erst nach Commit gelesen werden

--Sperren sind weg.. aber evtl massive Traffic auf tempdb
USE [master]
GO
ALTER DATABASE [Northwind] SET DATE_CORRELATION_OPTIMIZATION ON WITH NO_WAIT
GO
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO


--REPEATABLE READ.. keiner DS ändern die ich in der TX gelesen habe

--SERIALIZABLE .. keiner kann ins



set transaction isolation level read uncommitted

select * from customers where CustomerID = 'ALFKI' --DS kann gelesen werden


--DEADLOCK

begin tran
update customers set city = 'Bonn' where country = 'Germany'
--bis hier....
update orders set freight = freight *1.1 where shipcountry = 'germany'

--wer wird ausgewäht.. der mit den geringeren Kosten

rollback

--Deadlocks vermeiden: 
--versuche die Statements in eine gleiche zu bringen

-Sperrniveau ändern

Zeile, Seite, Block, Tab, DB

..jede Sperre kostet 91 bytes

--Zeile auf Seite
--viele Seiten --> Block
--viele Blöcke.-- Tab

--INDEX

select * into kunde from customers

sp_lock
rollback

drop table kunde






select * from kunde where customerid = 'ALFKI'

begin tran
update kunde set city ='Siegen' where customerid = 'ALFKI'
--wenn auf der Tab kunde kein IX exitert auf Sp Customerid, muss die gesamte Tabelle gesperrt werden

--Partitionierung...?

--Part1  0 bis 100
--Part2: 101 bis 200
--Part3: 201 bis 20000

update ptab set sp = 10 where nummer = 117 --es wird nur die Part 2 gesperrt

--TX so schnell wie möglich durchziehen.. keine Fragen in der TX, sondern vorher


select * into customers2 from customers



Begin tran T1 --für den Admin Restore
update customers2 set city = 'X'
select * from customers2

begin tran M1 with Mark
update customers2 set city = 'Y'
select * from customers2

select @@trancount

---commit  --jede TX muss committed werden

--rollback --alle TX werden Rückgängig

save transaction innerSave
select * from customers2


begin tran M2 with mark
update customers2 set city = 'Z'
select * from customers2
Commit
rollback tran Innersave












