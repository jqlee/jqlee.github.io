
CREATE PROCEDURE [dbo].[sp_Survey_Save]
	@number int = 0
	,@name nvarchar(50) = null
	,@title nvarchar(100) = null
	,@description nvarchar(max) = null
	,@isEnableHtml bit = null
	,@startDate datetime = null
	,@endDate datetime = null
	,@totalReturn int = null
	,@resultOpen bit = null
	,@pageCount int = null
	,@stateMark tinyint = null
	,@enabled bit = 1
	,@visible bit = 1
	,@creator varchar(20) = null
	,@owner varchar(20) = null
	,@ownerName nvarchar(50) = null
	,@creatorName nvarchar(20) = null
	,@lastModifier varchar(20) = null
	,@lastModifierName nvarchar(20) = null
	,@canAnswerTimes int = null
	,@language varchar(10) = null
	,@guid uniqueidentifier = null
	,@createItemType char(1) = null
	,@createItemNumber varchar(500) = null
	,@groupOnly bit = null
	,@groupId varchar(20) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;
	if (@ownerName is null and @owner is not null) 
		select @ownerName = m.Name from  v_Member m where m.Id = @owner

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Survey] where [Number] = @number ))
	begin
		
		Update [dbo].[Survey] set 
			[Name] = isNull(@name, [Name]), 
			[Title] = isNull(@title, [Title]), 
			[Description] = isNull(@description, [Description]), 
			[IsEnableHtml] = isNull(@isEnableHtml, [IsEnableHtml]), 
			[StartDate] = isNull(@startDate, [StartDate]), 
			[EndDate] = isNull(@endDate, [EndDate]), 
			[TotalReturn] = isNull(@totalReturn, [TotalReturn]), 
			[ResultOpen] = isNull(@resultOpen, [ResultOpen]), 
			[PageCount] = isNull(@pageCount, [PageCount]), 
			[StateMark] = isNull(@stateMark, [StateMark]), 
			[Enabled] = isNull(@enabled, 1), 
			[Visible] = @visible,
			--[Creator] = isNull(@creator, [Creator]), 
			[Owner] = isNull(@owner, [Owner]),
			[OwnerName] = isNull(@ownerName, [OwnerName]),
			[CreatorName] = isNull(@creatorName, [CreatorName]), 
			[LastModified] = getdate(), 
			[LastModifier] = isNull(@lastModifier, [LastModifier]), 
			[LastModifierName] = isNull(@lastModifierName, [LastModifierName]), 
			[CanAnswerTimes] = isNull(@canAnswerTimes, [CanAnswerTimes]), 
			[Language] = isNull(@language, [Language]), 
			--[Guid] = isNull(@guid, [Guid]), 
			[CreateItemType] = isNull(@createItemType, [CreateItemType]), 
			[CreateItemNumber] = isNull(@createItemNumber, [CreateItemNumber]),
			[GroupOnly] = isNull(@groupOnly, [GroupOnly]),
			[GroupId] = isNull(@groupId,[GroupId])
		where [Number] = @number 

	end
	else
	begin
		
		Insert into [dbo].[Survey] (
			[Name], 
			[Title], 
			[Description], 
			[IsEnableHtml], 
			[StartDate], 
			[EndDate], 
			[TotalReturn], 
			[ResultOpen], 
			[PageCount], 
			[StateMark], 
			[Enabled],
			[Visible],
			[Creator], 
			[Owner],
			[OwnerName],
			[Created], 
			[CreatorName], 
			[LastModifier], 
			[LastModifierName], 
			[CanAnswerTimes], 
			[Language], 
			[Guid], 
			[CreateItemType], 
			[CreateItemNumber],
			[GroupOnly],
			[GroupId]
		) values (
			 @name, 
			 @title, 
			 @description, 
			 @isEnableHtml, 
			 @startDate, 
			 @endDate, 
			 @totalReturn, 
			 @resultOpen, 
			 @pageCount, 
			 @stateMark, 
			 @enabled, 
			 1,
			 @creator, 
			 @owner,
			 @ownerName,
			 getdate(), 
			 @creatorName, 
			 @lastModifier, 
			 @lastModifierName, 
			 @canAnswerTimes, 
			 @language, 
			 @guid, 
			 @createItemType, 
			 @createItemNumber,
			 @groupOnly,
			 @groupId
		)

	end
END




select * from Survey where [owner] =  'yechen'