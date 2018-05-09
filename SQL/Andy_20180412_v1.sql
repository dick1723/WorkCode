truncate table  SUP_Mikez_20180412
--1st insert purchline
insert into SUP_Mikez_20180412
(
  dataAreaId,prodid,itemIdFG,configId,itemid,InventTransIdPBOM,InventDimIdPBOM,BOMRefRecIdOrig,
  RefRecIdBOM,InventColorId,InventSizeid,  
  recid,recversion
)

select
prod.dataareaid, 
prod.PRODID,
prod.ITEMID,
dim.CONFIGID,
pbom.ITEMID,
pbom.INVENTTRANSID,
pbom.INVENTDIMID,
pbom.BOMREFRECID,
[dbo].[F_GetBOMFromProdBOM](pbom.DATAAREAID,prod.BOMID,pbom.ITEMID,pbom.GROUPNAME,dbom.INVENTCOLORID,prod.BOMDATE) as BOMRecid,
dbom.INVENTCOLORID,
dbom.INVENTSIZEID,
pbom.RECID,
1
from  PRODTABLE prod 

join INVENTDIM dim on dim.DATAAREAID=prod.DATAAREAID and dim.INVENTDIMID=prod.INVENTDIMID
join PRODBOM	 pbom on pbom.DATAAREAID=prod.DATAAREAID and pbom.PRODID=prod.PRODID
join INVENTDIM   dbom on dbom.DATAAREAID=pbom.DATAAREAID and dbom.INVENTDIMID=pbom.INVENTDIMID
join INVENTTABLE  it on it.DATAAREAID=pbom.DATAAREAID and it.ITEMID=pbom.ITEMID and it.ITEMGROUPID=N'Lthr¥Ö®Æ'
where prod.DATAAREAID in ('001','201','301','321','501','601','611')
and (prod.CONFIRMEDDLV>='2018-01-01' and prod.CONFIRMEDDLV<='2018-3-31')
and prod.PRODSTATUS in (5,7) 





--2rd get the priceCalcid

update  SUP_Mikez_20180412 set PriceCalcId=dbo.[F_GetPriceDataId]('005',SUP_Mikez_20180412.ItemIDFG,SUP_Mikez_20180412.CONFIGID)

--3rd get the bomcalcTrans

update  SUP_Mikez_20180412 set RefRecIdBOMcalcTransDB=dbo.F_GetBOMCalcFromProdBOM('005',SUP_Mikez_20180412.itemid,SUP_Mikez_20180412.InventColorId,SUP_Mikez_20180412.InventSizeid,SUP_Mikez_20180412.PricecalcId)