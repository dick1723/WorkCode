--get Purchline Info
select 
A.dataareaid, 
A.VENDACCOUNT,
V.NAME,
A.PURCHID,
A.ITEMID,
it.ITEMNAME,
it.NAMEALIAS,
A.PURCHPLACER,
A.ITEMBUYERGROUPID,
b.INVENTCOLORID,
color.NAME,
A.SUP_YEARMONTH,
A.PURCHQTY,
A.PURCHUNIT,
A.purchprice,
A.SUP_VENDQUOTATIONPRICE,
A.CURRENCYCODE,
A.SALESID,
A.TEC_SALESINVENTTRANSID,
A.CUSTACCOUNT,
A.INVENTTRANSID,
A.TEC_INVENTREFTRANSID,
A.REQPOID,
A.PURCHREQID,
A.SUP_APPROVEDATE,
A.SUP_PURCHREASON,
DATEADD(HH,8,A.CREATEDDATETIME) as POLineCreateDate,
AA.PurchQPPrice,
AA.TAQPPrice,
AA.EBOMQPPrice,
AA.RefRecIdEBOM,
AA.PriceCalcId,
AA.itemidFG,
AA.ConfigId,
SL.ITEMID,
SLDIM.CONFIGID,
InvoiceLine.RECID ,
InvoiceLine.LINEAMOUNT,
InvoiceLine.LineAmountTax,
InvoiceLine.Qty,

case InvoiceLine.qty 
when 0 then 0
when null then 0
else 
CONVERT(decimal(16,4), (InvoiceLine.LINEAMOUNT+InvoiceLine.LINEAMOUNTTAX)/InvoiceLine.QTY)  end as  InvoicePrice,
AA.MultiLnPercent
from  SUP_MIkez_20180324 AA 

left join PURCHLINE A		on A.DATAAREAID=AA.dataareaId		and A.INVENTTRANSID=AA.inventTransId
left join INVENTTABLE it	on it.DATAAREAID=A.DATAAREAID		and it.ITEMID=a.ITEMID
left join VENDTABLE  V		on V.DATAAREAID=A.DATAAREAID		and V.ACCOUNTNUM=A.VENDACCOUNT
left join INVENTDIM  B		on B.DATAAREAID=A.DATAAREAID		and B.INVENTDIMID=A.INVENTDIMID
left join INVENTCOLOR color on color.DATAAREAID=B.DATAAREAID	and color.ITEMID=A.ITEMID and color.INVENTCOLORID=B.INVENTCOLORID
left join SALESLINE  SL		on SL.DATAAREAID=A.DATAAREAID		and SL.INVENTTRANSID=A.TEC_SALESINVENTTRANSID
join  INVENTDIM	 SLDim		on SLDim.DATAAREAID=SL.DATAAREAID	and SLDim.INVENTDIMID=SL.INVENTDIMID
outer  apply ( select top 1 * from VENDINVOICETRANS Inv where Inv.DATAAREAID=AA.DATAAREAID and Inv.INVENTTRANSID=AA.INVENTTRANSID)  as InvoiceLine