CREATE TABLE [dbo].[ChoiceScoreTemplate] (
    [Number]       INT            IDENTITY (1, 1) NOT NULL,
    [ConfigNumber] INT            NULL,
    [ChoiceNumber] INT            NULL,
    [Score]        DECIMAL (6, 2) NULL,
    CONSTRAINT [PK_ChoiceScoreTemplate] PRIMARY KEY CLUSTERED ([Number] ASC)
);

