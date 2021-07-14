--Variablen sind nur während eines Batches gültig..
--ein GO unterbricht einen bestehenden Batch


declare @var1 as int = 0

select @var1
GO
select @var1 --error


alter proc gpdemo5 
as
select GETDATE();
GO



exec gpdemo5