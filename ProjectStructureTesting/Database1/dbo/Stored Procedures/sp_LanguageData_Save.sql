
CREATE PROCEDURE [dbo].[sp_LanguageData_Save]
	@languageNumber int = null
	,@keyNumber int = null
	,@value nvarchar(MAX) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT off;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[LanguageData] where [LanguageNumber] = @languageNumber and [KeyNumber] = @keyNumber ))
	begin
		
		Update [dbo].[LanguageData] set 
			[Value] = isNull(@value, [Value])
		where [LanguageNumber] = @languageNumber and [KeyNumber] = @keyNumber 

	end
	else
	begin
		
		Insert into [dbo].[LanguageData] (
			[LanguageNumber], 
			[KeyNumber], 
			[Value]
		) values (
			 @languageNumber, 
			 @keyNumber, 
			 @value
		)

	end
END

