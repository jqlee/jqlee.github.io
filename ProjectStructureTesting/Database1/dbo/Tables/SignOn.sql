CREATE TABLE [dbo].[SignOn] (
    [SignOnId]    INT          IDENTITY (1, 1) NOT NULL,
    [sessionid]   VARCHAR (50) NULL,
    [man_no]      VARCHAR (20) NULL,
    [course_no]   VARCHAR (30) NULL,
    [createdate]  DATETIME     NULL,
    [s_man_no]    VARCHAR (20) NULL,
    [man_user]    CHAR (4)     NULL,
    [signon_mark] TINYINT      NULL,
    CONSTRAINT [PK_ican5_SignOn] PRIMARY KEY CLUSTERED ([SignOnId] ASC)
);

