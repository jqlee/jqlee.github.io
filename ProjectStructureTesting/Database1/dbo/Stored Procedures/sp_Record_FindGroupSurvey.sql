﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Record_FindGroupSurvey
	-- Add the parameters for the stored procedure here
	@publishNumber int = null
	,@surveyNumber int = null
	,@memberId varchar(20) = null
	,@groupId varchar(20) = null
	,@groupTeacherId varchar(20) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from [Record]
	where [PublishNumber] = @publishNumber and [SurveyNumber] = @surveyNumber
	 and [MemberId] = @memberId and [GroupId] = @groupId and [GroupTeacherId] = @groupTeacherId
END
