
CREATE PROCEDURE [dbo].[sp_SignOn_GetList]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT *
	FROM [dbo].[v_SignOn]
	where [StatusMark] = 20 and [MemberId] is not null
	order by [BasicRoleValue] desc
END

