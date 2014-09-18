
CREATE PROCEDURE [dbo].[sp_ScoreConfig_GetList]
	@signOnMember varchar(20) = null
	,@paperNumber int = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT  sc.* --[Number], [Name],[SurveyNumber], [Creator], [Created], [Enabled]
	, (select sum(score) from QuestionScore where ConfigNumber = sc.Number) as TotalScore
	, m.Name as [CreatorName]
	, convert(bit, case sc.[Creator] when @signOnMember then 1 else 0 end) as [isAuthor]

	FROM [dbo].[ScoreConfig] sc
	left outer join v_Member m on m.Id = sc.[Creator]
	where [PaperNumber] = @paperNumber
	order by isNull(sc.[LastModified],sc.[Created]) desc
END
