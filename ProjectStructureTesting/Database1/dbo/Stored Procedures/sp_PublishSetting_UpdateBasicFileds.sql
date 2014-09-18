-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_PublishSetting_UpdateBasicFileds
	-- Add the parameters for the stored procedure here
	@guid uniqueidentifier = null
	,@name nvarchar(50) = null
	,@description nvarchar(200) = null
	,@doneMessage nvarchar(200) = null
	,@openDate datetime = null
	,@closeDate datetime = null
	,@queryDate datetime = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update [dbo].[PublishSetting] set 
			[Name] = isNull(@name, [Name]), 
			[Description] = isNull(@description, [Description]), 
			[DoneMessage] = isNull(@doneMessage, [DoneMessage]), 
			[OpenDate] = isNull(@openDate, [OpenDate]), 
			[CloseDate] = isNull(@closeDate, [CloseDate]), 
			[QueryDate] = isNull(@queryDate, [QueryDate]), 
			[LastModified] = getdate()
		where [Guid] = @guid
END
