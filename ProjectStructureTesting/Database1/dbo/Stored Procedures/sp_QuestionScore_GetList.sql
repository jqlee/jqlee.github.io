-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_QuestionScore_GetList]
	-- Add the parameters for the stored procedure here
	@configNumber int = 0,
	@surveyNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--if (@configNumber = 0) set @configNumber = null


	if (@configNumber > 0)
	begin

		select 
		convert(bit, case q.OptionDisplayType when 1 then 1 else 0 end) as [AvailableScore]
		,@surveyNumber as SurveyNumber,Q.Section as QuestionSection,Q.Title as QuestionTitle--, q.Number as QuestionNumber
		,q.Number as QuestionNumber
		, isNull(qs.Number,0) as Number
		, isNull(qs.ConfigNumber,0) as ConfigNumber
		, isNull(qs.Score,0.0) as Score
		, (select count(0) from [Choice] where QuestionNumber = q.Number) as ChoiceCount
		, (select count(0) 
			from Question qq
			left outer join Subset qs on qs.QuestionNumber = qq.Number and qs.Dimension = 1
			left outer join Subset qg on qg.QuestionNumber = qq.Number and qs.Dimension = 2
			where qq.Number = q.Number) as AnswerAreaCount
		from Question q 
		left outer join QuestionScore qs on qs.QuestionNumber = q.Number and qs.ConfigNumber = @configNumber
		where q.SurveyNumber = @surveyNumber and @configNumber = isNull( qs.ConfigNumber, @configNumber)
		order by q.Section, q.SortOrder

	end
	else
	begin

		select 
		convert(bit, case q.OptionDisplayType when 1 then 1 else 0 end) as [AvailableScore]
		,q.Number as QuestionNumber
		,Q.SurveyNumber,Q.Section as QuestionSection,Q.Title as QuestionTitle--, q.Number as QuestionNumber
		, 0 as Number, 0 as ConfigNumber, 0.0 as Score
		, (select count(0) from [Choice] where QuestionNumber = q.Number) as ChoiceCount
		, (select count(0) 
			from Question qq
			left outer join Subset qs on qs.QuestionNumber = qq.Number and qs.Dimension = 1
			left outer join Subset qg on qg.QuestionNumber = qq.Number and qs.Dimension = 2
			where qq.Number = q.Number) as AnswerAreaCount
		from Question q 
		where q.SurveyNumber = @surveyNumber
		order by q.Section,q.SortOrder


	end
END
