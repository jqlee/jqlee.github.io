-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnRoleDepartment_ican5]
(	
	-- Add the parameters for the function here
	@memberId varchar(20)
)
RETURNS TABLE 
as
return(
	-- Add the SELECT statement with parameter references here
	SELECT x.man_no as MemberId, d.* -- x.man_no as ManagerId, x.coll_no as Id, d.Name, d.ShortName
	FROM  iCAN5.dbo.udf_GetPermCollsWithSAOOA(@memberId) x
	inner join v_Department d on d.Id = x.coll_no

)