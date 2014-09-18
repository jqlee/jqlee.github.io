-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SurveyTarget_GetListForGroup]
	-- Add the parameters for the stored procedure here
	@number int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		select 2 as [TargetMark], t.[SurveyNumber], t.[Name], 0 as [MemberCount]
		from [Survey] s
			inner join [TargetDepartmentGroup] t on t.[SurveyNumber] = s.[Number]
		where s.[Number] = @number
		union 
		Select 3 as [TargetMark], t.[SurveyNumber], t.[Name], 0 as [MemberCount]
		from [Survey] s
			inner join [TargetGroupMember] t on t.[SurveyNumber] = s.[Number]
		where s.[Number] = @number

END
