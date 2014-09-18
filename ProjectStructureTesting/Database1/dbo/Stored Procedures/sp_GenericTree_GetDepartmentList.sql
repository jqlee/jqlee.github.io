-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GenericTree_GetDepartmentList]
	-- Add the parameters for the stored procedure here
	@memberId varchar(20) = null
	,@showAll bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
 
	select * from fnDepartmentTree(@memberId) 
	where 1 = case @showAll when 1 then 1 else HasRole end
	order by [Path],[Depth]

END
