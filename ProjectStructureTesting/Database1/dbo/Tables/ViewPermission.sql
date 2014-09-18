CREATE TABLE [dbo].[ViewPermission] (
    [PublishNumber]  INT NOT NULL,
    [QuestionNumber] INT NOT NULL,
    [SubsetNumber]   INT NOT NULL,
    [GroupingNumber] INT NOT NULL,
    CONSTRAINT [PK_ViewPermission] PRIMARY KEY CLUSTERED ([PublishNumber] ASC, [QuestionNumber] ASC, [SubsetNumber] ASC, [GroupingNumber] ASC)
);

