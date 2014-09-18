CREATE TABLE [dbo].[RecordLog] (
    [Number]       INT            IDENTITY (1, 1) NOT NULL,
    [SurveyNumber] INT            NULL,
    [RecordNumber] INT            NULL,
    [ItemNumber]   INT            NULL,
    [TextAnswer]   NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_RecordLog] PRIMARY KEY CLUSTERED ([Number] ASC)
);

