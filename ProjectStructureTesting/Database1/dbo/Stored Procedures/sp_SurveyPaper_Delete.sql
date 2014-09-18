
CREATE PROCEDURE [dbo].[sp_SurveyPaper_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;

	/*
	理論上試卷是不刪的，只有在系統管理模式可以實體刪除
	實體刪除試卷時，依序刪除下列項目
	1. 題目與選項
	2. 配分設定
	3. 試卷本體
	*/

	begin Tran T1

	Delete FROM [dbo].[ChoiceScore]
	from [dbo].[ChoiceScore] cs
	inner join [dbo].[Choice] c on c.Number = cs.ChoiceNumber
	inner join [Question] q on q.Number = c.QuestionNumber
	where q.[SurveyNumber] = @number


	Delete FROM [dbo].[Choice]
	from [dbo].[Choice] c 
	inner join [Question] q on q.Number = c.QuestionNumber
	where q.[SurveyNumber] = @number

	Delete FROM [dbo].[QuestionScore] 
	from [dbo].[QuestionScore] qs
	inner join [dbo].[Question] q on q.Number = qs.[QuestionNumber]
	where q.[SurveyNumber] = @number

	Delete FROM [dbo].[Question] where [SurveyNumber] = @number

	Delete from ScoreConfig where [PaperNumber] = @number

	Delete FROM [dbo].[SurveyPaper] where [Number] = @number

	commit Tran T1
END