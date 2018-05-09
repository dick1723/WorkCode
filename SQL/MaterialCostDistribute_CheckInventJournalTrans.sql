
 
 select A.dataareaid,A.itemid ,B.Dimension,(A.CostAmountPosted + A.CostAmountAdjustment) as CostValue from inventtrans A join InventJournalTrans B on B.dataareaid=A.dataareaid
 
 and B.inventtransid=A.inventtransid 
 
 join InventJournalName  C on C.dataareaid=A.dataareaid and C.JournalNameId=A.JournalNameId
 and C.SUP_CostDistribute=1
 
 where A.dataareaid='101' and (A.DateFinancial<='2018-2-28' and A.DateFinancial>='2018-2-01')