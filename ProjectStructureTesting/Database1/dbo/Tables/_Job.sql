CREATE TABLE [dbo].[_Job] (
    [Number]    INT           IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (50) NULL,
    [DataKey]   INT           NULL,
    [Started]   DATETIME      NULL,
    [Completed] DATETIME      NULL,
    CONSTRAINT [PK__Job] PRIMARY KEY CLUSTERED ([Number] ASC)
);

