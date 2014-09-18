CREATE TABLE [dbo].[ScoreResult] (
    [Number]            INT          IDENTITY (1, 1) NOT NULL,
    [LogNumber]         INT          NULL,
    [MatchKey]          VARCHAR (20) NULL,
    [MatchFilter]       INT          NULL,
    [SurveyNumber]      INT          NULL,
    [QuestionNumber]    INT          NULL,
    [AverageScore]      FLOAT (53)   NULL,
    [StandardDeviation] FLOAT (53)   NULL,
    [QuestionRatio]     FLOAT (53)   NULL,
    [FinalScore]        FLOAT (53)   NULL,
    CONSTRAINT [PK_ScoreResult] PRIMARY KEY CLUSTERED ([Number] ASC)
);

