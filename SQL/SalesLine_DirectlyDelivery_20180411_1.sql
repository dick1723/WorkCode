select
 
A.DATAAREAID ,
A.SALESID,
A.ITEMID,
A.TEC_SalesType,
dim1.CONFIGID,
dim1.INVENTLOCATIONID,
A.INVENTTRANSID,
A.CONFIRMEDDLV,

case A.Tec_CollectionYN
when 0 then N'Collection/要收费'
when 1 then N'FreeOfCharge/免费'
else 'FreeOfChargeRedo/免费-重做' end as  FreeOrNot,
A.SALESQTY,
A.RemainSalesPhysical,
A.RemainSalesFinancial,
dbo.F_SalesDeliveredInTotal(A.DATAAREAID,A.INVENTTRANSID) AS DeliveryTotal,
dbo.[F_SalesLineInvoiceTotal](A.DATAAREAID,A.INVENTTRANSID) AS InvoiceTotal,

inter.DATAAREAID  as InterDataAreaId,
inter.SALESID  as InterSalesId,
inter.ITEMID as InteritemId,
inter.TEC_SALESTYPE as InterSalesType,
dim2.CONFIGID as InterConfigId,
dim2.INVENTLOCATIONID as InterInlocationid,
inter.INVENTTRANSID as InterInventTransId,
inter.CONFIRMEDDLV as InterConfirmDlv,
case Inter.Tec_CollectionYN
when 0 then N'Collection/要收费'
when 1 then N'FreeOfCharge/免费'
else 'FreeOfChargeRedo/免费-重做' end as  InterFreeOrNot,
inter.SALESQTY as InterSalesQty,
inter.RemainSalesPhysical as  InterRemainSalesPhysical,
inter.RemainSalesFinancial as InterRemainSalesFinancial,
dbo.F_SalesDeliveredInTotal(inter.DATAAREAID,inter.INVENTTRANSID)   AS InterDeliveryTotal,
dbo.[F_SalesLineInvoiceTotal](inter.DATAAREAID,inter.INVENTTRANSID) AS InterInvoiceTotal

   
from SALESLINE  A
join INVENTDIM  dim1 on dim1.DATAAREAID=A.DATAAREAID and dim1.INVENTDIMID=A.INVENTDIMID

left join PURCHLINE B  on  B.DATAAREAID=A.DATAAREAID and B.INVENTREFTRANSID=A.INVENTTRANSID
left join PURCHTABLE C on  C.DATAAREAID=A.DATAAREAID and C.PURCHID=b.PURCHID
left join SALESLINE inter on inter.DATAAREAID=C.INTERCOMPANYCOMPANYID and inter.INVENTTRANSID=B.INTERCOMPANYINVENTTRANSID
join INVENTDIM  dim2  on dim2.DATAAREAID=inter.DATAAREAID and dim2.INVENTDIMID=inter.INVENTDIMID

where A.DATAAREAID='001' 
--and A.REMAINSALESPHYSICAL>0 
and A.INVENTTRANSID='39946850_101'
and A.CREATEDDATETIME<='2018-4-1' and dim1.INVENTSITEID in ('006','007','008','010','011')