-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp__GenerateUncompletedRecord]
	-- Add the parameters for the stored procedure here
	@publishNumber int
	, @maxCount int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	/*
	declare @publishGuid uniqueidentifier = '843f5462-640d-40b8-8bd8-bc4e6b9d54d2'
	,@publishNumber int
	,@paperNumber int
	*/
	declare @paperNumber int

	--select @publishNumber = [Number] from PublishSetting where [Guid] = @publishGuid

	select @paperNumber = p.Number 
	from PublishSetting ps 
	inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	where ps.Number = @publishNumber

	--select top 3 * from Record where PublishNumber = @publishNumber
	declare @cnt int
	if (@maxCount > 0) 
		set @cnt = @maxCount
	else
	begin
		select @cnt = [TotalCount] - [RecordCount] from v_SurveyStatus where PublishNumber = @publishNumber
		set @cnt = @cnt/3*2
	end

	SET NOCOUNT OFF;
	/**/
	Insert into [dbo].[Record] (
		[PublishNumber], [SurveyNumber],  [Guid],
		[TargetMark], 
		[MemberId], [MemberDepartmentId], [MemberName],  [MemberRole],  [MemberGrade], [MemberGrp], [MemberSubgrp],
		[Done],  [Created],  [LastAccessPage],  
		[GroupId], [GroupDepartmentId], [GroupTeacherId],  [GroupTeacherName],  
		[GroupYear], [GroupSeme], [GroupGrade], [GroupRole], [GroupSubjectKey], [GroupGrp], [GroupSubgrp])
	
	select [PublishNumber], @paperNumber as [SurveyNumber],newid() as [Guid],
		1 as [TargetMark], 
		[MemberId], [MemberDepartmentId], [MemberName],  [MemberRole],  [MemberGrade], [MemberGrp], [MemberSubgrp],
		0 as [Done],  getdate() as [Created],  1 as [LastAccessPage],  
		[GroupId], [GroupDepartmentId], [GroupTeacherId],  [GroupTeacherName],  
		[GroupYear], [GroupSeme], [GroupGrade], [GroupRole], [GroupSubjectKey], [GroupGrp], [GroupSubgrp]
	from (
		select row_number() over (order by newid()) as RandomNumber,* from v_MatchRecord 
		where PublishNumber = @publishNumber and RecordNumber is null
	) x
	where RandomNumber <= @cnt	
END
