
CREATE PROCEDURE [dbo].[sp_LanguageKey_Save]
	@number int
	,@fileName nvarchar(100) = null
	,@key nvarchar(100) = null
	,@defaultValue nvarchar(MAX) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[LanguageKey] where [Number] = @number ))
	begin
		
		Update [dbo].[LanguageKey] set 
			[FileName] = isNull(@fileName, [FileName]), 
			[Key] = isNull(@key, [Key]), 
			[DefaultValue] = isNull(@defaultValue, [DefaultValue])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[LanguageKey] (
			[FileName], 
			[Key], 
			[DefaultValue]
		) values (
			 @fileName, 
			 @key, 
			 @defaultValue
		)

	end
END

