
CREATE PROCEDURE [dbo].[sp_Question_UpdateSortOrder]
	@section int = 1
	,@sort varchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	
	--declare @sort varchar(100)
	--set @sort = '11,15,12,14,13';
	/*
	select  * 
	from dbo.fnSplit(@sort, ',');
	*/

	update c set c.Section = @section, c.SortOrder = x.[Index]
	--select c.* ,x.[Index] as NewOrder
	from Question c
	inner join dbo.fnSplit(@sort, ',') x on x.Value = c.Number
	--where c.QuestionNumber = @questionNumber

	--試卷最後更新時間
	--update [SurveyTemplate] set LastModified = getdate() where [Number] = @surveyNumber;

END

