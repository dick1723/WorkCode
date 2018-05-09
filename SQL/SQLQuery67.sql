select top 100   
A.DATAAREAID,
A.PURCHID,
A.ITEMID,
isnull(s.ITEMID,'') as FGCode,
--todo 
siteT.NAME as SiteName,
c.INVENTCOLORID,
--todo CDHs
[dbo].[F_GetCDfindByItemIdCountry](A.DATAAREAID,A.ItemID,1) as CDDes,
A.SUP_DELAYREASON,
A.SUP_POSTDATE,
A.TEC_LEAVEFACTORYDATE,
--CASE WHEN A.DELIVERYDATE= '1900-01-01 00:00:00.000' THEN ''
--ELSE CONVERT (VARCHAR (100), A.DELIVERYDATE, 23) END AS DELIVERYDATE,

--CASE WHEN A.SUP_RequireDelivery= '1900-01-01 00:00:00.000' THEN ''
--ELSE CONVERT (VARCHAR (100), A.SUP_RequireDelivery, 23) END AS SUP_RequireDelivery,


--CASE WHEN A.TEC_FIRSTCONFIRMATIONDATE= '1900-01-01 00:00:00.000' THEN ''
--ELSE CONVERT (VARCHAR (100), A.TEC_FIRSTCONFIRMATIONDATE, 23) END AS TEC_FIRSTCONFIRMATIONDATE,

--CASE WHEN A.CONFIRMEDDLV= '1900-01-01 00:00:00.000' THEN ''
--ELSE CONVERT (VARCHAR (100), A.CONFIRMEDDLV, 23) END AS CONFIRMEDDLV, 

--CASE WHEN convert(date,dateadd(HH,8,A.MODIFIEDDATETIME))='1900-01-01 00:00:00.000' then ''
--ELSE CONVERT (VARCHAR (100), convert(date,dateadd(HH,8,A.MODIFIEDDATETIME)), 23) END AS ModifiedDate,

--CONVERT (DECIMAL (18, 4),A.PURCHQTY) as PURCHQTY,
--[dbo].[F_PurchLineDeliveredInTotal](A.DATAAREAID,A.INVENTTRANSID) as ReceiveTotal,
dbo.[F_PurchLinePackingSlip](A.DATAAREAID,A.INVENTTRANSID) as ReceiveTotal,
[dbo].[F_PurchLineInvoiceTotal](A.DATAAREAID,A.INVENTTRANSID) as InvoiceTotal,
--//到货数量=检验数量-欠料数
--CONVERT (DECIMAL (18, 4),(A.QM_INSPQTYPURCH-A.THK_SHORTAGEQTY)) as ReceiveNowIQC,
CASE 
when A.purchqty <0  then CONVERT (DECIMAL (18, 4),A.PURCHQTY)
else 0 end  as  ReturnNow,
--//剩余交货数量....检验数
isnull((select SUM(CONVERT (DECIMAL (18, 4),RemainPurchQty)) from QM_INSPORDERTABLE Q where Q.DATAAREAID=A.DATAAREAID 
and Q.INVENTTRANSID=A.INVENTTRANSID),0) as RemianPurchQytQM, --//到货未入库数量
dbo.F_PendingQtyPurch(A.DATAAREAID,A.INVENTTRANSID) as PendingQtyPurch,
C.INVENTSIZEID,
C.CONFIGID
from PURCHLINE A

--join PURCHTABLE B on B.DATAAREAID=A.DATAAREAID and B.PURCHID=A.PURCHID

join INVENTDIM  c on C.DATAAREAID=A.DATAAREAID and C.INVENTDIMID=A.INVENTDIMID

--join INVENTTABLE d on D.DATAAREAID=A.DATAAREAID and D.ITEMID=A.ITEMID

--join INVENTCOLOR E on E.DATAAREAID=A.DATAAREAID and E.INVENTCOLORID=C.INVENTCOLORID and E.ITEMID=A.ITEMID

join INVENTSITE  siteT on siteT.DATAAREAID=A.DATAAREAID and siteT.SITEID=C.INVENTSITEID 

left join salesLine s on s.DATAAREAID=A.DATAAREAID and s.INVENTTRANSID=A.TEC_SALESINVENTTRANSID --get  the 