CREATE TABLE [dbo].[ScoreConfigTemplate] (
    [Number]       INT              IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (50)    NULL,
    [SurveyNumber] INT              NULL,
    [Creator]      VARCHAR (20)     NULL,
    [Created]      DATETIME         CONSTRAINT [DF_ScoreConfigTemplate_Created] DEFAULT (getdate()) NULL,
    [LastModified] DATETIME         NULL,
    [Enabled]      BIT              CONSTRAINT [DF_ScoreConfigTemplate_Enabled] DEFAULT ((1)) NULL,
    [Guid]         UNIQUEIDENTIFIER CONSTRAINT [DF_ScoreConfigTemplate_Guid] DEFAULT (newid()) NULL,
    CONSTRAINT [PK_ScoreConfigTemplate] PRIMARY KEY CLUSTERED ([Number] ASC)
);

