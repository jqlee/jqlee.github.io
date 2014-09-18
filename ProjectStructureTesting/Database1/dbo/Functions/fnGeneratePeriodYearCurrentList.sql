-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnGeneratePeriodYearCurrentList
(	
	-- Add the parameters for the function here

)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
		select Convert(varchar,[DisplayYear]) as [Value]
				, Convert(varchar,[DisplayYear]) as [Text]
					from fnGeneratePeriodYearList_ican5(-10,10)
)
