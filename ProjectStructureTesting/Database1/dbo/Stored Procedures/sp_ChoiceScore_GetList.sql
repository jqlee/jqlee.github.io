
CREATE PROCEDURE [dbo].[sp_ChoiceScore_GetList]
	@configNumber int = 0
	,@questionNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;

	if (@configNumber>0)
	begin

	Select @questionNumber as QuestionNumber, c.Number as ChoiceNumber, c.[Text] as [ChoiceText]
		, isNull(cs.Number,0) as Number
		, isNull(cs.[ConfigNumber],0) as [ConfigNumber]
		, isNull(cs.[Score],0.0) as [Score]
	from [Choice] c
	left outer join ChoiceScore cs on cs.ChoiceNumber = c.Number and cs.ConfigNumber = @configNumber
	where QuestionNumber = @questionNumber
	order by [SortOrder]

	end
	else
	begin

	Select @questionNumber as QuestionNumber, Number as ChoiceNumber, [Text] as [ChoiceText]
		, 0 as Number, 0 as [ConfigNumber], 0.0 as [Score]
	from [Choice] 
	where QuestionNumber = @questionNumber
	order by [SortOrder]

	end

END
