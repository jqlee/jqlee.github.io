-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreRaw_Create]
	-- Add the parameters for the stored procedure here
	@surveyNumber int = 0
	,@configNumber int = 0
	,@logNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

	begin tran T1 

	declare @row int

	--塞作答紀錄，不塞分數
	INSERT INTO [dbo].[ScoreRaw]
           ([SurveyNumber], [ConfigNumber]
		   --, [TargetNumber]
		   , [LogNumber] ,[RecordNumber]
           , [QuestionNumber] ,[SubsetNumber] ,[GroupingNumber]
		   , [MemberId]
           , [ChoiceNumber]
		   , QuestionScore, ChoiceScore
		   )
   
	select @surveyNumber as [SurveyNumber], @configNumber as ConfigNumber, @logNumber as LogNumber, s.RecordNumber
	, s.QuestionNumber, s.SubsetNumber, s.GroupingNumber
	, s.MemberId --, s.ValueNumber
	, s.ChoiceNumber
	, st.QuestionScore, st.ChoiceScore
	from dbo.fnCurrentRaw(@surveyNumber) s
	inner join dbo.fnScoreTable(@surveyNumber, @configNumber) st on st.QuestionNumber = s.QuestionNumber and st.ChoiceNumber = s.ChoiceNumber

	where s.RecordDone = 1
	order by s.RecordNumber, s.QuestionNumber

/*

    -- Insert statements for procedure here
	INSERT INTO [dbo].[ScoreRaw]
           ([MatchKey] ,[MatchFilter] ,[LogNumber]
           ,[SurveyNumber], [TargetNumber] ,[RecordNumber]
           ,[Section] ,[QuestionNumber] ,[SubsetNumber] ,[GroupingNumber]
           ,[ChoiceNumber]
           ,[ChoiceScore], [MemberId])
   

	select s.MatchKey, s.MatchFilter, @logNumber as LogNumber, @surveyNumber as [SurveyNumber], s.TargetNumber, s.RecordNumber
	, s.Section, s.QuestionNumber, s.SubsetNumber, s.GroupingNumber
	,st.ChoiceNumber, st.ChoiceScore , s.MemberId --, s.ValueNumber
	from dbo.fnScoreTable(@surveyNumber, @configNumber) st
	left outer join dbo.fnCurrentRaw(@surveyNumber) s 
	 on st.QuestionNumber = s.QuestionNumber and st.ChoiceNumber = s.ChoiceNumber /*and st.SubsetNumber = s.SubsetNumber and st.GroupingNumber = s.GroupingNumber*/
	where  MatchKey is not null 
*/
	select @row = count(distinct recordNumber) from ScoreRaw where LogNumber = @logNumber

	--set @row = @@rowcount
	SET NOCOUNT ON;

	update [ScoreLog] set [RecordCount] = @row where Number = @logNumber

	
	--exec sp_ScoreResult_Create @surveyNumber=@surveyNumber,@logNumber=@logNumber


	--改成由程式
	--exec sp_ScoreMatchStatus_Create @surveyNumber=@surveyNumber,@logNumber=@logNumber

	commit tran T1

END