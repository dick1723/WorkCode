select * from SUP_PackoneSetup where dataareaid='601'

go

select  dbname from SUP_PackOneJournal where SUP_PackOneJournal.companyId='611' group by dbname


select A.DBNAME from  SUP_PackOneLine A join 
(
select SUP_PackOneType,SUP_BuyerCode,SUP_FactoryId,SUP_SsccNumber,SUP_ItemId from SUP_PackOneLine where SUP_PackOneLine.companyId='601'

group by SUP_PackOneType,SUP_BuyerCode,SUP_FactoryId,SUP_SsccNumber,SUP_ItemId having count(1)>1) as B

on B.SUP_PackOneType=A.SUP_PackOneType and B.SUP_BuyerCode=A.SUP_BuyerCode and 
B.SUP_FactoryId=A.SUP_FactoryId and B.SUP_SsccNumber=A.SUP_SsccNumber and B.SUP_ItemId=A.SUP_ItemId

go
--PackOneSuperL
update  SUP_PackOneJournal set  dbname='PackOneSiglo'  where SUP_PackOneJournal.companyId='611'
update  SUP_PackOneLine set  dbname='PackOneSuperL'  where SUP_PackOneLine.companyId='601'

and SUP_SSCCNUMBER not in ('00000010600100091051','00002319180000288420','00000010600100091044')



