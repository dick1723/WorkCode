Declare @fromDate datetime
declare @toDate datetime
declare @companyId nvarchar(4)
declare @itemId		nvarchar(20)
declare @itemGroupid  nvarchar(20)

set @itemGroupid=N'FG¦¨«~'
set @companyId='101'
set @fromDate='2018-02-01'
set @toDate  ='2018-02-28'
set @itemId  =''

--IF OBJECT_ID('tempdb..#InventReportMM') is not null 
--begin 
--DROP TABLE #InventReportMM
--END

;
with  OnHandStart
as 
(
select A.ItemId, dim.configId, dim.InventSizeId,dim.INVENTBATCHID
, dim.InventColorId, dim.InventSiteId, dim.InventLocationId,   
dim.WMSLOCATIONID,A.qty,A.DATAAREAID ,A.InventDimId
 from(
 select trans.ItemId,trans.InventDimId,trans.DATAAREAID, sum(trans.QTY) as qty
from [VM_InventTransQty] trans  inner join INVENTTABLE inv on trans.ITEMID=inv.ITEMID 
and trans.DATAAREAID = inv.DATAAREAID
where  trans.ReceiveDate<datediff(D,-1,@fromDate) and trans.DATAAREAID=@companyId
and (trans.ITEMID=@itemId or @itemid='') and inv.ITEMGROUPID!=@itemGroupid
group by trans.ItemId, trans.InventDimId ,trans.DATAAREAID 
having ISNULL(sum(trans.qty),0)!=0
) A  inner join INVENTDIM dim
 on A.InventDimId=dim.INVENTDIMID and A.DATAAREAID=dim.DATAAREAID
 ) ,


OnHandEnd
as 
(
select A.ItemId, dim.configId, dim.InventSizeId,dim.INVENTBATCHID 
, dim.InventColorId, dim.InventSiteId, dim.InventLocationId,   
dim.WMSLOCATIONID,A.qty,A.DATAAREAID ,A.InventDimId
 from(
 select trans.ItemId,trans.InventDimId,trans.DATAAREAID, sum(trans.QTY) as qty
from [VM_InventTransQty] trans  inner join INVENTTABLE inv on trans.ITEMID=inv.ITEMID 
and trans.DATAAREAID = inv.DATAAREAID
where  trans.ReceiveDate<=@toDate and  trans.DATAAREAID=@companyId
and (trans.ITEMID=@itemId or @itemid='') and inv.ITEMGROUPID!=@itemGroupid
group by trans.ItemId, trans.InventDimId ,trans.DATAAREAID 
having ISNULL(sum(trans.qty),0)!=0
 ) A  inner join INVENTDIM dim
 on A.InventDimId=dim.INVENTDIMID and A.DATAAREAID=dim.DATAAREAID
 ) 
,

rec
as 
(
select A.ItemId, dim.configId, dim.InventSizeId,dim.INVENTBATCHID  
, dim.InventColorId, dim.InventSiteId, dim.InventLocationId,   
dim.WMSLOCATIONID,A.qty,A.DATAAREAID ,A.InventDimId
 from(
 select trans.ItemId,trans.InventDimId,trans.DATAAREAID, sum(trans.QTY) as qty
from [VM_InventTransQty] trans  inner join INVENTTABLE inv on trans.ITEMID=inv.ITEMID 
and trans.DATAAREAID = inv.DATAAREAID
where  trans.ReceiveDate>=@fromDate
and trans.ReceiveDate<=@toDate  and  trans.DATAAREAID=@companyId  and (trans.ITEMID=@itemId or @itemid='')
and trans.QTY>0 and trans.TransType!=7 and trans.VOUCHERPHYSICAL!='' and inv.ITEMGROUPID!=@itemGroupid
group by trans.ItemId, trans.InventDimId ,trans.DATAAREAID 
) A  inner join INVENTDIM dim
 on A.InventDimId=dim.INVENTDIMID and A.DATAAREAID=dim.DATAAREAID

)
,

iss
as 
(
select A.ItemId, dim.configId, dim.InventSizeId,dim.INVENTBATCHID  
, dim.InventColorId, dim.InventSiteId, dim.InventLocationId,   
dim.WMSLOCATIONID,A.qty,A.DATAAREAID ,A.InventDimId
 from(
 select trans.ItemId,trans.InventDimId,trans.DATAAREAID, sum(trans.QTY) as qty
from [VM_InventTransQty] trans  inner join INVENTTABLE inv on trans.ITEMID=inv.ITEMID 
and trans.DATAAREAID = inv.DATAAREAID
where  trans.ReceiveDate>=@fromDate
and trans.ReceiveDate<=@toDate   and  trans.DATAAREAID=@companyId and (trans.ITEMID=@itemId or @itemid='')
and trans.QTY<0 and trans.TransType!=7 and trans.VOUCHERPHYSICAL!=''  and inv.ITEMGROUPID!=@itemGroupid 
group by trans.ItemId, trans.InventDimId ,trans.DATAAREAID 
 ) A  inner join INVENTDIM dim
 on A.InventDimId=dim.INVENTDIMID and A.DATAAREAID=dim.DATAAREAID
)

--select A.* from OnHandEnd  A

