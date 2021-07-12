--Prozeduren..


/*
..sind schneller.. aber warum?
Mythos: kompiliert.. der Plan wird hinterlegt


*/

--Pl�ne..
set statistics io , time on
select * from orders where CustomerID like 'A%'

--SCAN: von A bis Z alles durchsuchen
--SEEK: gezieltes heraussuchen.. schnellste Suche

--Im Plan sind auch Kosten und Sch�tzwerte
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

--der Plan wird nicht mehr ge�ndert.. alsio insofern werden 
--ung�nstige Pl�ne verwendet


--Tipp: Proz dr�fen nicht benutzerfreundlich sein

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
exec gpdemo2 100, @brutto=@ergebnis output  --Output damit der Wert in die ext Var zur�ckgeschrieben wird
select @ergebnis 


declare @ergebnis as int --Variable ausserhalb deklarieren
exec gpdemo2 100, @ergebnis=@brutto output  --Output damit der Wert in die ext Var zur�ckgeschrieben wird
select @ergebnis 

exec gpdemo2 @brutto=3, @netto= 100


