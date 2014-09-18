-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Section_GetList 
	-- Add the parameters for the stored procedure here
	@surveyNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Section as Number,count(*) as QuestionCount from question 
	where surveyNumber = @surveyNumber and Section > 0
	group by Section
	order by Section
END
