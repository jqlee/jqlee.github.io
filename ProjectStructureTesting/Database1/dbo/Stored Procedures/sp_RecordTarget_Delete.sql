
CREATE PROCEDURE [dbo].[sp_RecordTarget_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	Delete FROM [dbo].[RecordTarget] where [Number] = @number
END