
CREATE PROCEDURE [dbo].[sp_SysMark_Save]
	@number int
	,@name varchar(20) = null
	,@text varchar(10) = null
	,@value int = null
	,@note nvarchar(50) = null
	,@outputPattern nvarchar(50) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[SysMark] where [Number] = @number ))
	begin
		
		Update [dbo].[SysMark] set 
			[Name] = isNull(@name, [Name]), 
			[Text] = isNull(@text, [Text]), 
			[Value] = isNull(@value, [Value]), 
			[Note] = isNull(@note, [Note]), 
			[OutputPattern] = isNull(@outputPattern, [OutputPattern])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[SysMark] (
			[Number], 
			[Name], 
			[Text], 
			[Value], 
			[Note], 
			[OutputPattern]
		) values (
			 @number, 
			 @name, 
			 @text, 
			 @value, 
			 @note, 
			 @outputPattern
		)

	end
END


