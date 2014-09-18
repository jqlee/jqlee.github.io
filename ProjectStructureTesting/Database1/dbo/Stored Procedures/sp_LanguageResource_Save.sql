
CREATE PROCEDURE [dbo].[sp_LanguageResource_Save]
	@number int
	,@fileName nvarchar(MAX) = null
	,@xmlContent varbinary(MAX) = null
	,@done bit = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[LanguageResource] where [Number] = @number ))
	begin
		
		Update [dbo].[LanguageResource] set 
			[FileName] = isNull(@fileName, [FileName]), 
			[XmlContent] = isNull(@xmlContent, [XmlContent]), 
			[Done] = isNull(@done, [Done])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[LanguageResource] (
			[FileName], 
			[XmlContent], 
			[Done]
		) values (
			 @fileName, 
			 @xmlContent, 
			 @done
		)

	end
END

