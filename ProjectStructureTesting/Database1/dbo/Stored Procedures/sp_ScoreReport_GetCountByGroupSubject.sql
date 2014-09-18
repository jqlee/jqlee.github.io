-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreReport_GetCountByGroupSubject]
	-- Add the parameters for the stored procedure here
	--@indexGuid uniqueidentifier 
	@publishNumber int
	,@groupId varchar(20) = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @subjectKey varchar(6) = null; --'D563'
	select @subjectKey = SubjectKey from v_Group where Id = @groupId
	
	select g.SubjectKey--,sm.GroupId,sm.TeacherId
	, count(distinct sm.GroupId + sm.TeacherId) as GroupTeacherCount
	, sum(case RecordDone when 1 then 1 else 0 end) as RecordCount,count(*) as MemberCount 
	from v_SurveyMatch sm
	inner join v_Group g on g.Id = sm.GroupId
	where SurveyNumber = @publishNumber and g.SubjectKey = @subjectKey
	group by g.SubjectKey--,sm.GroupId,sm.TeacherId


END
