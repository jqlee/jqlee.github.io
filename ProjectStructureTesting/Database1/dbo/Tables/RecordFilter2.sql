CREATE TABLE [dbo].[RecordFilter2] (
    [Number]       INT          IDENTITY (1, 1) NOT NULL,
    [RecordNumber] INT          NULL,
    [FilterNumber] INT          NULL,
    [FilterValue]  VARCHAR (50) NULL,
    CONSTRAINT [PK_RecordFilter] PRIMARY KEY CLUSTERED ([Number] ASC)
);

