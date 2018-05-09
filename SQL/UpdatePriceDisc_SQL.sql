select top 1 b.PURCHID,A.LINEAMOUNT,A.LINEAMOUNTNOMULTI  from PurchParmLine  A

join PURCHPARMTABLE B on  B.DATAAREAID=A.DATAAREAID and B.PARMID=A.PARMID and B.TABLEREFID=A.TABLEREFID



     where  A.DATAAREAID='001' and  A.LineAmountNoMulti=0 and LINEAMOUNT!=0
     and B.ORDERING=7
select *  from VendInvoiceInfoTable where  DATAAREAID='001' and  SUP_TotalAmountNoMulti=0 and SUP_TOTALAMOUNT!=0
select *  from VendInvoiceInfoLine  where  DATAAREAID='001' and  LineAmountNoMulti=0   and lineAmount!=0


select * from dbo.TEC_PURCHPENDINGINVOICECO30994  where DATAAREAID='001' and  ActualAmountNoMulti=0   and ActualAmount!=0

select * from dbo.TEC_PURCHPENDINGINVOICECO30994  where DATAAREAID='001' and  InvoiceAmountNoMulti=0   and InvoiceAmount!=0


go

update  VendInvoiceInfoTable set  SUP_TotalAmountNoMulti=SUP_TOTALAMOUNT where  DATAAREAID='001' and  SUP_TotalAmountNoMulti=0 and SUP_TOTALAMOUNT!=0 

update  VendInvoiceInfoLine set  LineAmountNoMulti=lineAmount where  DATAAREAID='001' and  LineAmountNoMulti=0   and lineAmount!=0
update dbo.TEC_PURCHPENDINGINVOICECO30994  set ActualAmountNoMulti=ActualAmount where DATAAREAID='001' and  ActualAmountNoMulti=0   and ActualAmount!=0
update dbo.TEC_PURCHPENDINGINVOICECO30994  set InvoiceAmountNoMulti=InvoiceAmount where DATAAREAID='001' and  InvoiceAmountNoMulti=0   and InvoiceAmount!=0
update PURCHPARMLINE  set  LineAmountNoMulti=lineAmount 

 from PurchParmLine  A

join PURCHPARMTABLE B on  B.DATAAREAID=A.DATAAREAID and B.PARMID=A.PARMID and B.TABLEREFID=A.TABLEREFID
where  A.DATAAREAID='001' and  A.LineAmountNoMulti=0 and LINEAMOUNT!=0  and B.ORDERING=7

