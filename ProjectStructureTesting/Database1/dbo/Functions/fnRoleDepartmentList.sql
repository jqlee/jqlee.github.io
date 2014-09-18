-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION fnRoleDepartmentList
(	
	-- Add the parameters for the function here
	@memberId varchar(20)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here


	select * from ican5.dbo.udf_GetPermCollsWithSAOOA(@memberId)
	--select * from ican5.dbo.udf_GetPermCollsWithSAOOA('yechen')
	--select * from ican5_std.dbo.udf_GetPermCollsWithSAOOA('demoadmin')

)
