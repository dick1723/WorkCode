select 
A.DataAreaId,

case  A.STATUS
when 0  then N'δ�ᶩ��/Open'
when 1  then N'�ѽ���/Delivered'
when 2  then N'�ѿ�Ʊ/Invoiced'
when 3  then N'��ȡ��/Canceled'
when 4  then N'�ռ���/Journal'
else N'ͣ��/Void' end as LineStatus, 
A.ORDERSTYLE,
A.CUSTACCOUNT,
A.SALESID,
A.PACKINGLISTID,
B.ACTUALDLVDATE,
A.SHIPPINGDATECONFIRMED,
A.ITEMID,
--c.NameAlias,
dbo.F_GetCustVendStyple(A.DATAAREAID,A.itemid,A.INVENTDIMID,A.CUSTACCOUNT,4) as CustStyle,
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
from THK_SalesPackingListLine  A
join THK_SalesPackingListTable B  on B.dataareaid=A.dataareaid and B.PackingListId=A.PackingListId
join INVENTTABLE			   c  on C.DATAAREAID=A.DATAAREAID and C.ITEMID=A.ITEMID
join salesline                 d with(index(I_359TRANSIDIDX))  on d.DATAAREAID=A.DATAAREAID and d.INVENTTRANSID=A.INVENTTRANSID


where A.dataareaid='101'