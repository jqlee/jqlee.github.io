-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[sp_SignOn_CreateBySpecificGuid]
	-- Add the parameters for the stored procedure here
	@memberId varchar(20)
	,@guid uniqueidentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into SignOn (sessionid, man_no, createdate, man_user, signon_mark)
	values (
		Lower(replace(@guid,'-','')), @memberId, getdate(), '1000', '20'  -- manuser隨便填
	)
END
