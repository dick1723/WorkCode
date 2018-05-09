select 
Line.DATAAREAID,
CONVERT(VARCHAR (100), Line.[CREATEDDATE], 23) as CREATEDDATE,
Line.SUP_YearMonth,
Line.PURCHID,
B.PURCHNAME,
Line.ItemBuyerGroupId,
Line.SUP_INTERCOMPANYPURCHITEMID,
dbo.[F_GetCustVendStyple](Line.DataAreaId,line.itemid,Line.INVENTCOLORID,line.configId,Line.vendaccount,3) as ExternalCode,
Line.ITEMID,
SS.FGCode,
D.ItemName,
D.NAMEALIAS,
ss.SiteName,
line.INVENTCOLORID,
E.NAME   as ColorNameCN,
E.TEC_ENGLISHNAME as ColorNameEN,
Line.SUP_REFERENCE,
Line.PURCHUNIT,
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
MIN(A.CREATEDDATETIME) as CREATEDDATE,
A.ItemId,
A.TEC_LEAVEFACTORYDATE,
B.InventColorId,
B.InventSizeId,
B.configId,
MIN(A.VENDACCOUNT)     as VendAccount,
MAX(A.[SUP_YearMonth]) as SUP_YearMonth,
max([ItemBuyerGroupId]) as ItemBuyerGroupId,
max([SUP_INTERCOMPANYPURCHITEMID]) as SUP_INTERCOMPANYPURCHITEMID,
max(A.SUP_REFERENCE)  as SUP_REFERENCE,
max(A.PURCHUNIT) as PURCHUNIT,
MAX(A.DELIVERYDATE) as DELIVERYDATE,
MAX(A.SUP_RequireDelivery) as SUP_RequireDelivery,
MAX(A.TEC_FIRSTCONFIRMATIONDATE) as TEC_FIRSTCONFIRMATIONDATE,
MAX(A.CONFIRMEDDLV) as CONFIRMEDDLV,
MAX(A.MODIFIEDDATETIME) as MODIFIEDDATETIME,
MAX(salesid)       as SalesId,
MAX(A.custAccount) as  CUSTACCOUNT,
MAX(A.ETDDATE) as ETDDate,
MAX(A.TEC_ARRIVALDATE) as TEC_ARRIVALDATE, 
SUM(A.purchqty) as PurchQty,
SUM(A.QM_INSPQTYPURCH-A.THK_SHORTAGEQTY) as ReceiveNowIQC,
SUM(REMAINPURCHPHYSICAL) as REMAINPURCHPHYSICAL,
SUM(A.REMAINPURCHFINANCIAL) as RemainInvoice,
SUM(A.THK_SHORTAGEQTY) as OweQty

--SUM(RemianPurchQytQM) as RemianPurchQytQM
from PURCHLINE A

join INVENTDIM  B on B.DATAAREAID=A.DATAAREAID and B.INVENTDIMID=A.INVENTDIMID



where exists( select 1 from PURCHLINE find where find.DATAAREAID=A.DATAAREAID and find.PURCHID=A.PURCHID and find.REMAININVENTPHYSICAL!=0)
and A.DATAAREAID='001'
--A.DATAAREAID='001'
and A.PURCHID='A1-201801/00015'
--and A.CREATEDDATETIME>='2017-6-30'
 
group by A.DATAAREAID, A.PurchId, A.ItemId,
A.TEC_LEAVEFACTORYDATE,
B.InventColorId,B.InventSizeId,B.configId)  as Line

join INVENTTABLE D on d.DATAAREAID=line.DATAAREAID and d.ITEMID=line.ITEMID
join PURCHTABLE  B on B.DATAAREAID=line.DATAAREAID and B.PURCHID=line.PURCHID
join INVENTCOLOR E on  E.DATAAREAID=line.DATAAREAID and E.INVENTCOLORID=line.INVENTCOLORID and E.ITEMID=line.ITEMID

cross apply  (select 
max([ItemBuyerGroupId]) as ItemBuyerGroupId,
max([SUP_INTERCOMPANYPURCHITEMID]) as SUP_INTERCOMPANYPURCHITEMID,
max([ExternalCode]) as ExternalCode,
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

