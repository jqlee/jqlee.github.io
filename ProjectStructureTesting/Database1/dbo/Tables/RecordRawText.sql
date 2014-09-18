CREATE TABLE [dbo].[RecordRawText] (
    [Number]       INT            IDENTITY (1, 1) NOT NULL,
    [RawNumber]    INT            NULL,
    [ChoiceNumber] INT            NULL,
    [Text]         NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_RecordRawText] PRIMARY KEY CLUSTERED ([Number] ASC)
);

