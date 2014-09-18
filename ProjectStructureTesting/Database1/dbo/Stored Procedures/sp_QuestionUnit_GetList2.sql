
CREATE PROCEDURE [dbo].[sp_QuestionUnit_GetList2]
	@surveyNumber int = 0
	,@section int = 0
	,@questionNumber int = 0
	,@subsetNumber int = 0
	,@groupingNumber int = 0
AS
BEGIN
	if (@surveyNumber = 0) set @surveyNumber = null;
	if (@section = 0) set @section = null;
	if (@questionNumber = 0) set @questionNumber = null;
	if (@subsetNumber = 0) set @subsetNumber = null;
	if (@groupingNumber = 0) set @groupingNumber = null;
	SET NOCOUNT ON;
	SELECT [SurveyNumber] ,[AutoId], [Section], [QuestionNumber], [Title], [AreaTitle], [FullTitle], [Description], [SubsetNumber], [SubsetText], [GroupingNumber], [GroupingText], [QuestionSort], [SubsetSort], [GroupingSort], [SortOrder]
	FROM [dbo].[v_QuestionUnit]
	where [SurveyNumber] = isNull(@surveyNumber,[SurveyNumber])
	 and [Section] = isNull(@section,[Section])
	 and [QuestionNumber] = isNull(@questionNumber,[QuestionNumber])
	 and [SubsetNumber] = isNull(@subsetNumber,[SubsetNumber])
	 and [GroupingNumber] = isNull(@groupingNumber,[GroupingNumber])
	order by [Section], [SortOrder], [SubsetSort], [GroupingSort]
END
