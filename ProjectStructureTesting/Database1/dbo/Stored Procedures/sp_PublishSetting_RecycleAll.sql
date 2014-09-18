
CREATE PROCEDURE [dbo].[sp_PublishSetting_RecycleAll]
	@guidList nvarchar(max) -- 10,20,30
AS
BEGIN
	SET NOCOUNT ON;
	update [dbo].[PublishSetting] 
	set [Enabled] = 0 --,[IsPublished] = 0 
	,[RecycleDate] = getdate()
	where [Guid] in (select Convert(uniqueidentifier,[Value]) as [Guid] from dbo.fnsplit(@guidList,','))
	--Delete FROM [dbo].[PublishSetting] where [Number] = @number
END
