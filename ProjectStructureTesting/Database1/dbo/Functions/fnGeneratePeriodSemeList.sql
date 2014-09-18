CREATE FUNCTION [dbo].[fnGeneratePeriodSemeList]
(	
	@schoolId varchar(6)
)
RETURNS @t Table ([Value] varchar(20), [Text] nvarchar(50))
begin

	insert into @t
	select a.para_phsiname as [Value]
			, a.para_dispname as [Text]
			from fn_GetiCanPara(@schoolId,'p_seme') a
	return;
end
