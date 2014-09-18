Create PROCEDURE [dbo].[sp_RecordScoreIndex_RunFirstInQueue]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @indexNumber int

	if (exists(select 0 from RecordScoreIndex where Done = 0))
	begin
		select @indexNumber = Number from RecordScoreIndex where Done = 0
		exec sp_StatQuestion_SaveReport @indexNumber
	end
END
