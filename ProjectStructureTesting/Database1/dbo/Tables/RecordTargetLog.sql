CREATE TABLE [dbo].[RecordTargetLog] (
    [Number]       INT IDENTITY (1, 1) NOT NULL,
    [TargetNumber] INT NULL,
    [RecordNumber] INT NULL,
    CONSTRAINT [PK_RecordTargetLog] PRIMARY KEY CLUSTERED ([Number] ASC)
);

