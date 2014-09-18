-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnGeneratePeriodList
(	
	-- Add the parameters for the function here
	@init int = -5
	,@count int = 11
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select * from dbo.fnGeneratePeriodList_ican5(@init, @count)
)
