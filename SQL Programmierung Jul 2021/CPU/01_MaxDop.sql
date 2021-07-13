--Spieltabelle

SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, 
                         Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Employees.LastName, Employees.FirstName, Products.ProductName, Products.UnitsInStock
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID

insert into KU
select * from ku
--wenn 551 000 eingefügt wurden


--Kopie zum SPielen
select * into ku1 from ku

--und eine ID Spalte dazu
alter table ku1 add id int identity


--Thema CPU..

set statistics io, time on

select * from ku1 where ID= 100

--mehr CPUs weniger Dauer!!!

--Was macht SQL Server mit Abfragen..

--default: er verwendet bis SQL 2014 inkl alle CPUs für Abfragen
---        aber erst wenn der Pöan sagt, dass die SQL Dollar über 5 liegen
--         5 SQL Dollar ist aber nicht viel

--man sollt enie meh als 8 CPUs pro Abfrage verwenden

select country, city, SUM(unitprice*quantity)
from ku1
group by Country, city option (maxdop 1) --t = 422 ms, verstrichene Zeit = 421 ms.

select country, city, SUM(unitprice*quantity)
from ku1
group by Country, city option (maxdop 8)  --, CPU-Zeit = 814 ms, verstrichene Zeit = 127 ms.


select country, city, SUM(unitprice*quantity)
from ku1
group by Country, city option (maxdop 6) --, CPU-Zeit = 750 ms, verstrichene Zeit = 135 ms.


select country, city, SUM(unitprice*quantity)
from ku1
group by Country, city option (maxdop 4) --, CPU-Zeit = 578 ms, verstrichene Zeit = 155 ms.


--tauchen im Plan Repartion Stream und Gather Stream mit % auf.. dann
--sind ziemlich sicher weniger CPUS besser


select country, city, SUM(unitprice*quantity)
from ku1
where Country like 'A%'
group by Country, city option (maxdop 1)