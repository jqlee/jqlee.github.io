-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Survey_Copy]
	-- Add the parameters for the stored procedure here
	@guid uniqueidentifier = null
	,@owner varchar(2) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if (@guid is null) return;

	--declare @oldNumber int;
	--declare @newNumber int;

	declare @newId varchar(255);
	set @newId = convert(varchar(255),newid());

	exec sp_CopyRow 'Survey','guid', @guid, @newId

	declare @oldNumber varchar(255);
	declare @newNumber varchar(255);

	set @oldNumber = convert(varchar(8),(select top 1 Number from [Survey] where [Guid] = @guid))
	set @newNumber = convert(varchar(8),(select top 1 Number from [Survey] order by [Number] desc))

	exec sp_CopyRow 'Question','SurveyNumber',@oldNumber ,@newNumber

	insert into [Subset] ([Dimension],[QuestionNumber],[Text],[SortOrder])
	select s.Dimension, q2.Number as QuestionNumber, s.[Text],s.[SortOrder]
	from Question q 
	inner join Subset s on s.QuestionNumber = q.Number
	inner join Question q2 on q2.[Guid] = q.[Guid] and q2.SurveyNumber = @newNumber
	where q.SurveyNumber = @oldNumber
	
	insert into [Choice] ([QuestionNumber],[Text],[SortOrder])
	select q2.Number as QuestionNumber, c.[Text],c.[SortOrder]
	from Question q 
	inner join Choice c on c.QuestionNumber = q.Number
	inner join Question q2 on q2.[Guid] = q.[Guid] and q2.SurveyNumber = @newNumber
	where q.SurveyNumber = @oldNumber
	
	--@newNumber	

END
