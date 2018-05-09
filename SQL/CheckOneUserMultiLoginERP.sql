select id,name ,

(select count(1) from SysClientSessions A where A.clientType=0 and A.UserId!='Admin' and A.userId=Userinfo.id) as loginCount 
 from userinfo 

where id in 

(select A.userId from SysClientSessions  A  where A.clientType=0 and A.UserId!='Admin' group by A.userId
having count(1)>1)