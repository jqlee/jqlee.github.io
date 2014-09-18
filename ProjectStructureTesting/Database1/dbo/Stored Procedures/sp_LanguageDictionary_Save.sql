
CREATE PROCEDURE [dbo].[sp_LanguageDictionary_Save]
	@number int
	,@fileName nvarchar(100) = null
	,@key nvarchar(100) = null
	,@defaultText nvarchar(MAX) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[LanguageDictionary] where [Number] = @number ))
	begin
		
		Update [dbo].[LanguageDictionary] set 
			[FileName] = isNull(@fileName, [FileName]), 
			[Key] = isNull(@key, [Key]), 
			[DefaultText] = isNull(@defaultText, [DefaultText])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[LanguageDictionary] (
			[FileName], 
			[Key], 
			[DefaultText]
		) values (
			 @fileName, 
			 @key, 
			 @defaultText
		)

	end
END

