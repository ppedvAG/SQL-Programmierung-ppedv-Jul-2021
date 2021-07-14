
create table numbers (id int identity, sp1 int)

insert into numbers
select 100
GO 30000


create table T11(
		id int identity not null primary key,
		x decimal(8,2) not null default 0,
		spalten char(100) not null default '#'
		)
go
--select * from t1
--select abs(checksum(NEWID()))*0.01%20000
insert T11(x)
	select 	0.01 *ABS(checksum(newid()) %20000) from Numbers
		where id<= 20000

select abs(checksum(NEWID()))


select * from t11

--Ausgabe: 
1   23,45
2   196,95






--Cursor, JOIN, SubQuery, ...


select T11.id,SUM(t2.x) as rt 
	from t11
	inner join T11 as t2 on t2.id<= T11.id
	group by T11.id --?? 25 Sekunden
	order by id --25 Sekunden


--Subquery sind nicht schnell...
select T11.id, (select SUM(t2.x) from T11 as t2 where t2.id <= T11.id) as rt
from t11 order by id --uiii... dauert


--Cursor
create table #t(id int not null primary key, s decimal(16,2) not null)

declare @id int, @x decimal(8,2), @s decimal (16,2)
set @s=0 --sonst NULL

declare #c cursor fast_forward for
		select id, x from T11 order by id

open #c
	while (1=1) --Begin  end break: bricht sofort die Schleife ab  continue springt zum schleifeneinstieg
		begin 
			fetch next from #c into @id, @x
			if (@@FETCH_STATUS !=0) break
			set @s=@s+@x

			if @@TRANCOUNT=0
				begin tran
				insert into #t values (@id, @s)

			if (@id %1000)=0
				commit
		end

if @@trancount >0
	commit
	close #c
	deallocate #c

select * from #t


--letzte Variante: Window Function

select id, SUM(x) over (order by id rows unbounded preceding) summe from t11










		

