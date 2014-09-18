
CREATE PROCEDURE [dbo].[sp_ViewPermission_Save]
	@publishNumber int
	,@questionNumber int
	,@subsetNumber int
	,@groupingNumber int
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select 0 from [dbo].[ViewPermission] where [PublishNumber] = @publishNumber and [QuestionNumber] = @questionNumber and [SubsetNumber] = @subsetNumber and [GroupingNumber] = @groupingNumber ))
	begin
		 return; 
	end
	else
	begin
		
		Insert into [dbo].[ViewPermission] (
			[PublishNumber], 
			[QuestionNumber], 
			[SubsetNumber], 
			[GroupingNumber]
		) values (
			 @publishNumber, 
			 @questionNumber, 
			 @subsetNumber, 
			 @groupingNumber
		)

	end
END

