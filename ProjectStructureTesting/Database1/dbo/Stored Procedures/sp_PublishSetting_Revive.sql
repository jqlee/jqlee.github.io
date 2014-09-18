
CREATE PROCEDURE [dbo].[sp_PublishSetting_Revive]
	@guid uniqueidentifier = null
AS
BEGIN
	SET NOCOUNT ON;

	--Delete FROM [dbo].[PublishSetting] where [Number] = @number
	Update [dbo].[PublishSetting] set [Enabled] = 1,[RecycleDate] = null where [Guid] = @guid
END