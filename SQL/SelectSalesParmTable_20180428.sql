declare @clearTime datetime 

--set @clearTime=GETDATE()--'2012-12-31'
set @clearTime='2012-1-1'

 select 'salesParmTable',* from   salesParmTable
            where salesParmTable.CreatedDateTime    <= @clearTime          
            and
			      salesParmTable.SALESID='SH11-00004'		and
                  salesParmTable.ParmJobStatus  in (0,1) --o means execute  1 means containe error


 select 'salesParmUpdate', *  from  salesParmUpdate  
        where not exists (select 1 from   salesParmTable
        where salesParmUpdate.ParmId = salesParmTable.ParmId 
          and salesParmUpdate.DATAAREAID = salesParmTable.DATAAREAID)
          and salesParmUpdate.CREATEDDATETIME<=@clearTime
        
 
 
   select 'salesParmSubTable', * from salesParmSubTable
        where not exists (select 1 from  salesParmTable
        where salesParmSubTable.ParmId      = salesParmTable.ParmId   and
              salesParmSubTable.TableRefId  = salesParmTable.TableRefId
			  and salesParmSubTable.DATAAREAID  = salesParmTable.DATAAREAID)
			  and  salesParmSubTable.CREATEDDATETIME<@clearTime

      select 'salesParmLine',* from salesParmLine
        where not exists (select 1 from  salesParmTable
        where salesParmLine.ParmId      = salesParmTable.ParmId   and
			  salesParmLine.DATAAREAID      = salesParmTable.DATAAREAID   and 
              salesParmLine.TableRefId  = salesParmTable.TableRefId)
          
			

  
  select 'salesParmSubLine', * from salesParmSubLine
    where not exists (select 1 from   salesParmLine
    where salesParmSubLine.LineRefRecId = salesParmLine.RecId
    and salesParmSubLine.DATAAREAID = salesParmLine.DATAAREAID)