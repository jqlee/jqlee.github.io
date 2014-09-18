	-- 20140331 增加 GroupSubjectKey
	/* 	--更新現有紀錄
Update Record set GroupSubjectKey = g.SubjectKey
from Record r
inner join v_Group g on g.Id = r.GroupId

Update Record set GroupGrp = g.Grp, GroupSubgrp = g.Subgrp
from Record r
inner join v_Group g on g.Id = r.GroupId

Update Record set MemberGrp = m.Grp, MemberSubgrp = m.Subgrp
from Record r
inner join v_Member m on m.Id = r.MemberId


	*/

CREATE PROCEDURE [dbo].[sp_Record_Create]
	--@number int
	@guid uniqueidentifier
	,@publishNumber int = null
	,@surveyNumber int = null
	--,@guid uniqueidentifier = null
	--,@departmentId varchar(20) = null
	--,@targetNumber int = null
	,@targetMark tinyint = null
	,@memberId varchar(20) = null
	,@memberDepartmentId varchar(20) = null
	,@memberName nvarchar(50) = null
	,@memberRole varchar(6) = null
	,@memberGrade tinyint = null
	,@memberGrp varchar(2) = null
	,@memberSubgrp varchar(2) = null
	--,@done bit = null
	--,@created datetime = null
	--,@lastAccessPage tinyint = null
	--,@lastAccessTime datetime = null
	,@groupId varchar(20) = null
	,@groupDepartmentId varchar(20) = null
	,@groupTeacherId varchar(20) = null
	,@groupTeacherName nvarchar(50) = null
	,@groupYear smallint = null
	,@groupSeme tinyint = null
	,@groupGrade tinyint = null
	,@groupGrp varchar(2) = null
	,@groupSubgrp varchar(2) = null
	,@groupRole varchar(6) = null
	,@groupSubjectKey varchar(6) = null

AS
BEGIN
	SET NOCOUNT ON;

	Insert into [dbo].[Record] (
			[PublishNumber], [SurveyNumber],  [Guid],
			--[DepartmentId], 
			--[TargetNumber],  
			[TargetMark], 
			[MemberId], [MemberDepartmentId], [MemberName],  [MemberRole],  [MemberGrade], [MemberGrp], [MemberSubgrp],
			[Done],  [Created],  [LastAccessPage],  
			[GroupId], [GroupDepartmentId], [GroupTeacherId],  [GroupTeacherName],  
			[GroupYear], [GroupSeme], [GroupGrade], [GroupRole], [GroupSubjectKey], [GroupGrp], [GroupSubgrp]
		) values (
			@publishNumber, @surveyNumber, @guid, 
			 --@departmentId,  
			 --@targetNumber,  
			 @targetMark, 
			 @memberId, @memberDepartmentId, @memberName, @memberRole, @memberGrade, @memberGrp, @memberSubgrp,
			 0, --@done, 
			 getdate(), --@created, 
			 1, --@lastAccessPage, 
			 @groupId, @groupDepartmentId, @groupTeacherId, @groupTeacherName, 
			 @groupYear, @groupSeme, @groupGrade, @groupRole, @groupSubjectKey, @groupGrp, @groupSubgrp
		)

END


-- select top 10 * from Record where TargetMark = 1
-- select top 10 * from Record where TargetMark = 2
-- select top 10 * from v_Member
-- select top 10 * from v_Group