create table #t
(
name nvarchar(128),
rows varchar(50),
reserved varchar(50),
data varchar(50),
index_size varchar(50),
unused varchar(50)
)

declare @id nvarchar(128)
declare c cursor for
select name from sysobjects where xtype='U'

open c
fetch c into @id

while @@fetch_status = 0 begin
insert into #t
exec sp_spaceused @id
fetch c into @id
end

close c
deallocate c

select * from #t
order by convert(int, substring(data, 1, len(data)-3)) desc

drop table #t