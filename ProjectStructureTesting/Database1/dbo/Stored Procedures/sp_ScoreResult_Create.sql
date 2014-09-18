-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreResult_Create]
	-- Add the parameters for the stored procedure here
	@surveyNumber int 
	,@logNumber int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	delete from [ScoreResult] where [LogNumber] = @logNumber and [SurveyNumber] = @surveyNumber;
    -- Insert statements for procedure here
	INSERT INTO [dbo].[ScoreResult] ([LogNumber] ,[MatchKey] ,[MatchFilter] ,[SurveyNumber] ,[QuestionNumber] ,[AverageScore] ,[StandardDeviation],[QuestionRatio],[FinalScore]) 		
	select x.[LogNumber] ,x.[MatchKey] ,x.[MatchFilter] ,x.[SurveyNumber] ,x.[QuestionNumber] ,x.[AverageScore] ,x.[StandardDeviation]
	, qs.Score as QuestionRatio, (qs.Score/100 * x.AverageScore) as FinalScore --,qs.*
	--,q.Title as QuestionTitle
	from (
		select x.LogNumber,x.MatchKey,x.MatchFilter,x.SurveyNumber,x.QuestionNumber
		, avg(x.AverageScore) as AverageScore, avg(x.StandardDeviation) as StandardDeviation
		from (
			select w.LogNumber, w.MatchKey,w.MatchFilter
			--, w.Section 
			,w.SurveyNumber, w.QuestionNumber , w.SubsetNumber, w.GroupingNumber--, w.ChoiceNumber
			,w.QuestionScore
			,count(distinct w.RecordNumber) as PickCount
			, sum(w.ChoiceScore) as TotalScore
			, avg(w.ChoiceScore) as AverageScore
			, STDEVP(w.ChoiceScore) as StandardDeviation
			from v_ScoreRaw w
			where w.SurveyNumber = @surveyNumber and w.LogNumber = @logNumber
			group by w.LogNumber, w.MatchKey,w.MatchFilter--, w.Section
			,w.SurveyNumber, w.QuestionNumber, w.SubsetNumber, w.GroupingNumber
			--, w.ChoiceNumber
			,w.QuestionScore 
		) x 
		group by x.LogNumber,x.MatchKey,x.MatchFilter,x.SurveyNumber,x.QuestionNumber
	) x 
	inner join ScoreLog l on l.Number = x.LogNumber and l.SurveyNumber = x.SurveyNumber
	inner join QuestionScore qs on qs.ConfigNumber = l.ConfigNumber and qs.QuestionNumber = x.QuestionNumber
	--inner join Question q on q.Number = x.QuestionNumber
	order by x.MatchKey,x.MatchFilter
END
