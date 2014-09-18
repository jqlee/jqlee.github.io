CREATE TABLE [dbo].[ScoreMatch] (
    [Number]       INT            IDENTITY (1, 1) NOT NULL,
    [SurveyNumber] INT            NULL,
    [ConfigNumber] INT            NULL,
    [LogNumber]    INT            NULL,
    [MatchKey]     VARCHAR (100)  NULL,
    [MatchName]    NVARCHAR (100) NULL,
    [MemberCount]  INT            NULL,
    [RecordCount]  INT            NULL,
    CONSTRAINT [PK_ScoreMatch] PRIMARY KEY CLUSTERED ([Number] ASC)
);

