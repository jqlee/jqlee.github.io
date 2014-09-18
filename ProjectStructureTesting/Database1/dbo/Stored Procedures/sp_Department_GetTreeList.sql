-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description: return columns:	MasterId, DepartmentId
-- =============================================
CREATE PROCEDURE [dbo].[sp_Department_GetTreeList]
	-- Add the parameters for the stored procedure here
	@memberId varchar(20)
AS
BEGIN
	SET NOCOUNT ON;

	select * from fnDepartmentTree(@memberId) order by [path]

END
