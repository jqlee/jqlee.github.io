-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp__]
	-- Add the parameters for the stored procedure here
	@publishGuid uniqueidentifier
	, @maxCount int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @publishNumber int;

	select @publishNumber = [Number] from PublishSetting where [Guid] = @publishGuid
    
	begin tran t1
		-- Insert statements for procedure here
	-- exec sp__GenerateUncompletedRecord 114
	exec sp__GenerateUncompletedRecord @publishNumber, @maxCount

	exec sp__GenerateUncompletedRecordAnswers @publishNumber

	update Record set Done = 1
	,Created = dateadd(minute, -1000*RAND(HASHBYTES('md5',cast([Number]  as varchar))) ,Created)
	,LastAccessTime = dateadd(minute, -1000*RAND(HASHBYTES('md5',cast([Number]  as varchar))) ,LastAccessTime)
	where PublishNumber = @publishNumber and Done = 0

	commit tran t1
END
