
CREATE PROCEDURE [dbo].[sp_ErrorLog_Save]
	@number int
	--,@logDate datetime = null
	,@name nvarchar(50) = null
	,@message nvarchar(200) = null
	,@rawUrl nvarchar(300) = null
	,@referrer nvarchar(300) = null
	,@httpStatus int = null
	,@clientIP varchar(15) = null
	,@innerException nvarchar(MAX) = null
	,@stackTrace nvarchar(MAX) = null
	,@hasFixed bit = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[ErrorLog] where [Number] = @number ))
	begin
		-- 更新時只需要改[HasFixed]欄位
		Update [dbo].[ErrorLog] set 
			--[LogDate] = isNull(@logDate, [LogDate]), 
			--[Message] = isNull(@message, [Message]), 
			--[RawUrl] = isNull(@rawUrl, [RawUrl]), 
			--[Referrer] = isNull(@referrer, [Referrer]), 
			--[HttpStatus] = isNull(@httpStatus, [HttpStatus]), 
			--[ClientIP] = isNull(@clientIP, [ClientIP]), 
			--[StackTrace] = isNull(@stackTrace, [StackTrace]), 
			[HasFixed] = isNull(@hasFixed, [HasFixed])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[ErrorLog] (
			--[Number], 
			--[LogDate], 
			[Name], 
			[Message], 
			[RawUrl], 
			[Referrer], 
			[HttpStatus], 
			[ClientIP], 
			[InnerException], 
			[StackTrace], 
			[HasFixed]
		) values (
			 --@number, 
			 --@logDate, 
			 @name, 
			 @message, 
			 @rawUrl, 
			 @referrer, 
			 @httpStatus, 
			 @clientIP, 
			 @innerException, 
			 @stackTrace, 
			 0 --@hasFixed
		)

	end
END

