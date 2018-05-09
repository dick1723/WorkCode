select   
A.DataAreaId,
B.InventSiteId,
C.IsOutgoing,
A.Reason,
A.CustAccount,
A.TEC_OrderStyle,
A.SALESID,
C.EnglishName,
isnull((select sum(AvailPhysical) from inventSum sum1

join inventDim  B1	on B1.dataareaid=sum1.dataareaid and B1.inventDimId=sum1.inventDimId 
join InventLocation C on C.dataareaid=B1.dataareaid and C.InventLocationId=B1.InventLocationId and C.SUP_RTInventOnHand=1

where sum1.itemId=A.itemid and B.configId=b1.configId and  B.inventsiteId=b1.InventSiteid),0) as RTOnhand,--SUP_RTInventQtyOnHand
--(select sum(ReservPhysical) from inventSum sum1
--join inventDim  B1	on B1.dataareaid=sum1.dataareaid and B1.inventDimId=sum1.inventDimId 
--where sum1.itemId=A.itemid and b1.configId=B.configId and  b1.inventsiteId=b.InventSiteid) as RTResver, --SUP_RTInventReservPhysical
isnull((select sum(SalesQty_inventory) from SUP_InventoryOrderList list where list.dataareaid=A.dataareaid and list.inventtransId=A.InventTransId),0) as InventoryOrderQty,
 A.ItemId,
 A.InventtransId,
 C.ItemName,
 A.TEC_SalesType,
 B.CONFIGID,
 A.SALESQTY,
 A.PRODID,
 dbo.F_SalesDeliveredInTotal(A.DATAAREAID,A.INVENTTRANSID) as DeliveryTotal,
 A.REMAINSALESPHYSICAL,
 A.CREATEDDATETIME,
 A.ShippingDateConfirmed,
 A.CONFIRMEDDLV,
 dbo.F_SalesReservedOnOrderNotOutSource(A.DATAAREAID,A.INVENTTRANSID,1) as reservedOnOrderOutSource,
 dbo.F_SalesReservedOnOrderNotOutSource(A.DATAAREAID,A.INVENTTRANSID,0) as reservedOnOrderNoOutSource,
 --SalesLine.reservedOnOrderOutSource()
 --SalesLine.reservedOnOrderNotOutSource()
 A.Tec_CollectionYN,
 --A.SalesLine.SUP_deliveryAddress()
 case A.DeliveryAddress
 when '' then (select DeliveryAddress from SALESTABLE T where T.dataareaid=A.Dataareaid and T.salesId=A.salesId) 
 
 else A.DeliveryAddress  end as DeliveryAddress,
 B.inventlocationid,
 B.INVENTBATCHID,
 A.ProdGroupId
 from salesline A  
 join InventDim B on   B.dataareaid=A.dataareaid and B.InventDimId=A.inventdimId
 
 join InventTable C on  C.dataareaid=A.dataareaid and C.itemid=A.itemid
 
 where a.dataareaid='101'
 and A.salesqty!=0 and A.salesstatus=1  

--and SALESID='A1-201710/01776'