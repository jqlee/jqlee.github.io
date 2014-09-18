
CREATE PROCEDURE [dbo].[sp_Language_Save]
	@number int
	,@name nvarchar(50) = null
	,@code varchar(6) = null
	,@enabled bit = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Language] where [Number] = @number ))
	begin
		
		Update [dbo].[Language] set 
			[Name] = isNull(@name, [Name]), 
			[Code] = isNull(@code, [Code]), 
			[Enabled] = isNull(@enabled, [Enabled])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[Language] (
			[Name], 
			[Code], 
			[Enabled]
		) values (
			 @name, 
			 @code, 
			 @enabled
		)

	end
END

