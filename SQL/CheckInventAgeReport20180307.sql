select A.itemid ,count(1) ,min(recid) from SUP_InventAgeLine A  where A.journalId ='Age000001' and A.dataareaid='001' 
group by  A.itemid

go

select * from SUP_INVENTAGELINE A where A.journalId ='Age000001' and A.dataareaid='001' 
and A.itemid='9AW20014'

go

delete from SUP_INVENTAGELINE where DATAAREAID='001'
and  journalId='Age000001'
and   RECID in (select min(recid) from SUP_INVENTAGELINE A 
where  A.journalId ='Age000001' and A.dataareaid='001'
group by A.ITEMID) 