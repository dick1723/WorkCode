select * from  PURCHLINE A 

where A.DATAAREAID in ('001','321','301','501')

and A.CUSTACCOUNT in ('KS','KO','SH-KO','SH-KS')
and datepart(YY,DATEADD(HH,8,A.CREATEDDATETIME))='2018'