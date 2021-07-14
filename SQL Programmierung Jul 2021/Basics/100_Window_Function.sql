--DENSE RANK  NTILE   RANK

select orderid, employeeid, customerid, freight, ROW_NUMBER() over (partition by employeeid order by freight desc) Rang
from orders
--where rang = 1


--RANK-- UNterschied zu Row_number.. Rang wird überspringen

select orderid, employeeid, customerid, freight, RANK() over (partition by employeeid order by freight desc) Rang
from orders


--dense_rank.. vergibt Ränge aber überspringt keinen Rang


--NTILE(4( 4 gleiche teile


select customerid, freight from orders

--IDEE A B C 

--A  wenn die Frachtkosten unter 100 sind
--B 100 und 500
--C Kunde über 500 Euro

--NTILE

select NTILE (4) over (order by freight), freight from orders

--ABC Analyse: 
--Stück für Stück  3 Abfragen mit UNION 

select orderid, freight, 'A' from orders where freight <100
UNION ALL
select orderid, freight, 'A' from orders where freight between 100 and 500
UNION ALL
select orderid, freight, 'C' from orders where freight > 500



--oder   CASE..besser 

select orderid, freight, 
		case
			when freight < 100 then 'A' --auch mit like between 
			when freight > 500 then 'C'
			else 'B'
		end Typ
from orders


--bei der Ausgabe der order details eine Spalte mit dem Rechnugswert
10248     440
10248     440
10248     440


--pro Bestellposítion die RSumme mitliefern--kein Group by
--Idee: gib den % Anteil zurück
select orderid, SUM(unitprice*quantity) over (partition by orderid), productid,
				convert(varchar(50),((UnitPrice*Quantity)/SUM(unitprice*quantity) over (partition by orderid))*100) +'%' as PROZ,
				RANK()
from [Order Details]
order by 1,4 desc



select orderid, SUM(unitprice*quantity) over (partition by orderid), productid,
				convert(varchar(50),((UnitPrice*Quantity)/SUM(unitprice*quantity) over (partition by orderid))*100) +'%' as PROZ,
				RANK() over (UnitPrice*Quantity)/SUM(unitprice*quantity) over (partition by orderid))*100))
from [Order Details]
order by 1,4 desc



;with cte (orderid, summe, proz)
as
(select top 100 percent orderid, SUM(unitprice*quantity) over (partition by orderid) SUMME, 
				convert(varchar(50),((UnitPrice*Quantity)/SUM(unitprice*quantity) over (partition by orderid))*100) +'%' as PROZ
from [Order Details]
order by 1,3 desc)
select * , rank() over  (partition by orderid order by proz) from cte 

--wie Unterbfargen 
--Rekursionenn auflösen


select * from employees












