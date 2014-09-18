
CREATE PROCEDURE [dbo].[sp_PublishSetting_Recycle]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	update  [dbo].[PublishSetting] 
	set [Enabled] = 0--,[IsPublished] = 0 
	,[RecycleDate] = getdate()
	where [Number] = @number
	--Delete FROM [dbo].[PublishSetting] where [Number] = @number
END