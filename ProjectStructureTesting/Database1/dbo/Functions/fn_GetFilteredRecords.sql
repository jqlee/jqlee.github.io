-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetFilteredRecords]
(	
	-- Add the parameters for the function here
	@publishNumber int
	, @groupId varchar(20) = null
	, @groupTeacherId varchar(20) = null
	, @groupRole varchar(20) = null
	, @memberDepartmentId varchar(20) = null
	, @memberGrade tinyint = null
	, @memberRole varchar(20) = null
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	select r.Number as RecordNumber
	from PublishSetting ps
		inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
		inner join Record r on r.PublishNumber = ps.Number and r.SurveyNumber = p.Number
	where ps.Number = @publishNumber and r.Done = 1
	and 1 = case 
	when ps.TargetMark = 1 and r.GroupId = isNull(@groupId, r.GroupId) and r.GroupTeacherId = isNull(@groupTeacherId, r.GroupTeacherId) and r.GroupRole = isNull(@groupRole, r.GroupRole) then 1
	when ps.TargetMark = 2 and r.MemberDepartmentId = isNull(@memberDepartmentId, r.MemberDepartmentId) and r.MemberGrade = @memberGrade then 1
	else 0 end

)
