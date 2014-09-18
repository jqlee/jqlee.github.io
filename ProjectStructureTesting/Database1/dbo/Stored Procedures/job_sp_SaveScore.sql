-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[job_sp_SaveScore]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @indexGuid uniqueidentifier, @number int
	
	if (exists(Select 0 From [SqlJob_SaveScore] where [Enabled] = 1 and Done = 0))
	begin

	Select @number = Number, @indexGuid = IndexGuid From [SqlJob_SaveScore] where [Enabled] = 1 and Done = 0 order by Number

	update [SqlJob_SaveScore] set StartDate = getdate() where Number = @number

    -- Insert statements for procedure here
	exec sp_RecordScoreIndex_SaveScore @indexGuid

	update [SqlJob_SaveScore] set Done = 1, CompleteDate = getdate() where Number = @number

	end
END
