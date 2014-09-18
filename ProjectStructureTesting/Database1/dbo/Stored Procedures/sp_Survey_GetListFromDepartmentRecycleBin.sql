-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Survey_GetListFromDepartmentRecycleBin]
	-- Add the parameters for the stored procedure here
	@managerId varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT s.* 
	from [Survey] s
	--inner join v_Member m on m.Id = s.[Owner]
	where s.[Visible] = 0 and s.[Owner] = @managerId
	order by s.[LastModified] desc
END
