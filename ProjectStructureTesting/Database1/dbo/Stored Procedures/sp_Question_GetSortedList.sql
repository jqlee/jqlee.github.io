-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Question_GetSortedList
	-- Add the parameters for the stored procedure here
	--@surveyId uniqueidentifier
	@surveyNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select q.section,q.SortOrder,q.Number 
	from question q
	where q.SurveyNumber = @surveyNumber
	order by q.Section,q.SortOrder

    -- Insert statements for procedure here
	/*
	select q.section,q.SortOrder,q.Number 
	from Survey s
	inner join question q on q.SurveyNumber = s.Number
	where s.[Guid] = @surveyId
	order by q.Section,q.SortOrder
	*/
END
