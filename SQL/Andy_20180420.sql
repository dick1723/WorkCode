truncate table  SUP_Mikez_20180324
--1st insert purchline
insert into SUP_Mikez_20180324
(
  dataAreaId,vendaccount,purchid,itemid,ItemBuyerGroupId,inventtransid,tec_salesInventTransId,inventDimId,recid,recversion,PurchQty
)

select
A.dataareaid, 
A.VENDACCOUNT,
A.PURCHID,
A.ITEMID,
A.ITEMBUYERGROUPID,
A.inventtransid,
A.tec_salesInventTransId,
A.inventDimId,
A.recid,
1,
A.purchQty
from PURCHLINE A
join INVENTTABLE it on it.DATAAREAID=A.DATAAREAID and it.ITEMID=a.ITEMID
join VENDTABLE  V  on V.DATAAREAID=A.DATAAREAID and V.ACCOUNTNUM=A.VENDACCOUNT
join INVENTDIM  B  on B.DATAAREAID=A.DATAAREAID and B.INVENTDIMID=A.INVENTDIMID
join INVENTCOLOR color on color.DATAAREAID=B.DATAAREAID and color.ITEMID=A.ITEMID and color.INVENTCOLORID=B.INVENTCOLORID
where (dateadd(HH,8,A.createdDateTime)>='2017/7/1' and dateadd(HH,8,A.createdDateTime)<='2017/12/31')

and A.ItemBuyerGroupId in ('PurDep','PurLocCN' )
and A.PurchPrice>0
and A.dataAreaId in('001','301','321','501','201')


--2nd  get the salesLine itemId and InventDim 

update  SUP_MIkez_20180324 set InventDimIdFG=D.INVENTDIMID ,ItemIdFG=A.ITEMID,configId=D.CONFIGID

from SUP_MIkez_20180324 B 


join SALESLINE A on B.dataareaid=A.DATAAREAID and B.tec_salesInventTransId=A.INVENTTRANSID
join INVENTDIM D on D.DATAAREAID=A.DATAAREAID and D.INVENTDIMID=A.INVENTDIMID

--3rd get the priceCalcid

update  SUP_MIkez_20180324 set PriceCalcId=dbo.[F_GetPriceDataId]('005',B.ItemIDFG,B.CONFIGID)

from SUP_MIkez_20180324 B 


--update  SUP_MIkez_20180324 set PurchQPPrice=A.SUP_VendQuotationPrice

--from SUP_MIkez_20180324 B 

--join PURCHLINE A on B.dataareaid=A.DATAAREAID and B.inventtransId=A.INVENTTRANSID

go

--update  SUP_MIkez_20180324 set TAQPPrice=A.SUP_VendQuotationPrice

--from SUP_MIkez_20180324 B 

--join PRICEDISCTABLE A on B.dataareaid=A.DATAAREAID and B.RefRecIdTA=A.RECID 

--4th

select distinct
C.DATAAREAID,
C.tec_salesinventtransId,
C.ItemIdFG,
C.ConfigId,
s.SALESID,
s.CUSTACCOUNT,
A.DATAAREAID,
A.PRICECALCID,
A.GROUPNAME,
A.KEY1,
B.ITEMNAME,
A.KEY2,
A.TEC_VENDOR,
A.TEC_PURCHPRICE,
A.TEC_CURRENCYCODE,
A.TEC_PURCHUNIT
from SUP_MIkez_20180324 C 

left join SALESLINE S on s.DATAAREAID=C.DATAAREAID and s.INVENTTRANSID=c.tec_salesinventtransId
left join BOMCALCTRANS A on A.PRICECALCID=C.PriceCalcId and A.DATAAREAID='005' 
and A.CALCTYPE=1
--and A.KEY1=C.itemid

left join INVENTTABLE B on B.DATAAREAID=A.DATAAREAID and B.ITEMID=A.KEY1

----join PRICEDISCTABLE  TA on TA.DATAAREAID=C.dataareaid and TA.RECID=C.refrecIdTA
--where A.CALCTYPE=1  and (A.KEY1 like 'T%' or A.KEY1 like 'H%' or A.KEY1 like 'z%' or

--A.KEY1 like 'F%' or A.KEY1 like 'A%' or A.KEY1 like 'TN%' or A.KEY1 like 'TM%' )

--before need to run a ax job SUP_MIkez_20180324
--TA ---no need from 20180328
select
A.DATAAREAID,
A.JOURNALNUM,
A.ITEMBUYERGROUPID,
A.ACCOUNTRELATION,
A.ITEMRELATION,
dim.inventsizeid,

Dim.INVENTCOLORID,
--itemname
A.UNITID,
A.Currency,
A.AMOUNT,
A.TEC_PURCHUNIT,
A.TEC_CURRENCYCODE,
A.TEC_PURCHPRICE,
A.SUP_VENDQUOTATIONPRICE,
A.CUSTACCOUNT,
A.SUP_CreatedBy,
A.ApprovalDate,
A.ApprovalBy,
A.createdDateTime,
A.LINEDISC,
A.LINEPERCENT,
(A.AMOUNT-A.LINEDISC)* (1-A.LINEPERCENT/100) as DiscPrice
from SUP_MIkez_20180324 C 

left join PRICEDISCTABLE  A on A.DATAAREAID=C.dataareaid and A.RECID=C.refrecIdTA

left join  INVENTDIM			 dim on dim.DATAAREAID=A.DATAAREAID and dim.INVENTDIMID=A.INVENTDIMID 

go


--select DATAAREAId, COUNT(1) from SUP_MIkez_20180324 group by DATAAREAId