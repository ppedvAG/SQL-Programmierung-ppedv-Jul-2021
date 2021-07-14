--Indizes vs Heap

/*
CL IX gruppiert
CL IX = sortierte Tabelle  ... CL IX SCAN
1 mal pro Tabelle
besond gut bei where mit Bereichsabfragen > < between like A%
!!! PK wird immer als GR IX angelegt


NON CL IX nicht gr IX
besonders gut geeignet f¸r where mit Abfragen mit rel geringer Ergebnismenge
ideal: ID PK

0 Heap
1 CL IX
2-  NCL IX


ABC
1000.. ist das gut? I U D
nur notwendige IX, kein ¸berfˆ¸ssigen und fehlende finden

SCAN SEEK

TABLE SCAN  CL IX SEEK!
Table Scan vs CL IX SCAN.. egal
IX SEEK  vs IX SCAN

IX SEEK -> HEAP !
IX SEEK -> CL IX (Zieger auf Wurzelknoten)


--Warum sollten f() vermieden werde?
--vor allem bei where  f(spalte) = Wert
--wird immer scan 

ColumnStore..super bei lesenden Daten (sehr groﬂe Menge)

Columnstore IX



DMV
*/

select * from sys.dm_db_index_usage_stats

