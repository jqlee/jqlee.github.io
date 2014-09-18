
CREATE PROCEDURE [dbo].[sp_Condition_Delete]
	@number int
AS
BEGIN
	SET NOCOUNT ON;
	begin tran t1

	Delete FROM [dbo].[Target]
	from [dbo].[ConditionTarget] ct
	inner join [dbo].[Target] t on t.Number = ct.TargetNumber
	 where ct.[ConditionNumber] = @number

	Delete FROM [dbo].[ConditionTarget] where [ConditionNumber] = @number

	Delete FROM [dbo].[Condition] where [Number] = @number

	commit tran t1
END