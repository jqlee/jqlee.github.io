-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Choice_GetLastNumber]
	-- Add the parameters for the stored procedure here
	@questionNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Number] from [Choice] 
	where [QuestionNumber] = @questionNumber
	order by [Number] desc
END
