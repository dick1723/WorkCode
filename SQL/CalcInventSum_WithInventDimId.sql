select AA.DATAAREAID,AA.ITEMID,AA.INVENTDIMID,(AA.AvailPhycisal-AA.NegQty) as EndQty  from (
select
this.DATAAREAID, 
this.ITEMID,
dim.CONFIGID,dim.INVENTCOLORID,dim.[INVENTSITEID]
,dim.[INVENTLOCATIONID]
,dim.[CONFIGID]
,dim.[INVENTCOLORID]
,dim.[INVENTSIZEID]
,dim.[INVENTBATCHID],

sum((this.PostedQty + this.Received - this.Deducted + this.Registered - this.Picked- this.ReservPhysical)) as AvailPhycisal,

isnull((select SUM(qty) from [VM_InventTransQtyAmount] trans where trans.ReceiveDate<=GETDATE() and trans.ReceiveDate>='2018-3-1'
and trans.DATAAREAID=this.DATAAREAID and trans.INVENTDIMID=this.INVENTDIMID),0) as NegQty

from INVENTSUM  this  

join INVENTDIM  dim on dim.DATAAREAID=this.DATAAREAID and dim.INVENTDIMID=this.INVENTDIMID

where this.DATAAREAID='001' and this.ITEMID='9AW40018Y'
and this.CLOSED=0
and (this.PostedQty + this.Received - this.Deducted + this.Registered - this.Picked- this.ReservPhysical)!=0 group by
this.DATAAREAID,  this.ITEMID,dim.CONFIGID,dim.INVENTCOLORID,dim.[INVENTSITEID]
,dim.[INVENTLOCATIONID]
,dim.[CONFIGID]
,dim.[INVENTCOLORID]
,dim.[INVENTSIZEID]
,dim.[INVENTBATCHID] ) AA

where AA.AvailPhycisal-AA.NegQty>0