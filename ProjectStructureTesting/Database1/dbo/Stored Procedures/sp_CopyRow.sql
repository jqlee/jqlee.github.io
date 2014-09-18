-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CopyRow]
	-- Add the parameters for the stored procedure here
	@tableName varchar(255)
	, @replaceColumn varchar(255)
	, @oldValue varchar(255)
	, @newValue varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @newId uniqueidentifier,@columns nvarchar(max),@sql nvarchar(max)
	
	--set @newId = newid();
	set @columns = dbo.fnGetColumnList(@tableName,0);
	set @sql = 'declare @temp Table ([Idx] int identity(1,1), '+[dbo].[fnGetColumnListWithType] (@tableName ,0)+')
	insert into @temp ('+@columns+')
	select '+@columns+' from ['+@tableName+'] where ['+@replaceColumn+'] = '''+ @oldValue + '''
	update @temp set ['+@replaceColumn+'] = '''+ @newValue +'''
	
	Insert into ['+@tableName+'] ('+@columns +N')
	Select '+@columns+' from @temp'


	exec sp_executeSQL @sql;

END
