
delete  from TEC_ProdEfficiencyJournalLine  where 

not exists (select 1 from TEC_ProdEfficiencyJournalTable where TEC_ProdEfficiencyJournalTable.JOURNALID=TEC_ProdEfficiencyJournalLine.JOURNALID)

delete  from SUP_ProdEfficiencyTransWeek where 

not exists (select 1 from TEC_ProdEfficiencyJournalTable where TEC_ProdEfficiencyJournalTable.JOURNALID=SUP_ProdEfficiencyTransWeek.JOURNALID)

delete  from SUP_ProdEfficiencyTrans  where 

not exists (select 1 from TEC_ProdEfficiencyJournalTable where TEC_ProdEfficiencyJournalTable.JOURNALID=SUP_ProdEfficiencyTrans.JOURNALID)


delete  from SUP_ProdEffInquiryTotal  where 

not exists (select 1 from TEC_ProdEfficiencyJournalTable where TEC_ProdEfficiencyJournalTable.JOURNALID=SUP_ProdEffInquiryTotal.JOURNALID)

delete  from SUP_PRODEFFICIENCYINQUIRY31235 where 

not exists (select 1 from TEC_ProdEfficiencyJournalTable where TEC_ProdEfficiencyJournalTable.JOURNALID=SUP_PRODEFFICIENCYINQUIRY31235.JOURNALID)