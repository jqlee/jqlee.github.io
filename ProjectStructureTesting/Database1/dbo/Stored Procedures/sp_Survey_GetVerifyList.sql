-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_Survey_GetVerifyList
	-- Add the parameters for the stored procedure here
	@visible bit = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT s.*, m.Name as [OwnerName] from Survey s
	inner join v_Member m on m.Id = s.[Owner]
	where s.StateMark = 2 and s.Visible = @visible
	order by StartDate
END
