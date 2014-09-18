
CREATE PROCEDURE [dbo].[sp_ErrorLog_GetList]
	@keyword nvarchar(max) = null
	,@needFixedChecked bit = null --nullable boolean
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM [dbo].[ErrorLog]
	where 1 = case when @keyword is null then 1
		when [RawUrl] like '%' + @keyword + '%' then 1
		when [Referrer] like '%' + @keyword + '%' then 1
		when [Message] like '%' + @keyword + '%' then 1
		else 0
		end
	 and [HasFixed] = isNull(@needFixedChecked,[HasFixed])
	order by [LogDate] desc
END
