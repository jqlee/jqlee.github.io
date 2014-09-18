-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description: return columns:	MasterId, DepartmentId
-- =============================================
CREATE PROCEDURE [dbo].[sp_Department_GetListByManager]
	-- Add the parameters for the stored procedure here
	@managerId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from dbo.fnRoleDepartment(@managerId);

END
