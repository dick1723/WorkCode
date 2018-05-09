select 
prod.DATAAREAID,
prod.CONFIRMEDDLV,
prod.PRODID,
prod.PRODSTATUS,
prod.WORKSHOP,
prod.PRODUCTLINE,
prod.ITEMID,
dim.CONFIGID,
config.NAME,
prod.QTYSCHED,
prod.BOMID,
prod.BOMDATE,

pbom.ITEMID as MMItem,
it.ITEMNAME,
it.NAMEALIAS,
it.ITEMGROUPID,
dbom.INVENTCOLORID,
color.NAME,
pbom.GROUPID,
pbom.BOMQTYSERIE,
pbom.BOMQTY,
pbom.SCRAPVAR,
pbom.UNITID,
pbom.QTYBOMCALC,
pbom.REMAINBOMFINANCIAL,
pbom.ACTURALPICKQTY,
pbom.GROUPNAME,
pbom.BOMRefRecId,
pbom.BOMID,
[dbo].[F_GetBOMFromProdBOM](pbom.DATAAREAID,prod.BOMID,pbom.ITEMID,pbom.GROUPNAME,dbom.INVENTCOLORID,prod.BOMDATE) as BOMRecid

from  PRODTABLE prod 

join INVENTDIM dim on dim.DATAAREAID=prod.DATAAREAID and dim.INVENTDIMID=prod.INVENTDIMID
join CONFIGTABLE config on config.DATAAREAID=prod.DATAAREAID and config.ITEMID=prod.ITEMID and config.CONFIGID=dim.CONFIGID
join PRODBOM	 pbom on pbom.DATAAREAID=prod.DATAAREAID and pbom.PRODID=prod.PRODID
join INVENTDIM   dbom on dbom.DATAAREAID=pbom.DATAAREAID and dbom.INVENTDIMID=pbom.INVENTDIMID
join INVENTTABLE  it on it.DATAAREAID=pbom.DATAAREAID and it.ITEMID=pbom.ITEMID and it.ITEMGROUPID=N'LthrÆ¤ÁÏ'
join INVENTCOLOR color on color.DATAAREAID=dbom.DATAAREAID and color.ITEMID=pbom.ITEMID and color.INVENTCOLORID=dbom.INVENTCOLORID
left join BOM   bom on bom.DATAAREAID=pbom.DATAAREAID and bom.RECID=pbom.BOMREFRECID
where prod.DATAAREAID in ('001','201','301','321','501','601','611')
--and (prod.CONFIRMEDDLV>='2018-01-01' and prod.CONFIRMEDDLV<='2018-3-31')

and prod.PRODSTATUS in (5,7) 
and exists (select 1 from salestable st  where st.DATAAREAID=prod.DATAAREAID and st.SALESID=prod.SALESID
and dateadd(HH,8,st.CREATEDDATETIME) between '2017-01-1' and '2017-12-31')
