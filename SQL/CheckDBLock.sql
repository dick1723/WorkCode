SELECT TOP 10
 [session_id],
 [request_id],
 [start_time] AS '开始时间',
 [status] AS '状态',
 [command] AS '命令',
 dest.[text] AS 'sql语句', 
 DB_NAME([database_id]) AS '数据库名',
 [blocking_session_id] AS '正在阻塞其他会话的会话ID',
[wait_type] AS '等待资源类型',
[wait_time] AS '等待时间',
[wait_resource] AS '等待的资源',
 [reads] AS '物理读次数',
 [writes] AS '写次数',
 [logical_reads] AS '逻辑读次数',
 [row_count] AS '返回结果行数'
 FROM sys.[dm_exec_requests] AS der 
 CROSS APPLY 
 sys.[dm_exec_sql_text](der.[sql_handle]) AS dest 
 WHERE [session_id]>50 AND DB_NAME(der.[database_id])='SL2018'  
 
 --and [start_time]='2017/03/29 03:51:56 pm'
 ORDER BY [cpu_time] DESC
 
 go
 
 
 