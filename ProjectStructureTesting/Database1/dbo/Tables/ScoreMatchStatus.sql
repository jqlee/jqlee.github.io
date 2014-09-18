CREATE TABLE [dbo].[ScoreMatchStatus] (
    [Number]          INT            IDENTITY (1, 1) NOT NULL,
    [SurveyNumber]    INT            NULL,
    [LogNumber]       INT            NULL,
    [TargetNumber]    INT            NULL,
    [ConditionKey]    VARCHAR (20)   NULL,
    [ConditionFilter] VARCHAR (20)   NULL,
    [MatchKey]        VARCHAR (50)   NULL,
    [MatchName]       NVARCHAR (200) NULL,
    [MatchFilter]     INT            NULL,
    [FilterName]      NVARCHAR (20)  NULL,
    [MemberCount]     INT            NULL,
    [RecordCount]     INT            NULL,
    CONSTRAINT [PK_ScoreMatchStatus] PRIMARY KEY CLUSTERED ([Number] ASC)
);

