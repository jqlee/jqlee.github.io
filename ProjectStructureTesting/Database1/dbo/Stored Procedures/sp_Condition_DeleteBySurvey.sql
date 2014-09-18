
CREATE PROCEDURE [dbo].[sp_Condition_DeleteBySurvey]
	@surveyNumber int
AS
BEGIN
	SET NOCOUNT ON;
	
	begin tran t1

	Delete from [Target]
	 from Condition c
	inner join ConditionTarget ct on ct.ConditionNumber = c.Number
	inner join [Target] t on t.Number = ct.TargetNumber
	where c.SurveyNumber = @surveyNumber

	Delete from [ConditionTarget]
	 from Condition c
	inner join ConditionTarget ct on ct.ConditionNumber = c.Number
	where c.SurveyNumber = @surveyNumber

	Delete from Condition where SurveyNumber = @surveyNumber;

	commit tran t1
END


/*
declare @surveyNumber int = 1251


select * from Condition where SurveyNumber = @surveyNumber

select ct.* from Condition c 
	inner join ConditionTarget ct on ct.ConditionNumber = c.Number
	where c.SurveyNumber = @surveyNumber

select t.* from Condition c
	inner join ConditionTarget ct on ct.ConditionNumber = c.Number
	inner join Target t on t.Number = ct.TargetNumber
	where c.SurveyNumber = @surveyNumber

select * from Condition where SurveyNumber = @surveyNumber


	Delete from [Target]
	from [Target] t
	inner join [ConditionTarget] ct on ct.TargetNumber = t.Number
	inner join [Condition] ct on ct.TargetNumber = t.Number
	where ct.SurveyNumber = @surveyNumber;




*/