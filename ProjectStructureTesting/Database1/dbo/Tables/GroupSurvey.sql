CREATE TABLE [dbo].[GroupSurvey] (
    [GroupId]      VARCHAR (20) NOT NULL,
    [SurveyNumber] INT          NOT NULL,
    CONSTRAINT [PK_GroupSurvey] PRIMARY KEY CLUSTERED ([GroupId] ASC, [SurveyNumber] ASC)
);

