select ScrapVar,round(ScrapVar*1.1158,2) from BOM where DATAAREAID='101' and ITEMID='MZ0012'

go

update  BOM set ScrapVar=round(ScrapVar*1.1158,2) where DATAAREAID='101' and ITEMID='MZ0012'

go

update  PRODBOM set ScrapVar=round(A.ScrapVar*1.1158,2) 

from PRODBOM A join PRODTABLE B on B.DATAAREAID=A.DATAAREAID and B.PRODID=A.PRODID

where B.PRODSTATUS<=4 and  A.DATAAREAID='101' and A.ITEMID='MZ0012'