-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_QuestionUnit_GetList]
	-- Add the parameters for the stored procedure here
	@publishNumber int
	,@questionNumber int = 0
	,@checkPermission bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if ( @questionNumber = 0 ) set @questionNumber = null;

    -- Insert statements for procedure here
	select q.*
	, Convert(bit, case when vp.PublishNumber is null then 0 else 1 end) as HasPermission
	from PublishSetting ps
	inner join SurveyPaper p on p.PublishNumber = ps.Number and p.PublishVersion = ps.LastPublishVersion
	inner join v_QuestionUnit q on q.SurveyNumber = p.Number
	left outer join [ViewPermission] vp on vp.PublishNumber = ps.Number and vp.QuestionNumber = q.QuestionNumber and vp.SubsetNumber = q.SubsetNumber and vp.GroupingNumber = q.GroupingNumber
	where ps.Number = @publishNumber and q.QuestionNumber = isNull(@questionNumber, q.QuestionNumber)
	and 1 = case 
		when @checkPermission = 1 and vp.QuestionNumber is null then 0 else 1 end
	order by q.AutoId, q.SortOrder, q.SubsetSort, q.GroupingSort

END
/*
declare @publishNumber int = 119
	,@questionNumber int = 1224
	,@checkPermission bit = 1
exec sp_QuestionUnit_GetList @publishNumber ,@questionNumber,@checkPermission
*/