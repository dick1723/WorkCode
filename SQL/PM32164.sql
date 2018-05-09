IF OBJECT_ID('tempdb..#purchTmp') is not null 
begin 
DROP TABLE #purchTmp
END
select * into #purchTmp from [dbo].[VM_PurchlineInfo] A
  
where A.itembuyergroupId in ('PurDep','PurLocCN','P1PurDep','PurDepMisc') 
and A.[REMAINPURCHPHYSICAL]!=0 
and A.dataareaid='001'
and A.purchId='A1-201710/00298'
and A.vendaccount='001549_047'

--PO行创建日期(开始&结束)---A.CreateDate	

--ii.采购订单，A.purchid
--iii.供应商编号，A.vendAccount
--iv.采购员组，A.itembuyergroupid
--v.订货人，A.purchplacer
--vi.物料编号， A.itemId
	

SELECT 
A.[DATAAREAID]
,min([CREATEDDATE]) as '订单日期'
,max([TEC_ORDERMONTH]) as '订单月份'
,A.[PURCHID] as '订单号'
,max(A.[PURCHNAME]) as '供应商简称'
,max(A.[ItemBuyerGroupId]) as ItemBuyGroupId
,max([SUP_INTERCOMPANYPURCHITEMID]) as  '内部公司物料编码'
,max([ExternalCode]) as '外部编号'
,A.itemid as '存货编码'
,max([FGCode]) as  '成品编码'
,max([itemName]) as '存货名称'
,max([NAMEALIAS]) as '英文名称'
,max([SiteName]) as '站点'
,A.[INVENTCOLORID]
,MAX(A.colorNameCN) as ColorNamCN
,MAX(A.ColorNameEN) as ColorNameEN
,max([SUP_REFERENCE]) as Refrence
,max([PURCHUNIT]) as '主计量单位'
,sum([PURCHQTY]) as '数量'
,sum([ReceiveTotal]) as '累计入库件数'

,sum([InvoiceTotal]) as '累计发票数量'

,sum([ReceiveNowIQC]) as '到货数量'

,sum([ReturnNow]) as '退货数量'

,sum([REMAINPURCHPHYSICAL]-[RemianPurchQytQM]) as '未到货数量'

,sum([REMAINPURCHPHYSICAL]) as '剩余交货量'

,sum([RemianPurchQytQM]) as '到货未入库'

,sum([OweQty])  as '欠料数'

--//PO入库差异数(PurchQty -累计入库件数)
, Sum(PurchQty-[ReceiveTotal]) as 'PO入库差异数'
, 
max(A.DeliveryDate) as '计划到货日期',

max(A.SUP_RequireDelivery) as  '要求到货日期',--todo
max(salesid) as '销售订单号',
max(custAccount) as '客户编码'
,
max(remarks) as remarks ,
max(purchplacer) as purchPlacer,
max(TEC_FIRSTCONFIRMATIONDATE) as firstConfirmDate,
max(CONFIRMEDDLV) as ConfirmDlv,
max(ModifiedDate) as ModifedDate,
sum(PendingQtyPurch) as PendingQtyPurch      
,sum([RemainInvoice]) as [RemainInvoice]
,max([Tec_LeaveFactoryDate]) as  [Tec_LeaveFactoryDate]
,max([ETDDATE]) as  [ETDDATE]
,max([TEC_ARRIVALDATE]) as [TEC_ARRIVALDATE],
max(SUP_DelayReason) as SUP_DelayReason,
case max(SUP_QUOTEDPRICE)
when 0 then 'Y'
else 'N' end as SUP_QUOTEDPRICE --todo
from  #purchTmp   A


group by  A.[DATAAREAID], A.PurchId, A.ItemId, A.InventColorId,A.InventSizeId,A.configId