USE [SL2018]
GO

/****** Object:  View [dbo].[VM_PurchaseOrderStatistic]    Script Date: 03/30/2018 08:42:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









ALTER VIEW [dbo].[VM_PurchaseOrderStatistic]
AS

--Comment by mikez on 20180329 for XiaoHong's Request
--SELECT 
--[DATAAREAID],
--min(CASE WHEN [CREATEDDATE]= '1900-01-01 00:00:00.000' THEN ''
--ELSE CONVERT (VARCHAR (100), [CREATEDDATE], 23) END) as CREATEDDATE,
--max([TEC_ORDERMONTH]) as TEC_ORDERMONTH,
--[PURCHID],
--max([PURCHNAME]) as PURCHNAME,
--max([ItemBuyerGroupId]) as ItemBuyerGroupId,
--max([SUP_INTERCOMPANYPURCHITEMID]) as SUP_INTERCOMPANYPURCHITEMID,
--max([ExternalCode]) as ExternalCode,
--Itemid,
--max([FGCode]) as FGCode,
--max([itemName]) as ItemName,
--max([NAMEALIAS]) as NAMEALIAS,
--max([SiteName]) as SiteName,
--[INVENTCOLORID],
--MAX(colorNameCN) as ColorNameCN,
--MAX(ColorNameEN) as ColorNameEN,
--max([SUP_REFERENCE]) as SUP_REFERENCE,
--max([PURCHUNIT]) as PURCHUNIT,
--sum([PURCHQTY]) as PURCHQTY,
--sum([ReceiveTotal]) as ReceiveTotal,
--sum([InvoiceTotal]) as InvoiceTotal,
--sum([ReceiveNowIQC]) as ReceiveNowIQC,
--sum([ReturnNow]) as ReturnNow,
--sum([REMAINPURCHPHYSICAL]-[RemianPurchQytQM]) as NotArrivalQTY,
--sum([REMAINPURCHPHYSICAL]) as REMAINPURCHPHYSICAL,
--sum([RemianPurchQytQM]) as RemianPurchQytQM,
--sum([OweQty]) as OweQty,
--Sum(PurchQty-[ReceiveTotal]) as POWarehouseDifferences, 
--max(DeliveryDate) as DeliveryDate,
--max(SUP_RequireDelivery) as SUP_RequireDelivery,
--max(salesid) as Salesid,
--max(custAccount) as custAccount ,
--max(remarks) as Remarks ,
--max(purchplacer) as purchPlacer,
--max(TEC_FIRSTCONFIRMATIONDATE) as firstConfirmDate,
--CONFIRMEDDLV   ,
--max(ModifiedDate) as ModifedDate,
--sum(PendingQtyPurch) as PendingQtyPurch,  
--sum([RemainInvoice]) as [RemainInvoice],
--max([Tec_LeaveFactoryDate]) as  [Tec_LeaveFactoryDate],
--max([ETDDATE]) as  [ETDDATE],
--max([TEC_ARRIVALDATE]) as [TEC_ARRIVALDATE],
--max(SUP_DelayReason) as SUP_DelayReason,
--case max(SUP_QUOTEDPRICE) when 0 then 'Y' else 'N' end as SUP_QUOTEDPRICE
--from [dbo].[VM_PurchlineInfo] 
----where [REMAINPURCHPHYSICAL]!=0 
--group by  [DATAAREAID], PurchId, ItemId, InventColorId,InventSizeId,configId,CONFIRMEDDLV
-- add by mike zheng on 20180329 to group by  group by  [DATAAREAID], PurchId, ItemId, InventColorId,InventSizeId,configId,[Tec_LeaveFactoryDate] 
--which from XiaoHong'sRequest
--SELECT 
--[DATAAREAID],
--min(CASE WHEN [CREATEDDATE]= '1900-01-01 00:00:00.000' THEN ''
--ELSE CONVERT (VARCHAR (100), [CREATEDDATE], 23) END) as CREATEDDATE,
--max([SUP_YearMonth]) as TEC_ORDERMONTH,
--[PURCHID],
--max([PURCHNAME]) as PURCHNAME,
--max([ItemBuyerGroupId]) as ItemBuyerGroupId,
--max([SUP_INTERCOMPANYPURCHITEMID]) as SUP_INTERCOMPANYPURCHITEMID,
--max([ExternalCode]) as ExternalCode,
--Itemid,
--max([FGCode]) as FGCode,
--max([itemName]) as ItemName,
--max([NAMEALIAS]) as NAMEALIAS,
--max([SiteName]) as SiteName,
--[INVENTCOLORID],
--MAX(colorNameCN) as ColorNameCN,
--MAX(ColorNameEN) as ColorNameEN,
--max([SUP_REFERENCE]) as SUP_REFERENCE,
--max([PURCHUNIT]) as PURCHUNIT,
--sum([PURCHQTY]) as PURCHQTY,
----sum([ReceiveTotal]) as ReceiveTotal,
--sum([ReceiveTotal]+[InvoiceTotal]) as ReceiveTotal,
--sum([InvoiceTotal]) as InvoiceTotal,
--sum([ReceiveNowIQC]) as ReceiveNowIQC,
--sum([ReturnNow]) as ReturnNow,
--sum([REMAINPURCHPHYSICAL]-[RemianPurchQytQM]) as NotArrivalQTY,
--sum([REMAINPURCHPHYSICAL]) as REMAINPURCHPHYSICAL,
--sum([RemianPurchQytQM]) as RemianPurchQytQM,
--sum([OweQty]) as OweQty,
--Sum(PurchQty-[ReceiveTotal]) as POWarehouseDifferences, 
--max(DeliveryDate) as DeliveryDate,
--max(SUP_RequireDelivery) as SUP_RequireDelivery,
--max(salesid) as Salesid,
--max(custAccount) as custAccount ,
--max(remarks) as Remarks ,
--max(purchplacer) as purchPlacer,
--max(TEC_FIRSTCONFIRMATIONDATE) as firstConfirmDate,
--min(CONFIRMEDDLV) as  CONFIRMEDDLV  ,
--max(ModifiedDate) as ModifedDate,
--sum(PendingQtyPurch) as PendingQtyPurch,  
--sum([RemainInvoice]) as [RemainInvoice],
--[Tec_LeaveFactoryDate],
--max([ETDDATE]) as  [ETDDATE],
--max([TEC_ARRIVALDATE]) as [TEC_ARRIVALDATE],
--max(SUP_DelayReason) as SUP_DelayReason,
--case max(SUP_QUOTEDPRICE) when 0 then 'Y' else 'N' end as SUP_QUOTEDPRICE
--from [dbo].[VM_PurchlineInfo] A

----where exists ( select 1 from PURCHLINE B where B.PURCHID=A.PURCHID and B.DATAAREAID=A.DATAAREAID and B.REMAININVENTPHYSICAL!=0)
----where [REMAINPURCHPHYSICAL]!=0 


--group by  [DATAAREAID], PurchId, ItemId, InventColorId,InventSizeId,configId,[Tec_LeaveFactoryDate]


select 
Line.DATAAREAID,
CONVERT(VARCHAR (100), Line.[CREATEDDATE], 23) as CREATEDDATE,
SS.TEC_ORDERMONTH,
Line.PURCHID,
ss.PURCHNAME,
SS.ItemBuyerGroupId,
SS.SUP_INTERCOMPANYPURCHITEMID,
dbo.[F_GetCustVendStyple](Line.DataAreaId,line.itemid,Line.INVENTCOLORID,line.configId,Line.vendaccount,3) as ExternalCode,
Line.ITEMID,
SS.FGCode,
SS.ItemName,
SS.NAMEALIAS,
ss.SiteName,
line.INVENTCOLORID,
SS.ColorNameCN,
ss.ColorNameEN,
ss.SUP_REFERENCE,
ss.PURCHUNIT,
Line.PurchQty,
ss.ReceiveTotal,
ss.InvoiceTotal,
ss.ReceiveNowIQC,
ss.ReturnNow,
ss.NotArrivalQTY,
line.REMAINPURCHPHYSICAL,
ss.RemianPurchQytQM,
ss.OweQty,
Line.PurchQty-ss.ReceiveTotal as POWarehouseDifferences, 
ss.DeliveryDate,
ss.SUP_RequireDelivery,
ss.Salesid,
ss.custAccount,
ss.Remarks,
ss.purchPlacer,
ss.firstConfirmDate,
ss.CONFIRMEDDLV,
ss.ModifedDate,
ss.PendingQtyPurch,
ss.RemainInvoice,
line.TEC_LEAVEFACTORYDATE,
ss.ETDDATE,
ss.TEC_ARRIVALDATE,
ss.SUP_DelayReason,
SS.SUP_QUOTEDPRICE

from 
(select 
A.DATAAREAID, 
A.PurchId, 
A.ItemId,
A.TEC_LEAVEFACTORYDATE,
B.InventColorId,
B.InventSizeId,
B.configId,
MIN(A.VENDACCOUNT)     as VendAccount,
MIN(A.CREATEDDATETIME) as CREATEDDATE,
SUM(A.purchqty) as PurchQty,
SUM(REMAINPURCHPHYSICAL) as REMAINPURCHPHYSICAL
--SUM(RemianPurchQytQM) as RemianPurchQytQM
from PURCHLINE A

join INVENTDIM  B on B.DATAAREAID=A.DATAAREAID and B.INVENTDIMID=A.INVENTDIMID



where exists( select 1 from PURCHLINE find where find.DATAAREAID=A.DATAAREAID and find.PURCHID=A.PURCHID and find.REMAININVENTPHYSICAL!=0)
--and A.DATAAREAID='001'
--and A.PURCHID='A1-201801/00015'
--and A.CREATEDDATETIME>='2017-12-31'
 
group by A.DATAAREAID, A.PurchId, A.ItemId,
A.TEC_LEAVEFACTORYDATE,
B.InventColorId,B.InventSizeId,B.configId)  as Line
 
cross apply  (select min(CREATEDDATE) as CREATEDDATE,
max([SUP_YearMonth]) as TEC_ORDERMONTH,
max([PURCHNAME]) as PURCHNAME,
max([ItemBuyerGroupId]) as ItemBuyerGroupId,
max([SUP_INTERCOMPANYPURCHITEMID]) as SUP_INTERCOMPANYPURCHITEMID,
--max([ExternalCode]) as ExternalCode,
max([FGCode]) as FGCode,
max([itemName]) as ItemName,
max([NAMEALIAS]) as NAMEALIAS,
max([SiteName]) as SiteName,
MAX(colorNameCN) as ColorNameCN,
MAX(ColorNameEN) as ColorNameEN,
max([SUP_REFERENCE]) as SUP_REFERENCE,
max([PURCHUNIT]) as PURCHUNIT,
sum([PURCHQTY]) as PURCHQTY,
--sum([ReceiveTotal]) as ReceiveTotal,
sum([ReceiveTotal]+[InvoiceTotal]) as ReceiveTotal,
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
max([ETDDATE]) as  [ETDDATE],
max([TEC_ARRIVALDATE]) as [TEC_ARRIVALDATE],
max(SUP_DelayReason) as SUP_DelayReason,
case max(SUP_QUOTEDPRICE) when 0 then 'Y' else 'N' end as SUP_QUOTEDPRICE 
from VM_PurchlineInfo AA where AA.DATAAREAID=Line.DATAAREAID 
and AA.PURCHID=Line.PURCHID and AA.ITEMID=Line.ITEMID and AA.INVENTCOLORID=Line.INVENTCOLORID
and AA.INVENTSIZEID=Line.INVENTSIZEID and AA.CONFIGID=Line.CONFIGID and AA.TEC_LEAVEFACTORYDATE=Line.TEC_LEAVEFACTORYDATE) as SS






GO


