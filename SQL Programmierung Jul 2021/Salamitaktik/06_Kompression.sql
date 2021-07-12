--weniger IO

--Seitenkompression Zeilenkompression
--nur Tabellen sind komprimierbar

--Zeilenkompression: Zb Char(50) Leerstellen entfernen
					-- Datentypkonvertierbar

--Seitenkompression verwendet zuerst Zeilenkompression, 
	-- + Algorithmus für Kompression


--Wichtig: Kompression muss transparent.. Client darf nichts davon merken..

--zu erwarten: 40 bis 60%

--Neustart
--Taskmanager: RAMVerbrauch des SQL Server: 480
set statistics io, time on
select * from Northwind..t1

--Taskmanager: RAM Verbrauch 640 MB  + 160MB!
--Seiten: 20000  CPU  670  Dauer 4700ms

--Tabelle  Komprimieren
--Neustart
--Taskmanager: RAM Verbrauch des SQL Server: evtl weniger oder mehr... 465MB
set statistics io, time on
select * from Northwind..t1
 
--Taskmanager: RAM Verbrauch gleich oder mehr.. 466MB
--Seiten: weniger oder gleich ..33 CPU  weniger  Dauer kürzer

--typisch ist: weniger Seiten--> Weniger Ram verbauch
--             evtl mehr CPU Leistung
--             Dauer evtl gleich

--Idee der Kompression.. mehr RAM für andere bezahlt mit CPU

--Kompression kann mit Partionen kombiniert werden....














