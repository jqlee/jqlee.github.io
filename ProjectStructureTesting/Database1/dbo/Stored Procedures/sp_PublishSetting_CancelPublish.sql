
Create PROCEDURE [dbo].[sp_PublishSetting_CancelPublish]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	--Delete FROM [dbo].[PublishSetting] where [Number] = @number
	Update [dbo].[PublishSetting] set [IsPublished] = 0 where [Number] = @number
END