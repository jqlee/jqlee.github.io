
CREATE PROCEDURE [dbo].[sp_Choice_GetList]
	@questionNumber int = null
	,@langNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT isNull(l.DataValue,c.[Text]) as [LangText]
	, c.* --[Number], [QuestionNumber], [Text], [SortOrder], [AcceptText], [IsJoined]
	FROM [dbo].[Choice] c
	left outer join (
		select plt.DataNumber,plt.DataValue 
		from [PaperLanguageCategory] plc
		inner join [PaperLanguageText] plt on plt.CategoryNumber = plc.Number
		where plc.[Name] = 'choice' and plt.[LangNumber] = @langNumber
	) l on l.DataNumber = c.Number
	where c.[QuestionNumber] = isNull(@questionNumber,c.[QuestionNumber])
	order by c.[SortOrder]
END
