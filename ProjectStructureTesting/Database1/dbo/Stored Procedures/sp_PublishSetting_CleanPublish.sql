
CREATE PROCEDURE [dbo].[sp_PublishSetting_CleanPublish]
	@publishNumber int
AS
BEGIN
	SET NOCOUNT ON;
	begin tran T1

	declare @publishPaperNumber int

	select @publishPaperNumber = p.Number
	from SurveyPaper p 
	inner join PublishSetting ps on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	where ps.Number = @publishNumber

	-- delete records
	Delete FROM [dbo].[RecordRawValue] 
	from [dbo].[Record] r
	inner join [dbo].[RecordRaw] w on w.RecordNumber = r.Number
	inner join [dbo].[RecordRawValue] v on v.RawNumber = w.Number
	where r.[PublishNumber] = @publishNumber

	Delete FROM [dbo].[RecordRawText] 
	from [dbo].[Record] r
	inner join [dbo].[RecordRaw] w on w.RecordNumber = r.Number
	inner join [dbo].[RecordRawText] t on t.RawNumber = w.Number
	where r.[PublishNumber] = @publishNumber

	Delete FROM [dbo].[RecordRaw] 
	from [dbo].[Record] r
	inner join [dbo].[RecordRaw] w on w.RecordNumber = r.Number
	where r.[PublishNumber] = @publishNumber

	Delete FROM [dbo].[Record] where [PublishNumber] = @publishNumber

	-- delete stored scores

	Delete FROM [dbo].[StatQuestion] where [PublishNumber] = @publishNumber

	Delete FROM [dbo].[RecordQuestionScore] 
	from [dbo].[RecordTarget] rt
	inner join [dbo].[RecordQuestionScore] rqs on rqs.TargetNumber = rt.Number
	where rt.[PublishNumber] = @publishNumber

	Delete FROM [dbo].[RecordTarget] where [PublishNumber] = @publishNumber

	-- delete configs
	Delete FROM [dbo].[QuestionScore]  
	from [dbo].[ScoreConfig] sc
	inner join [dbo].[QuestionScore] qs on qs.ConfigNumber = sc.Number
	where sc.[PublishNumber] = @publishNumber and sc.PaperNumber = @publishPaperNumber

	Delete FROM [dbo].[ChoiceScore] 
	from [dbo].[ScoreConfig] sc
	inner join [dbo].[ChoiceScore] cs on cs.ConfigNumber = sc.Number
	where sc.[PublishNumber] = @publishNumber and sc.PaperNumber = @publishPaperNumber

	Delete FROM [dbo].[RecordScoreIndex] 
	from [dbo].[ScoreConfig] sc
	inner join [dbo].[RecordScoreIndex] rsi on rsi.ConfigNumber = sc.Number
	where sc.[PublishNumber] = @publishNumber and sc.PaperNumber = @publishPaperNumber

	Delete FROM [dbo].[ScoreConfig] where [PublishNumber] = @publishNumber and PaperNumber = @publishPaperNumber

	-- delete publish papers
	--Delete FROM [dbo].[SurveyPaper] where [PublishNumber] = @number and IsTemplate = 0


	Delete FROM [dbo].[ChoiceScore] 
	from [dbo].[SurveyPaper] p
	inner join [dbo].[Question] q on q.SurveyNumber = p.Number
	inner join [dbo].[Choice] c on c.QuestionNumber = q.Number
	inner join [dbo].[ChoiceScore] cs on cs.ChoiceNumber = c.Number
	where p.[Number] = @publishPaperNumber

	Delete FROM [dbo].[Choice] 
	from [dbo].[SurveyPaper] p
	inner join [dbo].[Question] q on q.SurveyNumber = p.Number
	inner join [dbo].[Choice] c on c.QuestionNumber = q.Number
	where p.[Number] = @publishPaperNumber

	Delete FROM [dbo].[QuestionScore] 
	from [dbo].[SurveyPaper] p
	inner join [dbo].[Question] q on q.SurveyNumber = p.Number
	inner join [dbo].[QuestionScore] qs on qs.QuestionNumber = q.Number
	where p.[Number] = @publishPaperNumber

	Delete FROM [dbo].[Question] 
	from [dbo].[SurveyPaper] p
	inner join [dbo].[Question] q on q.SurveyNumber = p.Number
	where p.[Number] = @publishPaperNumber


	Delete FROM [dbo].[SurveyPaper] where Number = @publishPaperNumber

	update PublishSetting 
	set IsPublished = 0, CompleteCount = 0, CompleteRate = 0
	, LastPublishVersion = case when LastPublishVersion>1 then LastPublishVersion - 1 else null end 
	where Number = @publishNumber

	commit tran T1
END

/*
exec [sp_PublishSetting_CleanPublish] 12

*/