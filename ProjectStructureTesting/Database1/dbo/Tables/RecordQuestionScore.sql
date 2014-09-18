CREATE TABLE [dbo].[RecordQuestionScore] (
    [Number]               INT        IDENTITY (1, 1) NOT NULL,
    [IndexNumber]          INT        NULL,
    [TargetNumber]         INT        NULL,
    [RecordNumber]         INT        NULL,
    [QuestionNumber]       INT        NULL,
    [SubsetNumber]         INT        NULL,
    [GroupingNumber]       INT        NULL,
    [SelectedChoiceNumber] INT        NULL,
    [RawScore]             FLOAT (53) NULL,
    [QuestionScoreSetting] FLOAT (53) NULL,
    [QuestionItemCount]    TINYINT    NULL,
    CONSTRAINT [PK_RecordQuestionScore] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_RecordQuestionScore_Find]
    ON [dbo].[RecordQuestionScore]([RecordNumber] ASC, [QuestionNumber] ASC, [SubsetNumber] ASC, [GroupingNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RecordQuestionScore_IndexAndScore]
    ON [dbo].[RecordQuestionScore]([IndexNumber] ASC, [RawScore] ASC)
    INCLUDE([Number], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber], [QuestionScoreSetting], [QuestionItemCount]);


GO
CREATE NONCLUSTERED INDEX [IX_RecordQuestionScore_RawScore]
    ON [dbo].[RecordQuestionScore]([RawScore] ASC)
    INCLUDE([Number], [IndexNumber], [RecordNumber], [QuestionNumber], [SubsetNumber], [GroupingNumber], [QuestionScoreSetting], [QuestionItemCount]);


GO
CREATE NONCLUSTERED INDEX [IX_RecordQuestionScore_Filter]
    ON [dbo].[RecordQuestionScore]([TargetNumber] ASC, [QuestionNumber] ASC)
    INCLUDE([SubsetNumber], [GroupingNumber], [RawScore]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'此項是對應RecordTarget.Number，而非PublishTarget.Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecordQuestionScore', @level2type = N'COLUMN', @level2name = N'TargetNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'該題配分乘上比例', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecordQuestionScore', @level2type = N'COLUMN', @level2name = N'RawScore';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'該題組的項數，等於子集乘上分組', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecordQuestionScore', @level2type = N'COLUMN', @level2name = N'QuestionItemCount';

