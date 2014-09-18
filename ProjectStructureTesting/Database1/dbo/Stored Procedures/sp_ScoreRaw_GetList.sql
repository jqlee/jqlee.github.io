-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ScoreRaw_GetList]
	-- Add the parameters for the stored procedure here
	@logNumber int = 0,
	@surveyNumber int = 0,
	@targetNumber int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if (@targetNumber =0) set @targetNumber = null;

    -- Insert statements for procedure here
	select mt.MatchKey, mt.MatchName,  mt.MatchFilter, sr.*  
	from fnTargetMatch(@surveyNumber) mt
	left outer join 
	(
		select [TargetNumber], [MatchKey] ,[MatchFilter] --,[Section] ,[QuestionNumber], [SubsetNumber], [GroupingNumber]
		,count(distinct [RecordNumber]) as [RecordCount],avg([ChoiceScore]) as AverageScore, STDEVP([ChoiceScore]) as [StandardDeviation]
		from [dbo].[ScoreRaw]
		where logNumber = @logNumber and [TargetNumber] = isNull(@targetNumber, [TargetNumber])
		group by [TargetNumber], [MatchKey] ,[MatchFilter] --,[Section] ,[QuestionNumber] , [SubsetNumber], [GroupingNumber]
	) sr
		 on sr.[MatchKey] = mt.[MatchKey] and sr.[TargetNumber] = mt.[TargetNumber]
		--inner join v_QuestionUnit q on q.QuestionNumber = sr.QuestionNumber and q.SubsetNumber = sr.SubsetNumber and q.GroupingNumber = sr.groupingNumber
	where mt.[TargetNumber] = isNull(@targetNumber, mt.[TargetNumber])
	order by sr.[MatchKey], sr.[MatchFilter]
END
