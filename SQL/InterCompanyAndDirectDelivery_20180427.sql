select 
P101.DATAAREAID,
P101.PURCHID,
P101.SALESID,
P101.ITEMID,
P101.INVENTTRANSID,
P101.INTERCOMPANYINVENTTRANSID,
P101.INTERCOMPANYORIGIN,
S001.DATAAREAID,
S001.SALESID,
S001.ITEMID,
S001.INVENTTRANSID,
S001.INTERCOMPANYINVENTTRANSID,
P001.DATAAREAID,
P001.PURCHID,
P001.ITEMID,
P001.INVENTTRANSID,
P001.INTERCOMPANYINVENTTRANSID,
S301.DATAAREAID,
S301.SALESID,
S301.ITEMID,
S301.INVENTTRANSID
from PURCHLINE P101

left join SALESLINE S001 on S001.INTERCOMPANYINVENTTRANSID=P101.INVENTTRANSID 

left join PURCHLINE P001 on P001.INVENTREFTRANSID         =S001.INVENTTRANSID 
--and P001.DATAAREAID=S001.DATAAREAID

left join SALESLINE S301 on S301.INVENTTRANSID			 =P001.INTERCOMPANYINVENTTRANSID


where P101.PURCHID='D-201804/00006'