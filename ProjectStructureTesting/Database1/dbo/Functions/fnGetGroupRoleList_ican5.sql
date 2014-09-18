-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnGetGroupRoleList_ican5
(	
	-- Add the parameters for the function here
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select para_phsiname as [Value], para_dispname as [Text]
	from ican5.dbo.ican_para where para_code = 'P_ManScore'

)
