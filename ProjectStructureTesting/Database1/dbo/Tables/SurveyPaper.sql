CREATE TABLE [dbo].[SurveyPaper] (
    [Number]           INT              IDENTITY (1, 1) NOT NULL,
    [SchoolId]         VARCHAR (6)      NULL,
    [Title]            NVARCHAR (100)   NULL,
    [Description]      NVARCHAR (MAX)   NULL,
    [Enabled]          BIT              CONSTRAINT [DF_SurveyTemplate_Enabled] DEFAULT ((1)) NULL,
    [Creator]          VARCHAR (20)     NULL,
    [CreatorId]        VARCHAR (20)     NULL,
    [CreatorName]      NVARCHAR (50)    NULL,
    [Created]          DATETIME         NULL,
    [LastModified]     DATETIME         NULL,
    [LastModifierId]   VARCHAR (20)     NULL,
    [LastModifierName] NVARCHAR (50)    NULL,
    [RecycleDate]      DATETIME         NULL,
    [Guid]             UNIQUEIDENTIFIER CONSTRAINT [DF_SurveyTemplate_Guid] DEFAULT (newid()) NOT NULL,
    [IsTemplate]       BIT              CONSTRAINT [DF_SurveyTemplate_IsTemplate] DEFAULT ((1)) NOT NULL,
    [PublishNumber]    INT              NULL,
    [PublishVersion]   SMALLINT         NULL,
    [PublishDate]      DATETIME         NULL,
    [DefaultLangCode]  VARCHAR (2)      NULL,
    CONSTRAINT [PK_SurveyTemplate] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_SurveyPaper_FindByPublish]
    ON [dbo].[SurveyPaper]([PublishNumber] ASC, [PublishVersion] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SurveyPaper_Guid]
    ON [dbo].[SurveyPaper]([Guid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SurveyPaper_Find]
    ON [dbo].[SurveyPaper]([Enabled] ASC, [SchoolId] ASC, [LastModified] DESC);

