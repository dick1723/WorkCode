select 
A.DATAAREAID,
A.BOMID, 
A.itemid,
A.ScrapVar,
A.RECID,
B.ITEMID as FGItemId from BOM A 
join BOMVERSION  B on B.DATAAREAID=A.DATAAREAID and B.BOMID=A.BOMID
where A.DATAAREAID='101'
and   A.ITEMID='MZ0012'  
and   B.ACTIVE=1 
--and   A.SCRAPVAR=19.8 
--order by A.SCRAPVAR  desc

go

select A.PRODID,A.DATAAREAID,A.ITEMID,A.SCRAPVAR ,A.RemainBOMPhysical,A.RECID
from PRODBOM A 
join PRODTABLE  B on B.DATAAREAID=A.DATAAREAID and B.PRODID=A.PRODID
where A.DATAAREAID='101'

and A.ITEMID='MZ0012'  
and A.RemainBOMFinancial=0 
and B.PRODSTATUS<5 
and A.RemainBOMPhysical>0
--and A.SCRAPVAR=19.8
order by A.SCRAPVAR  desc 

go

update BOM set ScrapVar= 15.8

from BOM A 
join BOMVERSION  B on B.DATAAREAID=A.DATAAREAID and B.BOMID=A.BOMID
where A.DATAAREAID='101'
and A.ITEMID='MZ0012'  
and B.ACTIVE=1  
--and A.SCRAPVAR=19.8


update PRODBOM set SCRAPVAR=15.8 
from PRODBOM A 
join PRODTABLE  B on B.DATAAREAID=A.DATAAREAID and B.PRODID=A.PRODID
where A.DATAAREAID='101'

and A.ITEMID='MZ0012'  
and A.RemainBOMFinancial=0 
and B.PRODSTATUS<5 
and A.RemainBOMPhysical>0
--and A.SCRAPVAR=19.8
