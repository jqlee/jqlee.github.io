-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecordTarget_UpdateDoneStatusByRecord]
	-- Add the parameters for the stored procedure here
	@recordNumber int
	,@doneStatus bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    -- Insert statements for procedure here
	Update RecordTarget set [Done] = @doneStatus 
	from Record r
	inner join RecordTarget rt on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
	where r.Number = @recordNumber
END
