-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetTargetScore]
(	
	-- Add the parameters for the function here
	@targetNumber int
)
RETURNS TABLE 
AS
RETURN 
(
	-- 題組分數是由所有子題得分的平均值，題組標準差也是所有子題標準差的平均值
	select @targetNumber as [TargetNumber], qs.QuestionNumber, qs.Score as Percentage
		,isNull(avg(x.GainAverage),0) as QuestionAverage
		,isNull(avg(x.GainStdevp),0) as QuestionStdevp
	from RecordTarget rt
	inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
	inner join QuestionScore qs on qs.ConfigNumber = rsi.ConfigNumber
	left outer join (
		select rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber
			,count(rqs.Number) as AnswerCount -- 回答次數只對子題有意義
			,avg(rqs.RawScore) as GainAverage 
			,stdevp(rqs.RawScore) as GainStdevp 
		from RecordTarget rt
		left outer join RecordQuestionScore rqs on rqs.TargetNumber = rt.Number
		--inner join RecordScoreIndex rsi on rsi.Number = rt.IndexNumber
		where rt.Number = @targetNumber and rqs.RawScore is not null -- 如果不排除null會出現多餘的分母
		group by rqs.QuestionNumber, rqs.SubsetNumber, rqs.GroupingNumber
	) x
	 on qs.QuestionNumber = x.QuestionNumber
	where rt.Number = @targetNumber
	group by qs.QuestionNumber, qs.Score

)
