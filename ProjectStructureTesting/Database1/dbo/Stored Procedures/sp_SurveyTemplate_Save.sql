
CREATE PROCEDURE [dbo].[sp_SurveyTemplate_Save]
	@number int
	,@title nvarchar(100) = null
	,@description nvarchar(MAX) = null
	,@enabled bit = null
	,@creator varchar(20) = null
	,@guid uniqueidentifier = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[SurveyTemplate] where [Number] = @number ))
	begin
		
		Update [dbo].[SurveyTemplate] set 
			[Title] = isNull(@title, [Title]), 
			[Description] = isNull(@description, [Description]), 
			[Enabled] = isNull(@enabled, [Enabled]), 
			[Creator] = isNull(@creator, [Creator]), 
			[LastModified] = getdate(), 
			[Guid] = isNull(@guid, [Guid])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[SurveyTemplate] (
			[Title], 
			[Description], 
			[Enabled], 
			[Creator], 
			[Created], 
			[Guid]
		) values (
			 @title, 
			 @description, 
			 @enabled, 
			 @creator, 
			 getdate(), 
			 @guid
		)

	end
END

