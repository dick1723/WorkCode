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

--PO�д�������(��ʼ&����)---A.CreateDate	

--ii.�ɹ�������A.purchid
--iii.��Ӧ�̱�ţ�A.vendAccount
--iv.�ɹ�Ա�飬A.itembuyergroupid
--v.�����ˣ�A.purchplacer
--vi.���ϱ�ţ� A.itemId
	

SELECT 
A.[DATAAREAID]
,min([CREATEDDATE]) as '��������'
,max([TEC_ORDERMONTH]) as '�����·�'
,A.[PURCHID] as '������'
,max(A.[PURCHNAME]) as '��Ӧ�̼��'
,max(A.[ItemBuyerGroupId]) as ItemBuyGroupId
,max([SUP_INTERCOMPANYPURCHITEMID]) as  '�ڲ���˾���ϱ���'
,max([ExternalCode]) as '�ⲿ���'
,A.itemid as '�������'
,max([FGCode]) as  '��Ʒ����'
,max([itemName]) as '�������'
,max([NAMEALIAS]) as 'Ӣ������'
,max([SiteName]) as 'վ��'
,A.[INVENTCOLORID]
,MAX(A.colorNameCN) as ColorNamCN
,MAX(A.ColorNameEN) as ColorNameEN
,max([SUP_REFERENCE]) as Refrence
,max([PURCHUNIT]) as '��������λ'
,sum([PURCHQTY]) as '����'
,sum([ReceiveTotal]) as '�ۼ�������'

,sum([InvoiceTotal]) as '�ۼƷ�Ʊ����'

,sum([ReceiveNowIQC]) as '��������'

,sum([ReturnNow]) as '�˻�����'

,sum([REMAINPURCHPHYSICAL]-[RemianPurchQytQM]) as 'δ��������'

,sum([REMAINPURCHPHYSICAL]) as 'ʣ�ཻ����'

,sum([RemianPurchQytQM]) as '����δ���'

,sum([OweQty])  as 'Ƿ����'

--//PO��������(PurchQty -�ۼ�������)
, Sum(PurchQty-[ReceiveTotal]) as 'PO��������'
, 
max(A.DeliveryDate) as '�ƻ���������',

max(A.SUP_RequireDelivery) as  'Ҫ�󵽻�����',--todo
max(salesid) as '���۶�����',
max(custAccount) as '�ͻ�����'
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