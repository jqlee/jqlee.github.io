-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Condition_Create]
	-- Add the parameters for the stored procedure here
	 @surveyNumber int
		--@keyword並非由使用者輸入而是下拉清單直接代入，故必然會對應到一個節點，只是不知道是院或系，所以取名keyword
	, @keyword varchar(20)
	, @name nvarchar(50)
	, @memberGrade int
	, @roleCode varchar(6)
	, @groupYear int
	, @creator varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    begin tran T1

		if (@memberGrade = 0) set @memberGrade = null
		if (@groupYear = 0) set @groupYear = null
		declare @targetMark int
		select @targetMark = TargetMark from Survey where Number = @surveyNumber

		--declare @name nvarchar(50);
		--select @name = DepartmentName from dbo.fnGetTreeFromDepartment(@keyword)--where ChildrenCount = 0

		INSERT INTO [dbo].[Condition]
		([SurveyNumber],[TargetMark],[Keyword],[Name],[RoleCode]
		,[GroupYear],[MemberGrade]
		,[Creator],[Created])
		VALUES
		(@surveyNumber, @targetMark,@keyword, @name, @roleCode
		,case when @targetMark = 4 then @groupYear else null end
		,case when @targetMark = 3 then @memberGrade else null end
		,@creator
		,getdate());

		declare @conditionNumber int;
		set @conditionNumber = scope_identity();
		
		exec sp_Target_BuildFromCondition @conditionNumber;
		/*

		delete from [dbo].[Target] where [ConditionNumber] = @conditionNumber;
		INSERT INTO [dbo].[Target] ([ConditionNumber],[TargetMark],[DepartmentId],[MatchKey],[MatchName],[RoleCode])

		--產生target
		select @conditionNumber as [ConditionNumber]
			, @targetMark as [TargetMark]
			, d.DepartmentId --,d.DepartmentName
			, case when @targetMark = 3 then gl.Value when @targetMark = 4 then yl.Value else null end as [MatchKey] 
			, case when @targetMark = 3 then gl.Name when @targetMark = 4 then yl.Name else null end as [MatchName] 
			, @roleCode as [RoleCode]
		from dbo.fnGetTreeFromDepartment(@keyword) d
		left outer join fnGetGradeList() gl on gl.[Value] = isNull(@memberGrade,gl.[Value]) and @targetMark = 3
		left outer join fnGetYearList() yl on yl.[Value] = isNull(@groupYear,yl.[Value]) and yl.[DepartmentId] = d.DepartmentId and @targetMark = 4
		where d.ChildrenCount = 0 and (gl.[Value] is not null or yl.[Value] is not null)
		*/
	commit tran T1
END
