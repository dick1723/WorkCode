select 
A.DATAAREAID ,
A.ActualDlvDate as 装箱单行日期,
T.ETDDATE as ETD日期,
B.CUSTACCOUNT as 客户,
A.SALESID as 销售订单号,
A.ITEMID as 款号,
D.INVENTSITEID as 站点 ,
D.CONFIGID as 配搭,
A.QTY as 装箱单QTY,
A.SALESQTY as 销售数量,
A.INVENTTRANSID as 批次ID,
B.TEC_SalesType as 销售类别,
case B.SALESSTATUS
when 1 then  N'未结订单/Backorder'
when 2 then  N'已交货/Delivered'
when 3 then  N'已开票/Invoiced'
when 4 then  N'已取消/Canceled'
else 'None' end as 销售行状态,

B.CONFIRMEDDLV as SO行装运日期,
dateadd(HOUR,8,C.CREATEDDATETIME)   as SO头创建日期,
dateadd(HOUR,8,B.CREATEDDATETIME)  as SOLine创建日期,
B.ShippingDateRequested as 计划出货日期,
B.SUP_FirstConfirmDlvDate as 第一确认出货日期,
B.Sup_ShortLeadTime as ShortLEADTIME,
B.SUP_ShortTimeReason as  ShortLEADTIME原因,
B.SUP_SampleApproveDate as 批办日期,
B.SUP_SampleApprovePlanDate  as 预计批办日期,
B.SALESUNIT as 销售单位,
B.SALESPRICE as 销售单价,
B.SUP_CustPODate  as 客户PO下单日期,
B.SUP_remark as 行备注,
T.InvoiceNo as InvoiceId,
A.PackingListId as PackingSlipId
from THK_SALESPACKINGLISTLINE A

join THK_SalesPackingListTable T  on T.DATAAREAID=A.DATAAREAID and T.PACKINGLISTID=A.PACKINGLISTID
join SALESLINE B on B.DATAAREAID=A.DATAAREAID and B.INVENTTRANSID=A.INVENTTRANSID
join INVENTDIM D on D.DATAAREAID=B.DATAAREAID and D.INVENTDIMID=B.INVENTDIMID
join SALESTABLE C on c.DATAAREAID=A.DATAAREAID and C.SALESID=A.SALESID


where A.DATAAREAID in ('001','201','301','321','501','601','611') 
and A.CUSTACCOUNT like '%CH%'
and  (A.ACTUALDLVDATE <='2018-3-31' and  A.ACTUALDLVDATE>='2017-4-1')