declare @dataareaId	nvarchar(4)
declare	@ItemId		nvarchar(20)
declare	@ConfigId		nvarchar(20)	


declare @priceCalcId nvarchar(20)	

set @dataareaId='005'
set @ItemId=''
set @ConfigId=''
	select top 1 @priceCalcId=PriceCalcId from BOMCalcTable A 

	join INVENTDIM  B on B.DATAAREAID=A.DATAAREAID and B.INVENTDIMID=A.INVENTDIMID

	where A.DATAAREAID='005' and A.BOMCALCACTIVE=1 and A.ITEMID=@itemId and B.CONFIGID=@Configid order by A.RECID desc 

	if(@priceCalcId is null)
	begin 
	select top 1 @priceCalcId=PriceCalcId from BOMCalcTable A 

	where A.DATAAREAID='005' and A.ITEMID=@itemId  and A.BOMCALCACTIVE=1 order by A.RECID desc 

	end 	
	
select @priceCalcId