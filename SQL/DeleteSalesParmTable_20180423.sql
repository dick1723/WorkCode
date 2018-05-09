declare @clearTime datetime 

--set @clearTime=GETDATE()--'2012-12-31'
set @clearTime='2012-1-1'

delete from   salesParmTable
            where salesParmTable.CreatedDateTime    <= @clearTime          
            and
			      salesParmTable.SALESID='SH11-00004'		and
                  salesParmTable.ParmJobStatus  in (0,1) --o means execute  1 means containe error


 Delete from  salesParmUpdate
        where not exists (select 1 from   salesParmTable
        where salesParmUpdate.ParmId = salesParmTable.ParmId 
          and salesParmUpdate.DATAAREAID = salesParmTable.DATAAREAID)
          
          and salesParmUpdate.CREATEDDATETIME<=@clearTime
        
 
 
  Delete from salesParmSubTable
        where not exists (select 1 from  salesParmTable
        where salesParmSubTable.ParmId      = salesParmTable.ParmId   and
              salesParmSubTable.TableRefId  = salesParmTable.TableRefId
			  and salesParmSubTable.DATAAREAID  = salesParmTable.DATAAREAID)
			  and SALESPARMSUBTABLE.CREATEDDATETIME<@clearTime
  
  Delete from salesParmLine
        where not exists (select 1 from  salesParmTable
        where salesParmLine.ParmId      = salesParmTable.ParmId   and
			  salesParmLine.DATAAREAID      = salesParmTable.DATAAREAID   and 
              salesParmLine.TableRefId  = salesParmTable.TableRefId)


  
 Delete from salesParmSubLine
    where not exists (select 1 from   SALESPARMLINE
    where salesParmSubLine.LineRefRecId = SALESPARMLINE.RecId
    and salesParmSubLine.DATAAREAID = SALESPARMLINE.DATAAREAID);