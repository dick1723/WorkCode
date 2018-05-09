
create view  VM_PackListLine

as 
select 
A.DataAreaId,
case  A.STATUS
when 0  then N'未结订单/Open'
when 1  then N'已交货/Delivered'
when 2  then N'已开票/Invoiced'
when 3  then N'已取消/Canceled'
when 4  then N'日记帐/Journal'
else N'停用/Void' end as LineStatus, 
A.ORDERSTYLE,
A.CUSTACCOUNT,
A.SALESID,
A.PACKINGLISTID,
B.ACTUALDLVDATE,
A.SHIPPINGDATECONFIRMED,
A.ITEMID,
dbo.F_GetCustVendStyple(A.DATAAREAID,A.itemid,dim.INVENTCOLORID,dim.CONFIGID,A.CUSTACCOUNT,4) as CustStyle,
C.ITEMNAME,
A.QTY,
d.TEC_SALESTYPE,
d.SALESPRICE,
b.INVOICEDATE,
b.INVOICENO,
A.CSM_INTERNALCDNO,
A.SUP_BATCHNUMBER,
A.REMARK,
B.ETDDate,
A.DOCUMENTDATE,
A.DeliveryName,
D.CURRENCYCODE,
A.SUP_PERMITNO,
A.SUP_WEIGHT,
A.SUP_NETWEIGHT,
A.SUP_SALESGROUPNAME
from THK_SalesPackingListLine A
join INVENTDIM				  dim on Dim.DATAAREAID=A.DATAAREAID and Dim.INVENTDIMID=A.INVENTDIMID
join THK_SalesPackingListTable B  on B.dataareaid=A.dataareaid and B.PackingListId=A.PackingListId
join INVENTTABLE			   c  on C.DATAAREAID=A.DATAAREAID and C.ITEMID=A.ITEMID
join salesline                 d  on d.DATAAREAID=A.DATAAREAID and d.INVENTTRANSID=A.INVENTTRANSID

