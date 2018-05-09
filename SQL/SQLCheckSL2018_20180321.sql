select * from TEC_INVENTCOUNT A

where not exists (select 1 from TEC_BATCHJOURNAL B where b.DATAAREAID=A.DATAAREAID and B.JOURNALID=A.JOURNALID)


go

select COUNT(1) from TEC_MATERIALTRACEDETAIL A 

where not exists (select 1 from SUP_MaterialDistributJournal B where b.DATAAREAID=A.DATAAREAID and B.JOURNALID=A.JOURNALID)


--delete from InventSumDateTrans where DATAAREAID='501'
select DATAAREAID,PARMID, count(1) from InventSumDateTrans group by DATAAREAID ,PARMID

sp_spaceused InventSumDateTrans

go

sp_help INVENTSUMLOGTTS

go

select COUNT (1) from InventSumDateTrans  