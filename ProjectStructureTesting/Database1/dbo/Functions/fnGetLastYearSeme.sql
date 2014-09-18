-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetLastYearSeme]
(	
	-- Add the parameters for the function here
	@displayCount int = 5
)
RETURNS @t Table ([Idx] int identity(1,1), [Year] smallint,[Seme] tinyint)
begin
	-- Add the SELECT statement with parameter references here

	declare @currentYear smallint
	declare @currentSeme tinyint
	--declare @displayCount int = 5
	declare @i int = 0

	declare @semeCount int = 2;

	select @semeCount = count(*) from v_Seme

	--select * from dbo.v_CurrentYearSeme

	SELECT @currentYear = Convert(smallint,[CurrentYear])
	, @currentSeme = convert(tinyint, [CurrentSeme])
	FROM   v_CurrentYearSeme

	declare @semeIndex int = (@currentSeme-1)%3

	while (@i < @displayCount)
	begin
	
		insert into @t ([Year],[Seme]) values (@currentYear, (@semeIndex+1))
		--select @currentYear, (@semeIndex+1)
		if (@semeIndex = 0)
			begin
				set @currentYear = @currentYear - 1
			end
		set @semeIndex = ((( @semeIndex - 1)+@semeCount) % @semeCount)
		set @i = @i + 1;
	end

	return

end
