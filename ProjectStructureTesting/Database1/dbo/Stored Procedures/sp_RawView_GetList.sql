-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_RawView_GetList]
	-- Add the parameters for the stored procedure here
	@surveyNumber int 
	,@questionNumber int=0
	,@memberId varchar(20) = null
AS
BEGIN
	SET NOCOUNT ON;


if (@questionNumber = 0) set @questionNumber = null;
     
select w.[QuestionNumber], ss.Number as [SubsetNumber], sg.Number as [GroupingNumber]
, r.Number as [RecordNumber], r.MemberId,r.MemberName
,v.[ChoiceNumber]
, q.Title, ss.Text as [SubsetText], sg.Text as [GroupingText]
, c.Text as [ChoiceText]
from 
Record r
inner join RecordRaw w on w.RecordNumber = r.Number
inner join RecordRawValue v on v.RawNumber = w.Number

inner join Question q on q.Number = w.QuestionNumber
left outer join Subset ss on ss.QuestionNumber = w.QuestionNumber and ss.Number = w.SubsetNumber and ss.Dimension = 1
left outer join Subset sg on sg.QuestionNumber = w.QuestionNumber and sg.Number = w.GroupingNumber and sg.Dimension = 2
inner join [Choice] c on c.Number = v.ChoiceNumber

where r.SurveyNumber = @surveyNumber
 and w.QuestionNumber = isNull(@questionNumber,w.QuestionNumber)
 and r.MemberId = isNull(@memberId,r.MemberId)

order by r.Number,w.[QuestionNumber],w.[SubsetNumber],w.[GroupingNumber]
END
