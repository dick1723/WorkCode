select top 100  SumMarkup ,
A.SALESID,
A.DATAAREAID,
A.*  from CUSTINVOICEJOUR A where  A.SUMMARKUP!=0  and A.DATAAREAID='101'  order by a.CREATEDDATETIME desc

go

select * from ACCESSRIGHTSLIST  A

join USERGROUPLIST B on B.GROUPID=A.GROUPID


where DOMAINID='SPAC'  and B.USERID='suzha' and ID in (36,31)