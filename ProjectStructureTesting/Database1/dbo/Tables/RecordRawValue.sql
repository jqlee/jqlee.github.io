CREATE TABLE [dbo].[RecordRawValue] (
    [Number]       INT IDENTITY (1, 1) NOT NULL,
    [RawNumber]    INT NULL,
    [ChoiceNumber] INT NULL,
    CONSTRAINT [PK_RawValue] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_RawNumber]
    ON [dbo].[RecordRawValue]([RawNumber] ASC);