--left join OnHandEnd  B  on  B.DATAAREAID=A.DATAAREAID and B.ITEMID=A.ITEMID and B.CONFIGID=A.CONFIGID
-- and B.INVENTCOLORID=A.INVENTCOLORID and B.INVENTLOCATIONID=A.INVENTLOCATIONID and B.INVENTSIZEID=A.INVENTSIZEID


select     AA.DataAreaId,AA.ItemId,AA.ConfigId,AA.InventColorId,AA.InventSiteId,AA.InventLocationId,
  AA.WMSLocationId ,
  convert(decimal(16,4),isnull(sum(AA.Start),0)) as StartQty,
  convert(decimal(16,4),isnull(sum(AA.EndQty),0)) as EndQty,
  convert(decimal(16,4),isnull(sum(AA.Iss),0)) as Iss,
  convert(decimal(16,4),isnull(sum(AA.Rec),0)) as Rec
  --into #InventReportMM 
  from (
select  A.ItemId, A.configId, A.InventSizeId  
, A.InventColorId, A.InventSiteId, A.InventLocationId,   
A.WMSLOCATIONID,A.INVENTBATCHID, A.DATAAREAID  ,isnull(A.Qty,0) as Start,isnull(B.Qty,0)as EndQty
,isnull(C.Qty,0) as Iss,isnull(D.Qty,0) as Rec
 from OnHandStart  A 
  left join OnHandEnd B on A.InventDimId=B.InventDimId
  left join iss C on A.InventDimId=C.InventDimId
  left join rec  D on A.InventDimId=D.InventDimId
  where isnull(A.Qty,0)!=0 or isnull(B.Qty,0)!=0 or isnull(C.Qty,0)!=0 or isnull(D.Qty,0)!=0 
 
  UNION  

select B.ItemId, B.configId, B.InventSizeId  
, B.InventColorId, B.InventSiteId, B.InventLocationId,   
B.WMSLOCATIONID,A.INVENTBATCHID, B.DATAAREAID ,
isnull(A.Qty,0) as Start,isnull(B.Qty,0)as EndQty
,isnull(C.Qty,0) as Iss,isnull(D.Qty,0) as Rec
 from OnHandEnd  B 
 left join OnHandStart A on B.InventDimId=A.InventDimId
  left join iss C on B.InventDimId=C.InventDimId
  left join rec  D on B.InventDimId=D.InventDimId
  where isnull(A.Qty,0)!=0 or isnull(B.Qty,0)!=0 or isnull(C.Qty,0)!=0 or isnull(D.Qty,0)!=0 
 
  
 UNION 
 
    select   C.ItemId, C.configId, C.InventSizeId  
, C.InventColorId, C.InventSiteId, C.InventLocationId,   
C.WMSLOCATIONID,A.INVENTBATCHID, C.DATAAREAID ,
isnull(A.Qty,0) as Start,isnull(B.Qty,0)as EndQty
,isnull(C.Qty,0) as Iss,isnull(D.Qty,0) as Rec
 from iss  C
 left join OnHandStart A on C.InventDimId=A.InventDimId
  left join OnHandEnd B on C.InventDimId=B.InventDimId
  left join rec  D on C.InventDimId=D.InventDimId
  where isnull(A.Qty,0)!=0 or isnull(B.Qty,0)!=0 or isnull(C.Qty,0)!=0 or isnull(D.Qty,0)!=0 
 
 
  UNION 
  
   select   D.ItemId, D.configId, D.InventSizeId  
, D.InventColorId, D.InventSiteId, D.InventLocationId,   
D.WMSLOCATIONID,A.INVENTBATCHID, D.DATAAREAID,
isnull(A.Qty,0) as Start,isnull(B.Qty,0)as EndQty
,isnull(C.Qty,0) as Iss,isnull(D.Qty,0) as Rec
 from rec  D
 left join OnHandStart A on D.InventDimId=A.InventDimId
  left join OnHandEnd B on D.InventDimId=B.InventDimId
  left join iss  C on D.InventDimId=C.InventDimId
  where isnull(A.Qty,0)!=0 or isnull(B.Qty,0)!=0 or isnull(C.Qty,0)!=0 or isnull(D.Qty,0)!=0 ) as AA
  
  group by  AA.DataAreaId,AA.ItemId,AA.ConfigId,AA.InventColorId,AA.InventSiteId,AA.InventLocationId,
  AA.WMSLocationId 
  
  
  --select A.*,A.StartQty,B.QTYCOUNTEDOPEN,A.EndQty,B.INVENTQTYCOUNTED,abs(A.Iss),B.TRANSOUTQTY,A.Rec,B.TRANSQTY from #InventReportMM A
  
  --join TEC_InventCount B on B.dataareaid=A.dataareaid 
  --and B.itemid=A.itemid and B.configid=A.configid
  --and B.inventcolorId=A.inventcolorId and B.inventsiteid=A.inventsiteid and B.inventlocationId=A.inventlocationid
  --and B.wmslocationid=A.wmslocationId and b.dataareaid='001' and B.journalid='790776_103'
  
  --where A.StartQty!=B.QtyCountedOpen or  A.EndQty!=B.InventQtyCounted  or A.Rec!=B.TransQty
  
  --or ABS(A.Iss)!=B.TransOutQty
  
  --where DATAAREAID='001' and  ITEMID='AC0006'  and InventColorId='19-0303-RS'
  
  
