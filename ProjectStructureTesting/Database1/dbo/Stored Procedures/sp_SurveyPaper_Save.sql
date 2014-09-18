
CREATE PROCEDURE [dbo].[sp_SurveyPaper_Save]
	@number int
	,@schoolId varchar(6) = null
	,@title nvarchar(100) = null
	,@description nvarchar(MAX) = null
	,@enabled bit = null
	,@creator varchar(20) = null
	,@guid uniqueidentifier = null
	,@isTemplate bit = 1
	,@defaultLangCode varchar(2) = null
	,@publishNumber int = null
	,@publishVersion smallint = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[SurveyPaper] where [Number] = @number ))
	begin
		
		Update [dbo].[SurveyPaper] set 
			[SchoolId] = isNull(@schoolId, [SchoolId]), 
			[Title] = isNull(@title, [Title]), 
			[Description] = isNull(@description, [Description]), 
			[Enabled] = isNull(@enabled, [Enabled]), 
			[Creator] = isNull(@creator, [Creator]), 
			[LastModified] = getdate(), 
			[Guid] = isNull(@guid, [Guid]),
			[DefaultLangCode] = ISNULL(@defaultLangCode, [DefaultLangCode]),
			[PublishNumber] = isNull(@publishNumber, [PublishNumber]),
			[PublishVersion] = isNull(@publishVersion, [PublishVersion])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[SurveyPaper] (
			[SchoolId],
			[Title], 
			[Description], 
			[Enabled], 
			[Creator], 
			[Created], 
			[LastModified],
			[Guid],
			[DefaultLangCode],
			[IsTemplate]
		) values (
			@schoolId,
			@title, 
			@description, 
			@enabled, 
			@creator, 
			getdate(), 
			getdate(), 
			@guid,
			@defaultLangCode,
			@isTemplate
		)

	end
END


