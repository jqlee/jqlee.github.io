CREATE TABLE [dbo].[StatQuestion] (
    [Number]         INT        IDENTITY (1, 1) NOT NULL,
    [PublishNumber]  INT        NULL,
    [ConfigNumber]   INT        NULL,
    [IndexNumber]    INT        NULL,
    [QuestionNumber] INT        NULL,
    [SubsetNumber]   INT        NULL,
    [GroupingNumber] INT        NULL,
    [SortOrder]      TINYINT    NULL,
    [QuestionSort]   TINYINT    NULL,
    [SubsetSort]     TINYINT    NULL,
    [GroupingSort]   TINYINT    NULL,
    [AnswerCount]    INT        NULL,
    [AverageScore]   FLOAT (53) NULL,
    [StdevpScore]    FLOAT (53) NULL,
    CONSTRAINT [PK_StatQuestion] PRIMARY KEY CLUSTERED ([Number] ASC)
);

