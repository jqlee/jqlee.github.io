CREATE TABLE [dbo].[_DebugLog] (
    [Number]       INT           IDENTITY (1, 1) NOT NULL,
    [Category]     NVARCHAR (50) NULL,
    [DataKey]      INT           NULL,
    [RecordCount]  INT           NULL,
    [StartDate]    DATETIME      NULL,
    [CompleteDate] DATETIME      NULL,
    CONSTRAINT [PK__DebugLog] PRIMARY KEY CLUSTERED ([Number] ASC)
);

