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
Line.ReceiveNowIQC,
ss.ReturnNow,
ss.NotArrivalQTY,
line.REMAINPURCHPHYSICAL,
ss.RemianPurchQytQM,
line.OweQty,
Line.PurchQty-ss.ReceiveTotal as POWarehouseDifferences, 
line.DeliveryDate,
line.SUP_RequireDelivery,
line.Salesid,
line.custAccount,
B.Remarks,
B.purchPlacer,
Line.firstConfirmDate,
Line.CONFIRMEDDLV,
CONVERT(VARCHAR (100), Line.MODIFIEDDATETIME, 23) as CREATEDDATE,
ss.PendingQtyPurch,
Line.RemainInvoice,
line.TEC_LEAVEFACTORYDATE,
Line.ETDDATE,
Line.TEC_ARRIVALDATE,
Line.SUP_DelayReason,
Line.SUP_QUOTEDPRICE

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
MAX(A.TEC_FIRSTCONFIRMATIONDATE) as firstConfirmDate,
min(A.CONFIRMEDDLV) as CONFIRMEDDLV,
MAX(A.MODIFIEDDATETIME) as MODIFIEDDATETIME,
MAX(salesid)       as SalesId,
MAX(A.custAccount) as  CUSTACCOUNT,
MAX(A.ETDDATE) as ETDDate,
MAX(A.TEC_ARRIVALDATE) as TEC_ARRIVALDATE, 
MAX(A.SUP_DelayReason) as SUP_DelayReason,
SUM(A.purchqty) as PurchQty,
SUM(A.QM_INSPQTYPURCH-A.THK_SHORTAGEQTY) as ReceiveNowIQC,
SUM(REMAINPURCHPHYSICAL) as REMAINPURCHPHYSICAL,
SUM(A.REMAINPURCHFINANCIAL) as RemainInvoice,
SUM(A.THK_SHORTAGEQTY) as OweQty,
max(A.SUP_QUOTEDPRICE) as SUP_QUOTEDPRICE
from PURCHLINE A

join INVENTDIM  B on B.DATAAREAID=A.DATAAREAID and B.INVENTDIMID=A.INVENTDIMID



where exists( select 1 from PURCHLINE find where find.DATAAREAID=A.DATAAREAID and find.PURCHID=A.PURCHID and find.REMAININVENTPHYSICAL!=0)
and A.DATAAREAID='001'
--A.DATAAREAID='001'
--and A.PURCHID='A1-201801/00015'
and DATEADD(HH,8,A.CREATEDDATETIME)>='2017-1-30'
 
group by A.DATAAREAID, A.PurchId, A.ItemId,
A.TEC_LEAVEFACTORYDATE,
B.InventColorId,B.InventSizeId,B.configId)  as Line

join INVENTTABLE D on d.DATAAREAID=line.DATAAREAID and d.ITEMID=line.ITEMID
join PURCHTABLE  B on B.DATAAREAID=line.DATAAREAID and B.PURCHID=line.PURCHID
join INVENTCOLOR E on  E.DATAAREAID=line.DATAAREAID and E.INVENTCOLORID=line.INVENTCOLORID and E.ITEMID=line.ITEMID

cross apply  (select 
max([FGCode]) as FGCode,
max([SiteName]) as SiteName,
--sum([ReceiveTotal]) as ReceiveTotal,
sum([ReceiveTotal]+[InvoiceTotal]) as ReceiveTotal,
sum([InvoiceTotal]) as InvoiceTotal,
sum([ReceiveNowIQC]) as ReceiveNowIQC,
sum([ReturnNow]) as ReturnNow,
sum([REMAINPURCHPHYSICAL]-[RemianPurchQytQM]) as NotArrivalQTY,
sum([RemianPurchQytQM]) as RemianPurchQytQM,
Sum(PurchQty-[ReceiveTotal]) as POWarehouseDifferences, 
sum(PendingQtyPurch) as PendingQtyPurch,  
sum([RemainInvoice]) as [RemainInvoice]
from VM_PurchlineInfo AA where AA.DATAAREAID=Line.DATAAREAID 
and AA.PURCHID=Line.PURCHID and AA.ITEMID=Line.ITEMID and AA.INVENTCOLORID=Line.INVENTCOLORID
and AA.INVENTSIZEID=Line.INVENTSIZEID and AA.CONFIGID=Line.CONFIGID and AA.TEC_LEAVEFACTORYDATE=Line.TEC_LEAVEFACTORYDATE) as SS

