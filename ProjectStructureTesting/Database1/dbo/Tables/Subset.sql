CREATE TABLE [dbo].[Subset] (
    [Number]         INT              IDENTITY (1, 1) NOT NULL,
    [Dimension]      INT              CONSTRAINT [DF_Subset_Division] DEFAULT ((1)) NOT NULL,
    [QuestionNumber] INT              NOT NULL,
    [Text]           NVARCHAR (200)   NULL,
    [SortOrder]      TINYINT          NULL,
    [Guid]           UNIQUEIDENTIFIER CONSTRAINT [DF_Subset_Guid] DEFAULT (newid()) NULL,
    CONSTRAINT [PK_Column] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Column]
    ON [dbo].[Subset]([QuestionNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Subset_Sorting]
    ON [dbo].[Subset]([SortOrder] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'平常不會使用，只用在複製時識別用', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Subset', @level2type = N'COLUMN', @level2name = N'Guid';

