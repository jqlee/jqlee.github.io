
CREATE PROCEDURE [dbo].[sp_Target_Save]
	@number int
	,@conditionNumber int = null
	--,@targetMark tinyint = null
	,@departmentId varchar(20) = null
	,@matchKey varchar(30) = null
	,@matchName nvarchar(50) = null
	,@roleCode varchar(6) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Target] where [Number] = @number ))
	begin
		
		Update [dbo].[Target] set 
			[ConditionNumber] = isNull(@conditionNumber, [ConditionNumber]), 
		--	[TargetMark] = isNull(@targetMark, [TargetMark]), 
			[DepartmentId] = isNull(@departmentId, [DepartmentId]), 
			[MatchKey] = isNull(@matchKey, [MatchKey]), 
			[MatchName] = isNull(@matchName, [MatchName]), 
			[RoleCode] = isNull(@roleCode, [RoleCode])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[Target] (
			[ConditionNumber], 
		--	[TargetMark], 
			[DepartmentId], 
			[MatchKey], 
			[MatchName], 
			[RoleCode]
		) values (
			 @conditionNumber, 
			-- @targetMark, 
			 @departmentId, 
			 @matchKey, 
			 @matchName, 
			 @roleCode
		)

	end
END

