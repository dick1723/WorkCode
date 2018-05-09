select * from SUP_VendApproveEmailLine A

where not exists (select 1 from SUP_VendApproveEmailTable B where b.DATAAREAID=A.DATAAREAID and 
b.RECID=A.VENDAPPROVEEMAILTABLE)

go


select * from SUP_VendApproveEmailLine A
left join  SUP_VendApproveEmailTable B on  b.DATAAREAID=A.DATAAREAID and 
b.RECID=A.VENDAPPROVEEMAILTABLE

where B.RECID is null 

go

delete from SUP_VendApproveEmailLine

where not exists (select 1 from SUP_VendApproveEmailTable B where b.DATAAREAID=SUP_VendApproveEmailLine.DATAAREAID and 
b.RECID=SUP_VendApproveEmailLine.VENDAPPROVEEMAILTABLE)