select A.ITEMID, B.SUBTYPE from SUP_SampleApproveDetails  A

join InventTable B on B.DATAAREAID=A.DATAAREAID and B.ITEMID=A.ITEMID

where A.CUSTACCOUNT='' and A.DATAAREAID='001'

go

update SUP_SampleApproveDetails set CustAccount=b.SUBTYPE

from SUP_SampleApproveDetails  A

join InventTable B on B.DATAAREAID=A.DATAAREAID and B.ITEMID=A.ITEMID

where A.CUSTACCOUNT='' and A.DATAAREAID='001'