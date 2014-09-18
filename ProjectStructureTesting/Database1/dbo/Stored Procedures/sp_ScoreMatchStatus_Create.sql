-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreMatchStatus_Create]
	-- Add the parameters for the stored procedure here
	@surveyNumber int
	,@logNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into ScoreMatchStatus ([SurveyNumber],[LogNumber],[MatchKey],[MatchName],[MemberCount],[RecordCount])
	select  SurveyNumber, @logNumber as LogNumber, MatchKey, MatchName
	, count(distinct MemberId) as MemberCount 
	, sum(convert(int,isNull(RecordDone,0))) as RecordCount
	from fnTargetMatch(@surveyNumber)
	--where RecordDone = 1
	group by SurveyNumber, MatchKey, MatchName
/*
	select SurveyNumber, @logNumber as LogNumber, MatchKey,MatchName, count(MemberId) as MemberCount, count(RecordDone) as RecordCount
	from (
		select distinct SurveyNumber, MatchKey, MatchName, MemberId, RecordDone from fnTargetMatch(@surveyNumber)
	) x
	group by SurveyNumber, MatchKey,MatchName
*/

    -- Insert statements for procedure here
	/*
	insert into ScoreMatchStatus ([SurveyNumber],[LogNumber],[TargetNumber],[MatchKey],[MatchName],[MatchFilter],[FilterName],[MemberCount],[RecordCount])
	select 
	@surveyNumber as [SurveyNumber], @logNumber as [LogNumber]
	--, tm.[TargetNumber]
	, tm.[MatchKey],tm.[MatchName]
	--,tm.[MatchFilter],tm.[FilterName],tm.[MemberCount], tm.[RecordCount]
	 from dbo.fnTargetMatch(@surveyNumber) tm 
	 */
END