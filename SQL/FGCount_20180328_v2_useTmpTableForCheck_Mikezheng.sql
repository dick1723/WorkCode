declare @endDate datetime 
declare @dataareaid nvarchar(3)

set @dataareaid='001'

set @endDate='2018-3-31'

IF OBJECT_ID('tempdb..#FGCount') is not null 
begin 
DROP TABLE #FGCount
END
;
with Onhand as 
(
select
this.DATAAREAID, 
this.ITEMID,
dim.CONFIGID,dim.[INVENTSITEID]
,dim.[INVENTLOCATIONID]
,dim.[INVENTCOLORID]
,dim.[INVENTSIZEID]
,dim.[INVENTBATCHID],
--SUM(this.POSTEDVALUE+this.PHYSICALVALUE) as Amount,
--sum((this.PostedQty + this.Received - this.Deducted + this.Registered - this.Picked- this.ReservPhysical)) as AvailPhycisal,
sum((this.PostedQty + this.Received - this.Deducted + this.Registered - this.Picked)) as AvailPhycisal,-- not negtive reseverphysical
isnull((select SUM(qty) from [VM_InventTransQty] trans where trans.ReceiveDate<=GETDATE() and trans.ReceiveDate>=Dateadd(Day,1,@endDate)
and trans.DATAAREAID=this.DATAAREAID and trans.ITEMID=this.ITEMID and trans.CONFIGID=dim.CONFIGID
and trans.INVENTCOLORID=dim.INVENTCOLORID and trans.INVENTSITEID=dim.INVENTSITEID
and trans.INVENTLOCATIONID=dim.INVENTLOCATIONID and trans.INVENTBATCHID=dim.INVENTBATCHID),0) as NegQty,
isnull((select SUM(qty) from [VM_InventTransQty] trans where trans.ReceiveDate<=GETDATE() 
and trans.DATEPHYSICAL>=Dateadd(Day,1,@endDate)
and trans.dateinvent<@endDate and trans.dateinvent!='1900-01-01'
and trans.DATAAREAID=this.DATAAREAID and trans.ITEMID=this.ITEMID and trans.CONFIGID=dim.CONFIGID
and trans.INVENTCOLORID=dim.INVENTCOLORID and trans.INVENTSITEID=dim.INVENTSITEID
and trans.INVENTLOCATIONID=dim.INVENTLOCATIONID and trans.INVENTBATCHID=dim.INVENTBATCHID),0) as PlusQty

from INVENTSUM  this  

join INVENTDIM  dim on dim.DATAAREAID=this.DATAAREAID and dim.INVENTDIMID=this.INVENTDIMID
join INVENTTABLE it on it.DATAAREAID=this.DATAAREAID and it.ITEMID=this.ITEMID 
where this.DATAAREAID=@dataareaid
--and this.ITEMID='9MK40055-1'
--and this.CLOSED=0 
and it.ITEMGROUPID=N'FG¦¨«~'
 group by
this.DATAAREAID,  
this.ITEMID,
dim.CONFIGID,dim.INVENTCOLORID,dim.[INVENTSITEID]
,dim.[INVENTLOCATIONID]
,dim.[CONFIGID]
,dim.[INVENTCOLORID]
,dim.[INVENTSIZEID]
,dim.[INVENTBATCHID])



select 
convert(date,@endDate) as EndDate,
AA.DATAAREAID,
AA.ITEMID,
AA.CONFIGID,
AA.INVENTCOLORID,
AA.INVENTSIZEID,
AA.INVENTSITEID,
AA.INVENTLOCATIONID,
AA.INVENTBATCHID,
AA.AvailPhycisal,
AA.NegQty,
round((AA.AvailPhycisal-aa.NegQty+AA.PlusQty),4) AS OnhandEndQty

into #FGCount
from Onhand AA 
where (AA.AvailPhycisal-AA.NegQty+AA.PlusQty)!=0   
  

go
--select * from #FGCount

select 
AA.DATAAREAID,
AA.ITEMID,
AA.CONFIGID,
AA.INVENTCOLORID,
AA.INVENTSIZEID,
AA.INVENTSITEID,
AA.INVENTLOCATIONID,
AA.INVENTBATCHID,
AA.INVENTQTYCOUNTED
 from  TEC_INVENTCOUNT AA 

left  join  #FGCount  A on  A.DATAAREAID=AA.DATAAREAID
and A.ITEMID	=AA.ITEMID
and A.CONFIGID  =AA.CONFIGID
and A.INVENTCOLORID =AA.INVENTCOLORID
and A.INVENTSIZEID  =AA.INVENTSIZEID
and A.INVENTSITEID  =AA.INVENTSITEID
and A.INVENTLOCATIONID=AA.INVENTLOCATIONID
and A.INVENTBATCHID  =AA.INVENTBATCHID


where AA.DATAAREAID='001' and AA.JOURNALID='794837_103'
and AA.INVENTQTYCOUNTED!=A.OnhandEndQty
--and A.ITEMID is null 


