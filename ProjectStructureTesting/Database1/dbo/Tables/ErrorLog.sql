CREATE TABLE [dbo].[ErrorLog] (
    [Number]         INT            IDENTITY (1, 1) NOT NULL,
    [LogDate]        DATETIME       CONSTRAINT [DF_ErrorLog_LogDate] DEFAULT (getdate()) NULL,
    [Name]           NVARCHAR (50)  NULL,
    [Message]        NVARCHAR (200) NULL,
    [RawUrl]         NVARCHAR (300) NULL,
    [Referrer]       NVARCHAR (300) NULL,
    [HttpStatus]     INT            NULL,
    [ClientIP]       VARCHAR (15)   NULL,
    [InnerException] NVARCHAR (MAX) NULL,
    [StackTrace]     NVARCHAR (MAX) NULL,
    [HasFixed]       BIT            NULL,
    CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED ([Number] ASC)
);

