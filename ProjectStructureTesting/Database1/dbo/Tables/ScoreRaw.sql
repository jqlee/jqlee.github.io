CREATE TABLE [dbo].[ScoreRaw] (
    [Number]         INT            IDENTITY (1, 1) NOT NULL,
    [MatchKey]       VARCHAR (100)  NULL,
    [MatchFilter]    INT            NULL,
    [LogNumber]      INT            NULL,
    [SurveyNumber]   INT            NULL,
    [ConfigNumber]   INT            CONSTRAINT [DF_ScoreRaw_ConfigNumber] DEFAULT ((0)) NULL,
    [TargetNumber]   INT            NULL,
    [RecordNumber]   INT            NULL,
    [Section]        INT            NULL,
    [QuestionNumber] INT            NULL,
    [SubsetNumber]   INT            NULL,
    [GroupingNumber] INT            NULL,
    [ChoiceNumber]   INT            NULL,
    [PickCount]      INT            CONSTRAINT [DF_ScoreRaw_ChoiceCount] DEFAULT ((0)) NULL,
    [QuestionScore]  DECIMAL (6, 2) CONSTRAINT [DF_ScoreRaw_QuestionScore] DEFAULT ((0)) NULL,
    [ChoiceScore]    DECIMAL (6, 2) CONSTRAINT [DF_ScoreRaw_ChoiceScore] DEFAULT ((0)) NULL,
    [MemberId]       VARCHAR (50)   NULL,
    CONSTRAINT [PK_ScoreRaw] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ScoreRaw_Keys]
    ON [dbo].[ScoreRaw]([SurveyNumber] ASC, [RecordNumber] ASC, [QuestionNumber] ASC, [SubsetNumber] ASC, [GroupingNumber] ASC, [ChoiceNumber] ASC);

