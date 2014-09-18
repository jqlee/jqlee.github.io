-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 可以直接把sce版或std版的內容貼進來
-- =============================================
CREATE FUNCTION [dbo].[fnListGrade]
(	
	
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT Convert(int,[Value]) as [Value],[Name] from fnListGrade_ican5()
)
