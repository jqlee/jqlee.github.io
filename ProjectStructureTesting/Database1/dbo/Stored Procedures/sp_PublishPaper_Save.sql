
CREATE PROCEDURE [dbo].[sp_PublishPaper_Save]
	@number int
	,@title nvarchar(100) = null
	,@description nvarchar(MAX) = null
	,@publishNumber int = null
	,@copySource int = null
	,@guid uniqueidentifier = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[PublishPaper] where [Number] = @number ))
	begin
		
		Update [dbo].[PublishPaper] set 
			[Title] = isNull(@title, [Title]), 
			[Description] = isNull(@description, [Description]), 
			[PublishNumber] = isNull(@publishNumber, [PublishNumber]), 
			[CopySource] = isNull(@copySource, [CopySource]), 
			[Guid] = isNull(@guid, [Guid])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[PublishPaper] (
			[Title], 
			[Description], 
			[Created], 
			[PublishNumber], 
			[CopySource], 
			[Guid]
		) values (
			 @title, 
			 @description, 
			 getdate(), 
			 @publishNumber, 
			 @copySource, 
			 @guid
		)

	end
END

