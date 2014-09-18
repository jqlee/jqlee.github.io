
CREATE PROCEDURE [dbo].[sp_Choice_UpdateSortOrder]
	@sort varchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	
	--declare @sort varchar(100)
	--set @sort = '11,15,12,14,13';
	/*
	select  * 
	from dbo.fnSplit(@sort, ',');
	*/

	update c set c.SortOrder = x.[Index]
	--select c.* ,x.[Index] as NewOrder
	from choice c
	inner join dbo.fnSplit(@sort, ',') x on x.Value = c.Number
	--where c.QuestionNumber = @questionNumber

END

