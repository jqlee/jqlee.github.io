
CREATE PROCEDURE [dbo].[sp_RecordScoreIndex_Save]
	@number int
	,@configNumber int = null
	,@creator varchar(20) = null
	,@recordCount int = null
	,@guid uniqueidentifier = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[RecordScoreIndex] where [Guid] = @guid ))
	begin
		
		Update [dbo].[RecordScoreIndex] set 
			[ConfigNumber] = isNull(@configNumber, [ConfigNumber]), 
			[Created] = getdate(), 
			[Creator] = isNull(@creator, [Creator]), 
			[RecordCount] = isNull(@recordCount, [RecordCount])
		where [Guid] = @guid

	end
	else
	begin
		
		Insert into [dbo].[RecordScoreIndex] (
			[ConfigNumber], 
			[Creator], 
			[RecordCount],
			[Guid]
		) values (
			 @configNumber, 
			 @creator, 
			 @recordCount,
			 @guid
		)

	end
END

