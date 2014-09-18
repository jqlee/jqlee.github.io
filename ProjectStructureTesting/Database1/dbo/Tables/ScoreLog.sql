CREATE TABLE [dbo].[ScoreLog] (
    [Number]          INT              IDENTITY (1, 1) NOT NULL,
    [ConfigNumber]    INT              NULL,
    [SurveyNumber]    INT              NULL,
    [Created]         DATETIME         CONSTRAINT [DF_ScoreLog_Created] DEFAULT (getdate()) NULL,
    [Creator]         VARCHAR (20)     NULL,
    [Guid]            UNIQUEIDENTIFIER CONSTRAINT [DF_ScoreLog_Guid] DEFAULT (newid()) NULL,
    [RecordCount]     INT              NULL,
    [ConditionKey]    VARCHAR (20)     NULL,
    [ConditionFilter] INT              NULL,
    CONSTRAINT [PK_ScoreLog] PRIMARY KEY CLUSTERED ([Number] ASC)
);

