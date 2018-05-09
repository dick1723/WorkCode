
update SUP_VendApproveEmailLine set EMAIL ='mlui@superl.com.cn'   where EMAIL='Fdeng@superl.com.cn' and DATAAREAID='001'

and recid in  

(select A.RECID from SUP_VendApproveEmailLine A where A.EMAIL='Fdeng@superl.com.cn' and DATAAREAID='001'

and not exists (select 1   from  SUP_VendApproveEmailLine AA where AA.DATAAREAID=A.DATAAREAID 
and AA.VENDAPPROVEEMAILTABLE=A.VENDAPPROVEEMAILTABLE and AA.EMAIL='mlui@superl.com.cn'))