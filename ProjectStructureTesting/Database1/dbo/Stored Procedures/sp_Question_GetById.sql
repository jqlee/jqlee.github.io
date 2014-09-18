
CREATE PROCEDURE [dbo].[sp_Question_GetById]
	@number int = null
AS
BEGIN
	SET NOCOUNT ON;
	SELECT top 1 [Number], [SurveyNumber], [Section], [Title], [Description]
	--, [NumberOfItem], [IsJoined], [IsVerticalDirection], [HasOther], [Page], [IsRequired], [ChooseMax], [ParentNumber], [Percentage]
	, [Sequence],[Guid]
	--,[MinimumSelected],[MaxmumSelected],[IsDropDownList],[IsMultipleSelection]
	,[OptionDisplayType],[OptionIsVerticalList],[OptionDisplayPerRow],[OptionMultipleSelection],[OptionLimitMin],[OptionLimitMax],[OptionDisplayLines],[OptionIsRequired],[OptionLabelLeft],[OptionLabelRight],[OptionLevelStart],[OptionLevelEnd],[OptionShowOther],[OptionAppendToChoice],[OptionOtherLabel]
	FROM [dbo].[Question]
	where [Number] = @number
END


