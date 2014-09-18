-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_RoleFunction_GetList]
	-- Add the parameters for the stored procedure here
	@functionCode varchar(16) = null
	,@roleCode varchar(6) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select * from (
	select POWER(2,ROW_NUMBER() over (order by RoleCode)-1) as BitKey,* 
	from v_RoleFunction 
	where FunctionCode = isNull(@functionCode,FunctionCode)
	and RoleCode = isNull(@roleCode,RoleCode)
) x	


END
