--Idee: statt einer sehr großen Tabelle viele kleinere


--Statt Umsatztabelle viele kleine pro Jahr u2020 u2021  usw


create table u2021(id int identity, jahr int, spx int)
create table u2020(id int identity, jahr int, spx int)
create table u2019(id int identity, jahr int, spx int)
create table u2018(id int identity, jahr int, spx int)

--Idee : Tabelle Umsatz muss amEnde wieder da sein
--Idee Tabelle = Sicht


create view Umsatz
as
select * from u2021
UNION ALL --keibe Suche nach doppelten
select * from u2020
UNION ALL
select * from u2019
UNION ALL 
select * from u2018;
GO


select * from Umsatz where jahr = 2020--alle 4 Tab im Plan

--besser, wen im Plan nur eine Tabelle :-)
ALTER TABLE dbo.u2018 ADD CONSTRAINT
	CK_u2018 CHECK (jahr=2018)

ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)

ALTER TABLE dbo.u2020 ADD CONSTRAINT
	CK_u2020 CHECK (jahr=2020)

ALTER TABLE dbo.u2021 ADD CONSTRAINT
	CK_u2021 CHECK (jahr=2021)

--nur noch in Tab 2020
select * from Umsatz where jahr = 2020


select * from Umsatz where id  = 10


--Probleme...
--kein PK .. Error
--keine Idenity mehr machbar...

--daher PK auf ID und Jahr für jede Tabelle
--und Identity muss raus..
--daher auch ID wieder mitgeben (ID ist NOT NULL)
insert into Umsatz (id,jahr, spx)
values (1,2020,100)



