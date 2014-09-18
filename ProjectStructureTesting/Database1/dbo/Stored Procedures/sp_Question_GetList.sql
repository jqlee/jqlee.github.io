
CREATE PROCEDURE [dbo].[sp_Question_GetList]
	@paperNumber int = 0
	,@langNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT isNull(l.DataValue,q.[Title]) as [LangTitle]
	,isNull(ld.DataValue,q.[Description]) as [LangDescription]
	,isNull(lol.DataValue,q.[OptionLabelLeft]) as [LangOptionLabelLeft]
	,isNull(lor.DataValue,q.[OptionLabelRight]) as [LangOptionLabelRight]
	,isNull(loo.DataValue,q.[OptionOtherLabel]) as [LangOptionOtherLabel]
	, q.*
	FROM [dbo].[Question] q
	left outer join (
		select plt.DataNumber,plt.DataValue 
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plc.[Name] = 'question' and plt.[LangNumber] = @langNumber
	) l on l.DataNumber = q.Number
	left outer join (
		select plt.DataNumber,plt.DataValue 
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plc.[Name] = 'quesdesc' and [LangNumber] = @langNumber
	) ld on ld.DataNumber = q.Number
	left outer join ( -- OptionLabelLeft
		select plt.DataNumber,plt.DataValue 
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plc.[Name] = 'levelleft' and [LangNumber] = @langNumber
	) lol on lol.DataNumber = q.Number
	left outer join ( -- OptionLabelRight
		select plt.DataNumber,plt.DataValue 
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plc.[Name] = 'levelright' and [LangNumber] = @langNumber
	) lor on lor.DataNumber = q.Number
	left outer join ( -- OptionOtherLabel
		select plt.DataNumber,plt.DataValue 
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plc.[Name] = 'otherlabel' and [LangNumber] = @langNumber
	) loo on loo.DataNumber = q.Number
	where q.[SurveyNumber] = @paperNumber
	order by q.[Section],q.[SortOrder]
	/*
	SELECT [Number], [SurveyNumber], [Section], [Title], [Description]
	--, [NumberOfItem], [IsJoined], [IsVerticalDirection], [HasOther], [Page], [IsRequired], [ChooseMax], [ParentNumber], [Percentage]
	, [Sequence],[Guid]
	--,[MinimumSelected],[MaxmumSelected],[IsDropDownList],[IsMultipleSelection]
	,[OptionDisplayType],[OptionIsVerticalList],[OptionDisplayPerRow],[OptionMultipleSelection],[OptionLimitMin],[OptionLimitMax],[OptionDisplayLines],[OptionIsRequired],[OptionLabelLeft],[OptionLabelRight],[OptionLevelStart],[OptionLevelEnd],[OptionShowOther],[OptionAppendToChoice], [OptionOtherLabel]
	FROM [dbo].[Question]
	where [SurveyNumber] = @surveyNumber
	order by [Section],[SortOrder]
	*/
END

