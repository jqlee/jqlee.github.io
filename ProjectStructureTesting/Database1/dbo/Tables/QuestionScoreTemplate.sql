CREATE TABLE [dbo].[QuestionScoreTemplate] (
    [Number]         INT              IDENTITY (1, 1) NOT NULL,
    [ConfigNumber]   INT              NULL,
    [QuestionNumber] INT              NULL,
    [Score]          DECIMAL (6, 2)   NULL,
    [ConfigGuid]     UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_QuestionScoreTemplate] PRIMARY KEY CLUSTERED ([Number] ASC)
);

