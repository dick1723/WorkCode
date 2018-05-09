declare @companyId  nvarchar(4)
declare @journalId  nvarchar(20)

set @companyId='321'
set @journalId='009171_103'

update InventItemPurchSetup set Stopped=1 
where DATAAREAID=@companyId and InventDimId='AllBlank'  and   exists(select 1 from INVENTJOURNALTRANS B where   B.dataareaid=InventItemPurchSetup.dataareaid and 
B.ITEMID=InventItemPurchSetup.ITEMID and B.dataareaid=@companyId and B.journalId=@journalId)

update InventItemInventSetup set Stopped=1 
where DATAAREAID=@companyId and InventDimId='AllBlank'  and   exists(select 1 from INVENTJOURNALTRANS B where   B.dataareaid=InventItemInventSetup.dataareaid and 
B.ITEMID=InventItemInventSetup.ITEMID and B.dataareaid=@companyId and B.journalId=@journalId)


update InventItemSalesSetup set Stopped=1 
where DATAAREAID=@companyId and InventDimId='AllBlank'  and   exists(select 1 from INVENTJOURNALTRANS B where   B.dataareaid=InventItemSalesSetup.dataareaid and 
B.ITEMID=InventItemSalesSetup.ITEMID and B.dataareaid=@companyId and B.journalId=@journalId)




go
