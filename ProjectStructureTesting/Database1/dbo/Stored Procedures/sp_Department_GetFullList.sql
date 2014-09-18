-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description: return columns:	MasterId, DepartmentId
-- =============================================
CREATE PROCEDURE [dbo].[sp_Department_GetFullList]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT d.* -- x.man_no as ManagerId, x.coll_no as Id, d.Name, d.ShortName
	FROM v_Department d 

END
