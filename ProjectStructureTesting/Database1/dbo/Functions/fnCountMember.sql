-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountMember]
(	
	-- Add the parameters for the function here
	@indexGuid uniqueidentifier

)
RETURNS TABLE 
AS
RETURN 
(
	select pd.DepartmentId as MemberDepartmentId, pt.MemberGrade, pt.MemberRole, count(m.Id) as MemberCount
	from RecordScoreIndex rsi
	inner join ScoreConfig sc on sc.Number = rsi.ConfigNumber
	inner join PublishSetting ps on ps.Number = sc.PublishNumber
	inner join PublishTarget pt on pt.PublishNumber = sc.PublishNumber
	inner join PublishDepartment pd on pd.PublishNumber = sc.PublishNumber
	inner join v_Member m on m.DepartmentId = pd.DepartmentId and m.Grade = pt.MemberGrade and m.RoleCode = pt.MemberRole
	where rsi.[Guid] = @indexGuid
	group by pd.DepartmentId, pt.MemberGrade, pt.MemberRole


)
