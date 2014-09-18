CREATE TABLE [dbo].[ScoreConfig] (
    [Number]        INT              IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (50)    NULL,
    [PaperNumber]   INT              NULL,
    [PublishNumber] INT              NULL,
    [SurveyIdx]     UNIQUEIDENTIFIER NULL,
    [Creator]       VARCHAR (20)     NULL,
    [Created]       DATETIME         CONSTRAINT [DF_ScoreConfig_Created] DEFAULT (getdate()) NULL,
    [LastModified]  DATETIME         NULL,
    [Enabled]       BIT              CONSTRAINT [DF_ScoreConfig_Enabled] DEFAULT ((1)) NULL,
    [Guid]          UNIQUEIDENTIFIER CONSTRAINT [DF_ScoreConfig_Guid] DEFAULT (newid()) NULL,
    [IsTemplate]    BIT              NULL,
    CONSTRAINT [PK_ScoreConfig] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ScoreConfig_Creator]
    ON [dbo].[ScoreConfig]([Creator] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ScoreConfig_Enabled]
    ON [dbo].[ScoreConfig]([Enabled] ASC, [Created] ASC);

