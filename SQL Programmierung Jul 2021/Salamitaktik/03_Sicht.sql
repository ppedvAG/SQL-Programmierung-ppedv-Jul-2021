--Sicht

--gemerkte Abfrage, die wie eine Tabelle bahandelt

create view vdemo
as
..Abfrage


create table slf (id int, stadt int, land int)

insert into slf
select 1, 10 , 100
UNION
select 2, 20, 200


select * from slf


create view vslf
as
select * from slf;
GO

select * from vslf

--Performance: eine Sicht ist genau  schnell wie das adhpc SQL Statement

--neue Spalte Fluss mit 1000er Werte
alter table slf add fluss int

update slf set fluss = id *1000


select * from slf

select * from vslf --ohne Fluss obwohl mit * Abfrage
--Idee .. er hat die Spalten eingebaut


--Spalte löschen
alter table slf drop column land

select * from vslf --uff  das Land mit Werten  von Fluss


--wie bringt man Sichten dazu dass sie mmer korrekt sind

-- with schemabding
--kein * mehr erlaubt


drop table slf


create table slf (id int, stadt int, land int)

insert into slf
select 1, 10 , 100
UNION
select 2, 20, 200


select * from slf

drop view vslf

create view vslf with schemabinding
as
select id, stadt, land from dbo.slf; --mit Schema.. kein *
GO

select * from vslf

--Performance: eine Sicht ist genau  schnell wie das adhpc SQL Statement

--neue Spalte Fluss mit 1000er Werte
alter table slf add fluss int

update slf set fluss = id *1000


select * from slf

select * from vslf ----passt


--Spalte löschen
alter table slf drop column land --<error.. weil Sicht verwendet Spalte

select * from vslf 
--exakter Aufruf mit Schemaangabe
