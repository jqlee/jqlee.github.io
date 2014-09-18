-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_ScoreResult_Delete
	-- Add the parameters for the stored procedure here
	@surveyNumber int 
	,@logNumber int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Delete from [ScoreResult] where [LogNumber] = @logNumber and [SurveyNumber] = @surveyNumber;
END
