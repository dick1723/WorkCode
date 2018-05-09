SELECT 
  A.[DATAAREAID],
  A.CONFIGID as Color,
  A.INVENTSIZEID,
  A.INVENTLOCATIONID,
  A.ItemId,
  max(A.itemName) as itemName,--（Max）
  max(A.InventUnitId) as UnitId,--（Max）
  CONVERT (DECIMAL (18, 2),sum(A.AMOUNT/A.Qty*1.0)) as Price,--A.Price =AMOUNT(金额)/A.Qty(数量)
  max(B.CurrencyCode) CurrencyCode,--（Max）
  CONVERT (DECIMAL (18, 2),sum(A.less30)) as less30,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.less90)) as less90,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.less180)) as less180,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.less365)) as less365,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.More365)) as More365,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.Qty)) as TotalQty,---(sum)
  CONVERT (DECIMAL (18, 2),sum(A.AMOUNT)) as ReportAmount--(sum)
  FROM [dbo].[SUP_INVENTAGELINE] A
  join COMPANYINFO  B on B.DATAAREAID=A.dataareaId  
  cross apply (select top 1  * from   SUP_InventAgeReportJournal B where 
  B.DATAAREAID=A.DATAAREAID 
  and B.journalid=A.journalId and B.reportType=1) as Journal
     where A.DataAreaid=@companyId and (A.itemid=@itemId or @itemId='')
  and (A.itemgroupid=@itemgroupId or @itemgroupId='')
  Group by A.[DATAAREAID],
  A.ItemId,
  A.CONFIGID,
  A.INVENTSIZEID,
  A.INVENTLOCATIONID
  union
  SELECT 
  A.[DATAAREAID],
  A.INVENTCOLORID as Color,
  A.INVENTSIZEID,
  A.INVENTLOCATIONID,
  A.ItemId,
  max(A.itemName) as itemName,--（Max）
  max(A.InventUnitId) as UnitId,--（Max）
  CONVERT (DECIMAL (18, 2),sum(A.AMOUNT/A.Qty*1.0)) as Price,--A.Price =AMOUNT(金额)/A.Qty(数量)
  max(B.CurrencyCode) CurrencyCode,--（Max）
  CONVERT (DECIMAL (18, 2),sum(A.less30)) as less30,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.less90)) as less90,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.less180)) as less180,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.less365)) as less365,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.More365)) as More365,--(sum)
  CONVERT (DECIMAL (18, 2),sum(A.Qty)) as TotalQty,---(sum)
  CONVERT (DECIMAL (18, 2),sum(A.AMOUNT)) as ReportAmount--(sum)
  FROM [dbo].[SUP_INVENTAGELINE] A
  join COMPANYINFO  B on B.DATAAREAID=A.dataareaId  
  cross apply (select top 1  * from   SUP_InventAgeReportJournal B where 
  B.DATAAREAID=A.DATAAREAID 
  and B.journalid=A.journalId and B.reportType=1) as Journal
     where A.DataAreaid=@companyId and (A.itemid=@itemId or @itemId='')
  and (A.itemgroupid=@itemgroupId or @itemgroupId='')
  Group by A.[DATAAREAID],
  A.ItemId,
  A.INVENTCOLORID,
  A.INVENTSIZEID,
  A.INVENTLOCATIONID