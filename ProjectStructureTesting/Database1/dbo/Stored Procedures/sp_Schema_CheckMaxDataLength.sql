-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Schema_CheckMaxDataLength
	-- Add the parameters for the stored procedure here
	@tableName nvarchar(200)
	,@columnName nvarchar(200) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select CHARACTER_MAXIMUM_LENGTH as [MaxLength]
	from INFORMATION_SCHEMA.COLUMNS 
	where TABLE_NAME = @tableName and COLUMN_NAME = ISNULL(@columnName, COLUMN_NAME)
END
