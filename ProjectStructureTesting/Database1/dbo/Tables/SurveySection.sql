CREATE TABLE [dbo].[SurveySection] (
    [Number]       INT IDENTITY (1, 1) NOT NULL,
    [SurveyNumber] INT CONSTRAINT [DF_SurveySection_SurveyNumber] DEFAULT ((0)) NOT NULL,
    [Sequence]     INT CONSTRAINT [DF_SurveySection_Sequence] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_SurveySection] PRIMARY KEY CLUSTERED ([Number] ASC)
);

