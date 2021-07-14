--CTE Common table expression

;with ctename (Nummer, KdNummer...) --alias für Ausgabe
as
(
--ABFRAGE
select Id, Customerid....
) 
select * from ctename where Kdnummer = 10


;with cte(Bid, Lieferkosten)
as
(select orderid , freight from Orders) --Idee .. man erspart sich das erstellen von #tabellen oder Unterabfragen
select * from cte where Bid < 11000



;with cte (orderid, summe, PrNummer,Proz)
as
(select top 100 percent orderid, SUM(unitprice*quantity) over (partition by orderid) SUMME, ProductID,
				convert(varchar(50),((UnitPrice*Quantity)/SUM(unitprice*quantity) over (partition by orderid))*100) +'%' as PROZ
from [Order Details]
order by 1,3 desc)
select *,rank() over  (partition by orderid order by proz)  from cte 

--Idee der CTE komplexen Unterabfragen zu vereinfachen

--Rekursionen aufzulösen

select EmployeeID, ReportsTo , Lastname from employees

---Billige CTE
--Liste alle angestellten per CTE ausgeben (Angid, VorgID, Lastname)

;with cte(Bid, Lieferkosten)
as
(select orderid , freight from Orders) --Idee .. man erspart sich das erstellen von #tabellen oder Unterabfragen
select * from cte where Bid < 11000

;with cte (AngId,VorID, FamName)
as
(select employeeid, reportsto, lastname from employees)
select * from cte


--Wieviele Kunden gibts im Schnitt pro Land.. ohne das Land zu nennen
select * from customers

--USA 5
--UK  2

;with cte(Land, anzahl)
as
(
select country, COUNT(*) from customers group by country
)
select AVG(anzahl) from cte

--Rekursion
select employeeid, reportsto from Employees

with ctename (sp1, sp2..)
as
(
select * from tab where --- Basis (Anker)
UNION ALL
select sp from tab inner join cte on cte.id = tab1.reportsto --bezieht sich auf Basis
)
select * from cte

--zuerst mal die Rekursion...
;with cteAng 
as
(
select employeeid, reportsto from Employees where ReportsTo is null --von hier aus begonnen wir die Rekursion
UNION ALL
select e.EmployeeID, e.reportsto from Employees e inner join cteAng ON cteang.employeeid=e.ReportsTo--hier werden alle gefunden, die der Basis entsprechen
)
select * from cteAng

--jetzt mit Ebene

;with cteAng (AngId, VorId, Ebene)
as
(
select employeeid, reportsto,1 as Ebene from Employees where ReportsTo is null --von hier aus begonnen wir die Rekursion
UNION ALL
select e.EmployeeID, e.reportsto, Ebene +1 from Employees e inner join cteAng ON cteang.AngId=e.ReportsTo--hier werden alle gefunden, die der Basis entsprechen
)
select * from cteAng where Ebene = 3


)


)







