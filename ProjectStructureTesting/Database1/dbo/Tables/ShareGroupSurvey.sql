CREATE TABLE [dbo].[ShareGroupSurvey] (
    [Number]       INT          IDENTITY (1, 1) NOT NULL,
    [GroupNumber]  INT          NULL,
    [SurveyNumber] INT          NULL,
    [Creator]      VARCHAR (20) NULL,
    CONSTRAINT [PK_ShareGroupSurvey] PRIMARY KEY CLUSTERED ([Number] ASC)
);

