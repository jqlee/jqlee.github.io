CREATE FUNCTION [dbo].[fnGeneratePeriodYearList]
(	
	-- Add the parameters for the function here
	@schoolId varchar(6)
)
RETURNS @t Table ([Idx] int identity(1,1), [Value] nvarchar(50), [Text] nvarchar(50))
begin
	-- Add the SELECT statement with parameter references here
	declare @yearStart smallint = 100
	declare @yearCount int = 2
	--select @yearStart = Convert(smallint,[Text]) from fn_GetiCanPara(@schoolId, 'p_startyear') where Category = 
	--select @yearCount = Convert(tinyint,[Text]) from v_YearSemePara where Category = 'p_expansionyear'
	select @yearStart = Convert(smallint,[para_dispname])  from fn_GetiCanPara(@schoolId, 'p_startyear')
	select @yearCount = Convert(tinyint,[para_dispname]) from fn_GetiCanPara(@schoolId, 'p_expansionyear')

	declare @i int = 0, @current int = 0;
	while (@i<@yearCount)
	begin
		set @current = @i + @yearStart;
		insert into @t ([Value],[Text]) 
		select convert(varchar,@current) as [Value],  convert(varchar,@current) as [Text]
		set @i = @i + 1;

	end
	return;
end

/*
	select * from fnGeneratePeriodYearList()
	select Convert(smallint,[Text]) from v_YearSemePara where Category = 'p_startyear'
	select Convert(tinyint,[Text]) from v_YearSemePara where Category = 'p_expansionyear'
*/