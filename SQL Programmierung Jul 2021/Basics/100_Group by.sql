--AGG MIN MAX AVG SUM COUNT

select MAX(freight), MIN(freight) from ku1


--pro Abfrage
select country,MAX(freight), MIN(freight) from ku1
group by country --alles aus dem Slect , aber dann die AGG und Aliase löschen

--durschnittlichen Frachtkosten pro Land und Stadt

select country as Land, city as Stadt, AVG(freight) as SchnittFracht
from ku1
group by  
		country -- as Land
		, city --as Stadt
		--, AVG(freight) --as SchnittFracht
order by Country, city

--jetzt nur noch die , wo die Frachtkosten unter 100 liegen
select country as Land, city as Stadt, AVG(freight) as SchnittFracht
from ku1
where Freight < 100
group by  
		country -- as Land
		, city --as Stadt
		--, AVG(freight) --as SchnittFracht
		HAVING AVG(freight) < 50 --der Having sollte nur AGG haben
order by Country, city


--tu das nicht

select country as Land, city as Stadt, AVG(freight) as SchnittFracht
from ku1
--where Freight < 100
group by  
		country -- as Land
		, city --as Stadt
		--, AVG(freight) --as SchnittFracht
		HAVING City='London'
order by Country, city

--er würde alle 1,1 Mio DS suchen , dann auf alle AGG bilden, .. und dann ..oh nur für London

select country as Land, city as Stadt, AVG(freight) as SchnittFracht
from ku1
--where city = 'LONDON'
group by  
		country -- as Land
		, city --as Stadt
		--, AVG(freight) --as SchnittFracht
		--HAVING City='London'
order by Country, city

--er würde von 1,1 Mio ca 80000 (alle aus London) raussuchen und darauf  das AGG bilden

--und jetzt noch nur noch die DS wo der Schnitt unter 50 liegt

--Filter nie etwas mit Having, was ein where lösen kann...
--bzw having sollte nur AGG haben

--alle DS pro Land aus Tabelle KU1

select country,city, COUNT(*) from ku1
group by country, city
order by 1,2

--oft noch andere Berechnugen

select country,city, COUNT(*) 
into #t
from ku1
group by country, city with rollup
order by 1,2

select country,city, COUNT(*) from ku1
group by country, city with cube
order by 1,2