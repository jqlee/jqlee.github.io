
CREATE PROCEDURE [dbo].[sp_PublishSetting_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	--Delete FROM [dbo].[PublishSetting] where [Number] = @number
	begin tran T1

	-- delete records
	Delete FROM [dbo].[RecordRawValue] 
	from [dbo].[Record] r
	inner join [dbo].[RecordRaw] w on w.RecordNumber = r.Number
	inner join [dbo].[RecordRawValue] v on v.RawNumber = w.Number
	where r.[PublishNumber] = @number

	Delete FROM [dbo].[RecordRawText] 
	from [dbo].[Record] r
	inner join [dbo].[RecordRaw] w on w.RecordNumber = r.Number
	inner join [dbo].[RecordRawText] t on t.RawNumber = w.Number
	where r.[PublishNumber] = @number

	Delete FROM [dbo].[RecordRaw] 
	from [dbo].[Record] r
	inner join [dbo].[RecordRaw] w on w.RecordNumber = r.Number
	where r.[PublishNumber] = @number

	Delete FROM [dbo].[Record] where [PublishNumber] = @number

	-- delete stored scores

	Delete FROM [dbo].[StatQuestion] where [PublishNumber] = @number

	Delete FROM [dbo].[RecordQuestionScore] 
	from [dbo].[RecordTarget] rt
	inner join [dbo].[RecordQuestionScore] rqs on rqs.TargetNumber = rt.Number
	where rt.[PublishNumber] = @number

	Delete FROM [dbo].[RecordTarget] where [PublishNumber] = @number

	-- delete configs
	Delete FROM [dbo].[RecordScoreIndex] 
	from [dbo].[ScoreConfig] sc
	inner join [dbo].[RecordScoreIndex] rsi on rsi.ConfigNumber = sc.Number
	where sc.[PublishNumber] = @number

	Delete FROM [dbo].[ScoreConfig] where [PublishNumber] = @number

	-- delete publish papers
	Delete FROM [dbo].[SurveyPaper] where [PublishNumber] = @number and IsTemplate = 0

	-- delete publish settings
	Delete FROM [dbo].[PublishTarget] where [PublishNumber] = @number
	Delete FROM [dbo].[PublishDepartment] where [PublishNumber] = @number

	-- delete publish
	Delete FROM [dbo].[PublishSetting] where [Number] = @number

	commit tran T1
END