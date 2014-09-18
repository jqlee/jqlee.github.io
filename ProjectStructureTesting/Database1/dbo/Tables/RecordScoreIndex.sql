CREATE TABLE [dbo].[RecordScoreIndex] (
    [Number]       INT              IDENTITY (1, 1) NOT NULL,
    [ConfigNumber] INT              NULL,
    [Created]      DATETIME         CONSTRAINT [DF_RecordScoreIndex_Created] DEFAULT (getdate()) NULL,
    [Creator]      VARCHAR (20)     NULL,
    [RecordCount]  INT              NULL,
    [Guid]         UNIQUEIDENTIFIER CONSTRAINT [DF_RecordScoreIndex_Guid] DEFAULT (newid()) NULL,
    [Enabled]      BIT              CONSTRAINT [DF_RecordScoreIndex_Enabled] DEFAULT ((1)) NULL,
    [IsPublished]  BIT              CONSTRAINT [DF_RecordScoreIndex_IsPublished] DEFAULT ((0)) NULL,
    [Done]         BIT              CONSTRAINT [DF_RecordScoreIndex_Done] DEFAULT ((0)) NULL,
    [DisableDate]  DATETIME         NULL,
    CONSTRAINT [PK_RecordScoreIndex] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_RecordScoreIndex_Guid]
    ON [dbo].[RecordScoreIndex]([Guid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RecordScoreIndex_Find]
    ON [dbo].[RecordScoreIndex]([ConfigNumber] ASC, [Enabled] ASC);

