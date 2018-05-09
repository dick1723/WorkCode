select A.* from TK01.TK01.TK.SUP_ProdIQCResult A

join QM_InspOrderLine_Produ  B on B.RECID=A.recid

join TmpImport  C on C.dataareaid=B.DATAAREAID and c.inspid=B.INSPID

go

update TK01.TK01.TK.SUP_ProdIQCResult set inspdate=B.INSPDATE

from TK01.TK01.TK.SUP_ProdIQCResult A

join QM_InspOrderLine_Produ  B on B.RECID=A.RECID

join TmpImport  C on C.dataareaid=B.DATAAREAID and c.inspid=B.INSPID