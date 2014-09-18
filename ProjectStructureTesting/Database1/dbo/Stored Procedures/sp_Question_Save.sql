
CREATE PROCEDURE [dbo].[sp_Question_Save]
	@number int
	,@surveyNumber int = null
	,@section int = 1 --分區
	,@title nvarchar(max) = null
	,@description nvarchar(max) = null
	/*
	,@numberOfItem int = null
	,@isJoined bit = null
	,@isVerticalDirection bit = null
	,@hasOther bit = null
	,@page int = null
	,@isRequired bit = null
	,@chooseMax int = null
	,@parentNumber int = null
	,@percentage int = null
	*/
	--,@sortOrder int = null
	,@sequence int = null
	,@guid uniqueidentifier = null
	--,@minimumSelected int,@maxmumSelected int,@isDropDownList bit,@isMultipleSelection bit
	,@optionDisplayType tinyint = 0 --類型
	,@optionIsVerticalList bit = 0
	,@optionDisplayPerRow tinyint = 0
	,@optionMultipleSelection bit = 0 
	,@optionLimitMin tinyint = 0
	,@optionLimitMax tinyint = 0
	,@optionDisplayLines tinyint = 1
	,@optionIsRequired bit = 0
	,@optionLabelLeft nvarchar(50) = null
	,@optionLabelRight nvarchar(50) = null
	,@optionLevelStart tinyint = 1
	,@optionLevelEnd tinyint = 5
	,@optionShowOther bit = 0
	,@optionAppendToChoice bit = 0
	,@optionOtherLabel nvarchar(50) = null
	,@overwriteIfExists bit = 1
AS
BEGIN
	SET NOCOUNT ON;

	if (@overwriteIfExists = 1 and exists(select * from [dbo].[Question] where [Number] = @number ))
	begin
		
		Update [dbo].[Question] set 
			[SurveyNumber] = isNull(@surveyNumber, [SurveyNumber]), 
			[Section] = @section,
			[Title] = isNull(@title, [Title]), 
			[Description] = isNull(@description, [Description]), 
			[Sequence] = isNull(@sequence, [Sequence]), 
			--[SortOrder] = isNull(@sortOrder, [SortOrder]), 
			[Guid] = ISNULL(@guid,[Guid])
			,[OptionDisplayType] = isNull(@optionDisplayType,[OptionDisplayType])
			,[OptionIsVerticalList] = isNull(@optionIsVerticalList, [OptionIsVerticalList])
			,[OptionDisplayPerRow] = isNull(@optionDisplayPerRow,[OptionDisplayPerRow])
			,[OptionMultipleSelection] = isNull(@optionMultipleSelection,[OptionMultipleSelection])
			,[OptionLimitMin] = isNull(@optionLimitMin,[OptionLimitMin])
			,[OptionLimitMax] = isNull(@optionLimitMax,[OptionLimitMax])
			,[OptionDisplayLines] = isNull(@optionDisplayLines,[OptionDisplayLines])
			,[OptionIsRequired] = isNull(@optionIsRequired,[OptionIsRequired])
			,[OptionLabelLeft] = isNull(@optionLabelLeft,[OptionLabelLeft])
			,[OptionLabelRight] = isNull(@optionLabelRight,[OptionLabelRight])
			,[OptionLevelStart] = isNull(@optionLevelStart,[OptionLevelStart])
			,[OptionLevelEnd] = isNull(@optionLevelEnd,[OptionLevelEnd])
			,[OptionShowOther] = isNull(@optionShowOther,[OptionShowOther])
			,[OptionAppendToChoice] = isNull(@optionAppendToChoice,[OptionAppendToChoice])
			,[OptionOtherLabel] = @optionOtherLabel --這一欄傳null進來表示要清掉
		where [Number] = @number 

	end
	else
	begin
		--每次新增時都去取該Section最後一個SortOrder+1，做為新題目的SortOrder
		declare @lastSort int;
		select @lastSort = isNull(max([SortOrder]),0) from Question where [SurveyNumber] = @surveyNumber and [Section] = @section;


		Insert into [dbo].[Question] (
			[SurveyNumber], 
			[Section],
			[Title], 
			[Description], 
			[Sequence], 
			[Guid],
			[SortOrder]
			,[OptionDisplayType],[OptionIsVerticalList],[OptionDisplayPerRow],[OptionMultipleSelection],[OptionLimitMin],[OptionLimitMax],[OptionDisplayLines],[OptionIsRequired],[OptionLabelLeft],[OptionLabelRight],[OptionLevelStart],[OptionLevelEnd],[OptionShowOther],[OptionAppendToChoice],[OptionOtherLabel]
		) values (
			 @surveyNumber, 
			 @section,
			 @title, 
			 @description, 
			 @sequence, 
			 @guid,
			 @lastSort+1
			 ,@optionDisplayType,@optionIsVerticalList,@optionDisplayPerRow,@optionMultipleSelection,@optionLimitMin,@optionLimitMax,@optionDisplayLines,@optionIsRequired,@optionLabelLeft,@optionLabelRight,@optionLevelStart,@optionLevelEnd,@optionShowOther,@optionAppendToChoice,@optionOtherLabel
		)

	end

	--試卷最後更新時間
	update [SurveyPaper] set LastModified = getdate() where [Number] = @surveyNumber;

END


