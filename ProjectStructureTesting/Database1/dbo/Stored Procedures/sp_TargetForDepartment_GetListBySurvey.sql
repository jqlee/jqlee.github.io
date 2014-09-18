-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_TargetForDepartment_GetListBySurvey
	-- Add the parameters for the stored procedure here
	@surveyNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select t.*, d.Name as DepartmentName
	,isNull(tm.MatchCount,0) as MatchCount
	,isNull(tm.MemberCount,0) as MemberCount
	from TargetForDepartment t 
	left outer join (
		select TargetNumber,count(distinct MatchItem) as MatchCount,count(distinct MemberId) as MemberCount 
		from v_TargetMember group by TargetNumber
	) tm on tm.TargetNumber = t.Number
	inner join v_Department d on d.Id = t.DepartmentId
	where t.SurveyNumber = @surveyNumber and tm.MatchCount is not null
END
