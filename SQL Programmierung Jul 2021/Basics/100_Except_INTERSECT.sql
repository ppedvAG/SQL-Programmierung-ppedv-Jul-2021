select customerid, companyname, country, city 
into KundenEU
from customers where Country in ('Italy', 'France', 'Germany', 'Austria')

select * from KundenEU

update KundenEU set City = 'Dresden' where CustomerID = 'ALFKI'

insert into KundenEU
select 'AAAAA', 'Fa A', 'UK', 'London'

--Ausgangsituation.. 2 ähnliche Tabellen mit gleichen aber auch versch DS..


--welche sind in beiden Tab identisch

--mit JOIN.. bei 20 Spalten :-(

select customerid, companyname, country, city from customers
INTERSECT
select customerid, companyname, country, city from KUndenEu --2 fehlen.. der aaaaa und der Alfki aus Dresden

--und die Unterschiedlichen

select customerid, companyname, country, city from customers--alle aus Customers , die so nicht in KundenEu sind
except
select customerid, companyname, country, city from KundenEU


select customerid, companyname, country, city from kundeneu--alle aus KundenEu , die so nicht in customers sind
except
select customerid, companyname, country, city from customers


select customerid, companyname, country from kundeneu--alle aus KundenEu , die so nicht in customers sind
except
select customerid, companyname, country from customers

select *-..
except..
select ..
intersect
select 
except
select



