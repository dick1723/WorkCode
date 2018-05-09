select count(1) from purchParmUpdate
        where not exists (select 1 from   purchParmTable
        where purchParmUpdate.ParmId = purchParmTable.ParmId 
          and purchParmUpdate.DATAAREAID = purchParmTable.DATAAREAID);
          
select count(1) from  purchParmSubTable
        where not exists (select 1 from  purchParmTable
        where purchParmSubTable.ParmId      = purchParmTable.ParmId   and
              purchParmSubTable.TableRefId  = purchParmTable.TableRefId
			  and purchParmSubTable.DATAAREAID  = purchParmTable.DATAAREAID)

   select count(1) from purchParmLine
        where not exists (select 1 from  purchParmTable
        where purchParmLine.ParmId      = purchParmTable.ParmId   and
			  purchParmLine.DATAAREAID      = purchParmTable.DATAAREAID   and 
              purchParmLine.TableRefId  = purchParmTable.TableRefId);


  
 select count(1) from purchParmSubLine
    where not exists (select 1 from   purchParmLine
    where purchParmSubLine.LineRefRecId = purchParmLine.RecId
    and purchParmSubLine.DATAAREAID = purchParmLine.DATAAREAID);