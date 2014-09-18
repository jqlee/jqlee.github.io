
CREATE PROCEDURE [dbo].[sp_PublishSetting_Save]
	@number int
	--,@period varchar(6) = null
	,@periodYear smallint = null
	,@periodSeme tinyint = null
	,@name nvarchar(50) = null
	,@description nvarchar(200) = null
	,@targetMark tinyint = null
	,@surveyNumber int = null
	,@doneMessage nvarchar(200) = null
	,@openDate datetime = null
	,@closeDate datetime = null
	,@queryDate datetime = null
	--,@lastModified datetime = null
	,@lastModifierId varchar(20) = null
	,@lastModifierName nvarchar(50) = null
	,@creator varchar(20) = null
	,@creatorName nvarchar(50) = null
	,@guid uniqueidentifier = null
	,@enabled bit = 0
	,@isTemporary bit = 0
	,@isPublished bit = 0
	,@isPaused bit = 0
	,@isVerified bit = null
	,@verifierId varchar(20) = null
	,@verifierName nvarchar(50) = null
	,@templateId uniqueidentifier = null
	,@scoreConfigNumber int = null
	,@isDoneProperty bit = 0
	,@isDoneConfig bit = 0
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[PublishSetting] where [Number] = @number ))
	begin
		
		Update [dbo].[PublishSetting] set 
			--[Period] = isNull(@period, [Period]), 
			[PeriodYear] = isNull(@periodYear, [PeriodYear]), 
			[PeriodSeme] = isNull(@periodSeme, [PeriodSeme]), 
			[Period] = right('00'+convert(varchar, @periodYear),4) + convert(varchar,@periodSeme), --convert(varchar, @periodYear) + convert(varchar,@periodSeme),
			[Name] = isNull(@name, [Name]), 
			[Description] = isNull(@description, [Description]), 
			[TargetMark] = isNull(@targetMark, [TargetMark]), 
			[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			[DoneMessage] = isNull(@doneMessage, [DoneMessage]), 
			[OpenDate] = isNull(@openDate, [OpenDate]), 
			[CloseDate] = isNull(@closeDate, [CloseDate]), 
			--[QueryDate] = isNull(@queryDate, [QueryDate]), 
			[QueryDate] = @queryDate, -- nullable
			--[LastModified] = isNull(@lastModified, [LastModified]), 
			[LastModified] = getdate(),
			[LastModifierId] = ISNULL(@lastModifierId, [LastModifierId]),
			[LastModifierName] = ISNULL(@lastModifierName, [LastModifierName]),
			[Creator] = isNull(@creator, [Creator]),
			[Enabled] = @enabled, 
			[IsTemporary] = @isTemporary,
			[IsPublished] = @isPublished, 
			[IsPaused] = @isPaused,
			[IsVerified] = isNull(@isVerified, [IsVerified]), 
			[VerifierId] = isNull(@verifierId, [VerifierId]), 
			[VerifierName] = isNull(@verifierName, [VerifierName]),
			[TemplateId] = isNull(@templateId, [TemplateId]),
			[IsDoneProperty] = @isDoneProperty,
			[IsDoneConfig] = @isDoneConfig,
			[ScoreConfigNumber] = isNull(@scoreConfigNumber, [ScoreConfigNumber])
		where [Number] = @number 

	end
	else
	begin
		-- remove old temporary
		delete from PublishSetting where [Enabled] = 0 and [IsTemporary] = 1 and LastModified < DateAdd(d, -7, getdate());

		Insert into [dbo].[PublishSetting] (
			[PeriodYear], 
			[PeriodSeme], 
			[Period],
			[Name], 
			[Description], 
			[TargetMark], 
			[SurveyNumber], 
			[DoneMessage], 
			[OpenDate], 
			[CloseDate], 
			[QueryDate], 
			[LastModified], 
			[Creator],
			[CreatorName],
			[Guid],
			[Enabled],
			[IsTemporary],
			[IsPublished],
			[IsPaused],
			[IsVerified], 
			[VerifierId], 
			[VerifierName],
			[TemplateId],
			[IsDoneProperty],
			[IsDoneConfig],
			[ScoreConfigNumber]
		) values (
			 @periodYear, 
			 @periodSeme, 
			  right('00'+convert(varchar, @periodYear),4) + convert(varchar,@periodSeme), --convert(varchar, @periodYear) + convert(varchar,@periodSeme),
			 @name, 
			 @description, 
			 @targetMark, 
			 @surveyNumber, 
			 @doneMessage, 
			 @openDate, 
			 @closeDate, 
			 @queryDate, 
			 getdate(), 
			 @creator,
			 @creatorName,
			 @guid,
			 @enabled,
			 @isTemporary,
			 @isPublished,
			 @isPaused,
			 @isVerified, 
			 @verifierId, 
			 @verifierName,
			 @templateId,
			 @isDoneProperty,
			 @isDoneConfig,
			 @scoreConfigNumber
		)

	end
END

