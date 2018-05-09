select 
 A.[DATAAREAID] as  DATAAREAID
,A.[ITEMID] as ITEMID
,A.[INVENTSITEID]
,A.[INVENTLOCATIONID]
,A.[CONFIGID]
,A.[INVENTCOLORID]
,A.[INVENTSIZEID]
,A.[INVENTBATCHID]
,round(sum([QTY]),4) as Qty
,round(sum([FinancialAmount]),4) as Amount
  --,DATEDIFF(day,ReceiveDate,@reportDate) as DaysDiff
 from  [VM_InventTransQtyAmount] A 
 
join INVENTTABLE it on it.DATAAREAID=A.dataareaid and it.ITEMID=a.itemid

where  A.dataareaid='001'
and it.ITEMTYPE!=2--- server type no need)
and A.reportdate<='2018-2-28'
and A.ITEMID='9AW40069S'
group by A.DATAAREAID,A.ITEMID,A.[INVENTSITEID]
,A.[INVENTLOCATIONID]
,A.[CONFIGID]
,A.[INVENTCOLORID]
,A.[INVENTSIZEID]
,A.[INVENTBATCHID] having isnull(SUM(A.Qty),0)>0