SELECT 
[DATAAREAID],
min(CASE WHEN [CREATEDDATE]= '1900-01-01 00:00:00.000' THEN ''
ELSE CONVERT (VARCHAR (100), [CREATEDDATE], 23) END) as CREATEDDATE,
max([SUP_YearMonth]) as TEC_ORDERMONTH,
[PURCHID],
max([PURCHNAME]) as PURCHNAME,
max([ItemBuyerGroupId]) as ItemBuyerGroupId,
max([SUP_INTERCOMPANYPURCHITEMID]) as SUP_INTERCOMPANYPURCHITEMID,
max([ExternalCode]) as ExternalCode,
Itemid,
max([FGCode]) as FGCode,
max([itemName]) as ItemName,
max([NAMEALIAS]) as NAMEALIAS,
max([SiteName]) as SiteName,
[INVENTCOLORID],
MAX(colorNameCN) as ColorNameCN,
MAX(ColorNameEN) as ColorNameEN,
max([SUP_REFERENCE]) as SUP_REFERENCE,
max([PURCHUNIT]) as PURCHUNIT,
sum([PURCHQTY]) as PURCHQTY,
sum([ReceiveTotal]) as ReceiveTotal,
sum([InvoiceTotal]) as InvoiceTotal,
sum([ReceiveNowIQC]) as ReceiveNowIQC,
sum([ReturnNow]) as ReturnNow,
sum([REMAINPURCHPHYSICAL]-[RemianPurchQytQM]) as NotArrivalQTY,
sum([REMAINPURCHPHYSICAL]) as REMAINPURCHPHYSICAL,
sum([RemianPurchQytQM]) as RemianPurchQytQM,
sum([OweQty]) as OweQty,
Sum(PurchQty-[ReceiveTotal]) as POWarehouseDifferences, 
max(DeliveryDate) as DeliveryDate,
max(SUP_RequireDelivery) as SUP_RequireDelivery,
max(salesid) as Salesid,
max(custAccount) as custAccount ,
max(remarks) as Remarks ,
max(purchplacer) as purchPlacer,
max(TEC_FIRSTCONFIRMATIONDATE) as firstConfirmDate,
min(CONFIRMEDDLV) as  CONFIRMEDDLV  ,
max(ModifiedDate) as ModifedDate,
sum(PendingQtyPurch) as PendingQtyPurch,  
sum([RemainInvoice]) as [RemainInvoice],
[Tec_LeaveFactoryDate],
max([ETDDATE]) as  [ETDDATE],
max([TEC_ARRIVALDATE]) as [TEC_ARRIVALDATE],
max(SUP_DelayReason) as SUP_DelayReason,
case max(SUP_QUOTEDPRICE) when 0 then 'Y' else 'N' end as SUP_QUOTEDPRICE
from [dbo].[VM_PurchlineInfo] A

where exists ( select 1 from PURCHLINE B where B.PURCHID=A.PURCHID and B.DATAAREAID=A.DATAAREAID and B.REMAININVENTPHYSICAL!=0)
--where [REMAINPURCHPHYSICAL]!=0 

and A.DATAAREAID='001' and A.PURCHID='A1-201801/00015'
group by  [DATAAREAID], PurchId, ItemId, InventColorId,InventSizeId,configId,[Tec_LeaveFactoryDate]