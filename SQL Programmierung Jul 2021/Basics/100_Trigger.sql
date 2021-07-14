/*

DDL					DML
CR AL DR		   INS UP DEL


Trigger reagieren auf eine Ereignis..langsam
Trigger auf Tabellen oder auch Sichten
Trigger... Hintergrund

--Idee.. Standardwerte, Protokollierung (Änderung von Tabellen), Versionierung/Historie Papierkorb, Redundante Daten pflegen



*/


create trigger  trgKunde on KundenEu
for insert, update, delete --instead_of
as
select * from inserted --INS  UP
select * from deleted  --DEL  UP

select * from kundeneu

insert into KundenEU
select 'BBBBB', 'Fa B', 'Austria', 'Wien'


update KundenEU set city = 'Köln' where country= 'Germany' 


alter trigger  trgKunde on KundenEu
for insert, update, delete
as
select * from inserted --INS  UP
select * from deleted  --DEL  UP
select * from kundeneu --Daten des I U D sind bereits in der Tabelle


--TX
--auch jeder I U D = TX

--TX --> U I D --> TR --> UID --> TX ROLLBACK

Begin Tran
u
i 
d
---Trigger I U D
rollback


create trigger  trgKunde on KundenEu
for insert, update, delete --instead_of
as
select * from inserted --INS  UP
select * from deleted  --DEL  UP


--Idee : Rngsumme

alter table orders add RechSumme money
--immer der korrekte Summenwert der Rechnung

--Trigger wo: order details  (ins up del)--Orderid-- update orders Rechsumme

create trigger trgRsumme on [Order details]
for insert, update, delete
as
/*Rechnungsumme errechnen
select SUM(unitprice*quantity) from [Order Details] where OrderID = 10248
*/
--Wie finde ich die BestellNr heraus?
declare @orderid int, @rsumme money

select @orderid = orderid from inserted
select @rsumme=SUM(unitprice*quantity) from [Order Details] where OrderID = @orderid


--Ändern der RechSumme in Orders
update orders set RechSumme = @rsumme  where OrderID = @orderid
GO

select SUM(unitprice*quantity) from [Order Details] where OrderID = 10248

select * from [Order Details]

update [Order Details] set Quantity=13 where OrderID = 10248 and ProductID=11

select * from Orders






---DDL

alter trigger trgdemo1 on database --on Server
for ddl_database_level_events --ALTER_PROCEDURE
as
select EVENTDATA() --xml nachricht
insert into logging (nachricht, datum) values (EVENTDATA(), GETDATE())

alter table kundeneu add spx2 int


create table logging (id int identity, nachricht xml, Datum datetime)

select * from logging



create trigger trgdemo10 on database
for ddl_database_level_events --doof
as
rollback;
GO



















