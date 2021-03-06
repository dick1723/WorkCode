--SELECT  * FROM InventSum inner join INVENTDIM WHERE InventSum.InventDimId = InventDim.inventDimId 
--GROUP BY InventSum.ItemId, InventDim.configId, InventDim.InventSizeId, InventDim.InventColorId, InventDim.InventSiteId, InventDim.InventLocationId, InventDim.inventBatchId 
--ORDER BY InventSum.ItemId ASC, InventDim.InventLocationId ASC 
--AND ((InventSiteId = N'001')) 
--EXISTS JOIN FIRSTFAST * FROM InventTable WHERE InventSum.ItemId = InventTable.ItemId AND ((ItemGroupId = N'FG成品') 
--OR (ItemGroupId = N'FG成品')) AND ((AutoReportFinished = 0))
 declare @EndDate date
 declare @siteId  nvarchar(20)
 declare @companyId nvarchar(4)
 declare @itemid	 nvarchar(20)
 set @EndDate='2018-3-28'
 set @companyId='001'
 set @siteId='001'
 set @itemid='9AW40167E' 
select @EndDate as EndDate, inv.ITEMGROUPID,inv.ITEMID,inv.ENGLISHNAME,
inv.NAM_DESCRIPTION,inv.ITEMNAME,InventCount.CONFIGID,config.NAME as ConfigName,
config.SUP_CustomerColor as  CustomerColor,

InventCount.INVENTSITEID,InventCount.INVENTLOCATIONID,
InventCount.INVENTBATCHID,InventTableModule.UNITID,InventCount.qty
from INVENTTABLE inv inner join
(select trans.ItemId, InventDim.configId, InventDim.InventSizeId, InventDim.InventColorId, InventDim.InventSiteId, InventDim.InventLocationId, 
InventDim.inventBatchId ,sum(trans.QTY) as qty,trans.DATAAREAID
from [VM_InventTransQty] trans 
inner join INVENTDIM on trans.INVENTDIMID=INVENTDIM.INVENTDIMID and trans.DATAAREAID=INVENTDIM.DATAAREAID
inner join INVENTTABLE on INVENTTABLE.ITEMID=trans.ITEMID and INVENTTABLE.DATAAREAID=trans.DATAAREAID
where trans.DATEPHYSICAL <@EndDate 
--and INVENTTRANS.DATEPHYSICAL !='1900-01-01 00:00:00.000'
and (trans.ITEMID=@itemid or @itemid='')
and INVENTDIM.INVENTSITEID=@siteId and INVENTTABLE.AutoReportFinished = 0
group by trans.ItemId, InventDim.configId, InventDim.InventSizeId, InventDim.InventColorId, InventDim.InventSiteId,
 InventDim.InventLocationId, InventDim.inventBatchId,trans.DATAAREAID
 having isnull(SUM(trans.Qty),0)!=0) as InventCount on inv.ITEMID=InventCount.ITEMID 
 and InventCount.DATAAREAID=inv.DATAAREAID

 inner join ConfigTable config on  config.DATAAREAID=InventCount.DATAAREAID and  config.CONFIGID=InventCount.CONFIGID  and config.ITEMID=InventCount.ITEMID
  inner join InventTableModule on InventTableModule.ITEMID=inv.ITEMID and InventTableModule.MODULETYPE=0
  and InventTableModule.DATAAREAID=inv.DATAAREAID
 where inv.ITEMGROUPID=N'FG成品' and inv.DATAAREAID=@companyId


