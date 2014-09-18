CREATE TABLE [dbo].[QuestionScore] (
    [Number]         INT            IDENTITY (1, 1) NOT NULL,
    [ConfigNumber]   INT            NULL,
    [QuestionNumber] INT            NULL,
    [Score]          DECIMAL (6, 2) NULL,
    CONSTRAINT [PK_QuestionScore] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_QuestionScore_ConfigNumber]
    ON [dbo].[QuestionScore]([ConfigNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_QuestionScore_QuestionNumber]
    ON [dbo].[QuestionScore]([QuestionNumber] ASC);

