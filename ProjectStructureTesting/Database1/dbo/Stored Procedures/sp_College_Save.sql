
CREATE PROCEDURE [dbo].[sp_College_Save]
	@id varchar(8)
	,@name nvarchar(150) = null
	,@shortName nvarchar(20) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[College] where [Id] = @id ))
	begin
		
		Update [dbo].[College] set 
			[Name] = isNull(@name, [Name]), 
			[ShortName] = isNull(@shortName, [ShortName])
		where [Id] = @id 

	end
	else
	begin
		
		Insert into [dbo].[College] (
			[Id], 
			[Name], 
			[ShortName]
		) values (
			 @id, 
			 @name, 
			 @shortName
		)

	end
END


