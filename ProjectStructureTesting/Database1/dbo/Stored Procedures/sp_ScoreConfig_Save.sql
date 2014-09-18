
CREATE PROCEDURE [dbo].[sp_ScoreConfig_Save]
	@number int
	,@name nvarchar(50) = null
	,@creator varchar(20) = null
	--,@created datetime = null
	,@paperNumber int = 0
	,@publishNumber int = 0
	--,@surveyId uniqueidentifier = null
	,@enabled bit = null
	,@guid uniqueidentifier = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[ScoreConfig] where [Number] = @number ))
	begin
		
		Update [dbo].[ScoreConfig] set 
			[Name] = isNull(@name, [Name]), 
			[PaperNumber] = @paperNumber, 
			[PublishNumber] = @publishNumber, 
			[Guid] = isNull(@guid,[Guid]),
			[LastModified] = getdate(),
			[Enabled] = isNull(@enabled, [Enabled])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[ScoreConfig] (
			[Name], 
			[PaperNumber],
			[PublishNumber],
			[Guid],
			[Creator], 
			[Created], 
			[Enabled]
		) values (
			 @name, 
			 @paperNumber,
			 @publishNumber,
			 @guid,
			 @creator, 
			 getdate(), 
			 @enabled
		)

	end
END

