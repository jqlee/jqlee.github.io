-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION dbo.fnCheckPublishAbailable
(
	-- Add the parameters for the function here
	@publishNumber int = 0
)
RETURNS bit
AS
BEGIN
	declare @b bit = 0

	if exists(select 0 from PublishSetting ps
		inner join SurveyPaper sp on sp.PublishNumber = ps.[Number] and sp.PublishVersion = ps.LastPublishVersion
		where ps.[Number] = @publishNumber
		and ps.[Enabled] = 1 and ps.[IsPublished] = 1
		and getdate() between ps.OpenDate and ps.CloseDate)
	set @b = 1

	return @b;

END
