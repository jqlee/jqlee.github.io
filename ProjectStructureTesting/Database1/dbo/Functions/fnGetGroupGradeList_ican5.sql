-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetGroupGradeList_ican5]
(	
	-- Add the parameters for the function here

)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	
	select convert(varchar,para_phsiname) as [Value], para_dispname as [Text], para_no as [SortOrder]
	from ican5.dbo.ican_para where para_code = 'p_grade'

	/*
	SELECT convert(varchar,cour_grade) as [Value] 
	, convert(varchar,cour_grade) as [Text] 
	FROM ICAN5.dbo.course 
	where cour_grade is not null
	group by cour_grade 
	*/
)
