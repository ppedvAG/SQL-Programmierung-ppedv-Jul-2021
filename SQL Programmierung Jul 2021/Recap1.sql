/*

CPUs...
Kostenschwellwert: default  5
MAXDOP max degree of parel...1 CPU oder alle die in MAXDOP definiert wurden default bis SQL 21014 alle

--> mehr CPUs kosten mehr Aufwand

Admin:
	auf dem Server (MAXDOP , KOstenschwellwert)
	auf den DB (MAXDOP)
DEV
	bei Abfrage
	option (maxdop 2)
	erkennbar im  tats. Plan --> Eigenschaften.... 

	Es z�hlt immer die Einstellung die am n�chsten ander Abfrage dran ist

	Guter STartwert f�r Kostenschwellwert = 25
	Taskmanager CPU Last sehr  hoch.. bei SQL Prozess.. Indiz f�r Beobachtung der CPU ANzahl



HDD
weniger IO!!!
gemessen durch Seiten  (8kb) 8 Seiten am St�ck nennt man Block

set statistics io on --Anzahl der Seiten

Kompression...: Seiten bleiben 8 kb gro�
				Zeilen und Seitenkompression: 
				Seitenkompression wendet zuerst Zeilenkompression an und dann einen Kompressionsalgorithm oben drauf
				ca 40-60%
				weniger Seiten auch weniger im RAM...weniger CPUs
				mehr CPU bei Ausgabe der DAten an Client weil Dekompression

				Lohnt sich vor allem dann, wenn wir sehr gut komprimieren

Partitionierung

part Sicht: logisch aber unhandlich: 
					gro�e Tabelle in viele kleiner aufteilen
					Sicht, die alle Tabellen wiedergibt (UNION ALL)
					pro Tabelle: CHeck Einschr�nkung, die eine Garantie abgibt
					PK der eindeutig �ber die Sicht
					kein Identity bei INS UP


Partitionierung (ab SQL 2016 SP1 auch in Express und h�her, sonst Enterprise)
	PartSchema: Ergebnis der Funktion kann einer Dgruppe zugewiesen werden
	PartF()... ----------------100-----------------------200-------------  max 15000
	Dateigruppen: Datreien, in denen die Daten sind...




PLAN:
	von rechts Quellen.. SCAN oder SEEK
	SEEK: herauspicken
	SCAN: A bis Z durchsuchen

	bei where sollte immer ein SEEK























*/