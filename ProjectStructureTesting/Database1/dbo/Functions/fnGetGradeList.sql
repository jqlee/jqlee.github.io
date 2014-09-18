-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 可以直接把sce版或std版的內容貼進來
-- =============================================
CREATE FUNCTION [dbo].[fnGetGradeList]
(	
	
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * from fnGetGradeList_ican5()
)
