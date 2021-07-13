--Prozeduren..


/*
..sind schneller.. aber warum?
Mythos: kompiliert.. der Plan wird hinterlegt


*/

--Pläne..
set statistics io , time on
select * from orders where CustomerID like 'A%'

--SCAN: von A bis Z alles durchsuchen
--SEEK: gezieltes heraussuchen.. schnellste Suche

--Im Plan sind auch Kosten und Schätzwerte
--Der Plan errechnet Kosten (SQL Dollar)

--Idee der Proz: der Plan wird einmal errechnet und hinterlegt
---und ist auch nach dem Neustart immer vorhanden

--Proz funktioniert wie Batch
create proc gpDemo @par1 int
as
select * from tabelle where Sp = @par1
Go

exec gpDemo 2

--Schreibe eine Prozedur, die nach Kunden sucht
select * from customers

exec gpKundenSuche 'ALFKI' --1 Kunde
exec gpKundenSuche 'A%' --4 Kunde
exec gpKundenSuche '%' --alle Kunden


alter proc gpKundenSuche @CustID varchar(5)='%'
as
select * from Customers where CustomerID like @Custid +'%'

exec gpKundenSuche 'ALFKI' --1 Kunde




exec gpKundenSuche 'A' --4 Kunde
exec gpKundenSuche  --alle Kunden

--ist aber schlecht


--Vorteil der Prozedur: Plan wir einmal festgelegt
--mit dem ersten Aufruf (mit dem ersten Parameter)

--der Plan wird nicht mehr geändert.. alsio insofern werden 
--ungünstige Pläne verwendet


--Tipp: Proz drüfen nicht benutzerfreundlich sein

create proc gpkundensuche @par char(5)
as
if
 exec gpKundensuche1 
else
exec gpkundensuche2 '%'








--

create proc gpdemo2 @netto int, @brutto int output
as
select @brutto = @netto * 1.19;
GO

--der Output hat es auf sich

exec gpdemo2 100 --error erwartet den Brutto Parameter

exec gpdemo2 100,100 --.. wie komm ich an Brutto

declare @ergebnis as int --Variable ausserhalb deklarieren
exec gpdemo2 100, @brutto=@ergebnis output  --Output damit der Wert in die ext Var zurückgeschrieben wird
select @ergebnis 


declare @ergebnis as int --Variable ausserhalb deklarieren
exec gpdemo2 100, @ergebnis=@brutto output  --Output damit der Wert in die ext Var zurückgeschrieben wird
select @ergebnis 

exec gpdemo2 @brutto=3, @netto= 100




--jetzt mit Indizes
select * from ku1 where id < 2  -- IX Seek
select * from ku1 where id < 12000 --CL IX SCAN

--jetzt mit Proc

create proc gpdemo3 @par1 int 
as
select * from ku1 where id < @par1;
GO

set statistics io, time on
exec gpdemo3 2 --6 Seiten ca 0ms

exec gpdemo3 1000000 --6 Seiten ca 0ms ... 3008162!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--Irre..weil der Plan ja immer derselbe sein wird...auch bei Neustart des Server
--der erste Aufruf der Proc ersteltl den Plan

dbcc freeproccache


exec gpdemo3 1000000

exec gpdemo3 2

--wekcher Plan ist nun besser:
--was fragst du ab.. häufig kleine Werte für ID: SEEK
--häufig beides: SCAN
--häfugi große ID: SCAN

