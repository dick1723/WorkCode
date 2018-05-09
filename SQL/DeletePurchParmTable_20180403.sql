declare @clearTime datetime 

--set @clearTime=GETDATE()--'2012-12-31'
set @clearTime='2017-1-1'

delete from   purchParmTable
            where purchParmTable.CreatedDateTime    <= @clearTime          
            --and
			      --PURCHPARMTABLE.PURCHID='L-201110/01100'		and
                  --purchParmTable.ParmJobStatus  in (0,1) --o means execute  1 means containe error


 Delete from  purchParmUpdate
        where not exists (select 1 from   purchParmTable
        where purchParmUpdate.ParmId = purchParmTable.ParmId 
          and purchParmUpdate.DATAAREAID = purchParmTable.DATAAREAID);
        
 
 
  Delete from purchParmSubTable
        where not exists (select 1 from  purchParmTable
        where purchParmSubTable.ParmId      = purchParmTable.ParmId   and
              purchParmSubTable.TableRefId  = purchParmTable.TableRefId
			  and purchParmSubTable.DATAAREAID  = purchParmTable.DATAAREAID)

     Delete from purchParmLine
        where not exists (select 1 from  purchParmTable
        where purchParmLine.ParmId      = purchParmTable.ParmId   and
			  purchParmLine.DATAAREAID      = purchParmTable.DATAAREAID   and 
              purchParmLine.TableRefId  = purchParmTable.TableRefId);


  
 Delete from purchParmSubLine
    where not exists (select 1 from   purchParmLine
    where purchParmSubLine.LineRefRecId = purchParmLine.RecId
    and purchParmSubLine.DATAAREAID = purchParmLine.DATAAREAID);