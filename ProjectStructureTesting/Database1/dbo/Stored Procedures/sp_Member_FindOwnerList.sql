-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Member_FindOwnerList
	-- Add the parameters for the stored procedure here
	@keyword nvarchar(20) = null
	,@surveyId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT m.* 
	from v_Member m
	left outer join Survey s on s.[Owner] = m.Id and s.[Guid] = @surveyId
	where m.BasicRoleValue >= 20 and m.[Enabled] = 1 and s.Number is null
		and (m.Name like '%'+@keyword+'%' or m.Id like '%'+@keyword+'%')
END
