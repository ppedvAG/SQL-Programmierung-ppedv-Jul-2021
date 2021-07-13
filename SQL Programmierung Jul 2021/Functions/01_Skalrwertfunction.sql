--Functions

--Einsatz von F() .... super flexibel

select f(SP), f(Wert) from f(Wert) where f(SP) < f(Wert)

--Skalarwertfunction

--Bruttoerrechnen

create function fdemo1 (@par1 int) returns int
as
begin
	return (select @par1*100)
end

select fdemo1(10)--error

--kompletter Name 
select * from Datenbank.schema.Objekt






select * from Northwind.dbo.orders

select * from dbo.orders

select * from orders

select * from Northwind..orders

select dbo.fdemo1(100)


--dbo.fbrutto(@nettowert) ... 1.19




create function fdemo1 (@par1 int) returns int
as
begin
	return (select @par1*100)
end


create function dbo.fbrutto (@netto money) returns money
as
begin
	return (select @netto*1.19)
end


--Wir suchen alle orders, deren Frachtkosten weniger als 50 brutto sind

select * from orders 
					where dbo.fbrutto(Freight) <50 --wird nie SEEK machen..f89 werden nie parallelisisoert




select * from orders where freight < 50/1.19 --SEEK


--suche alle Angestellten, die heute im Rentenalter sind (65)

select * from employees

select DATEDIFF(yy, Getdate(), '2.2.2020') --Anzahl(int)

select DATEADD(yy,10,Getdate()) --Datum

select * from Employees 
					where DATEDIFF(YY,Birthdate,GETDATE()) <=65--immer SCAN


--besser:

select * from Employees 
					where birthdate <= DATEADD(yy,-65, getdate())

--Idee: dbo.RngSumme(orderid)
select sum(UnitPrice*Quantity) from [Order Details] where OrderID = 10248

create function frngSumme(@bestnr int) returns money
as
Begin
return (select sum(UnitPrice*Quantity) from [Order Details] where OrderID = @bestnr)
end

--praktisch
select dbo.frngsumme(orderid) from orders where dbo.frngsumme(OrderID) < 10250


alter table orders add  RngSumme as dbo.frngsumme (orderid)

select * from orders where RngSumme < 50

--Versuche solange es geht F() zu vermeiden
--weil fast immer es zu SCANS führt
--oft im Plan nicht erscheinen (tast.)
--und nicht maxdop verwenden
--erst SQL 2019 kann einfach F() in Unterabfragen umbauen


--Tabellenwertfunktionen
--die werden entweder mit 1 oder 100 DS geschätzt 
--
--Fazit alle F() bis auf eine sind schlecht.. TabellenInlineF()

