CREATE TABLE [dbo].[RecordRaw] (
    [Number]          INT            IDENTITY (1, 1) NOT NULL,
    [RecordNumber]    INT            NULL,
    [QuestionNumber]  INT            NULL,
    [SubsetNumber]    INT            NULL,
    [GroupingNumber]  INT            NULL,
    [AnswerText]      NVARCHAR (MAX) NULL,
    [AnswerValue]     TINYINT        NULL,
    [ChooseCount]     TINYINT        CONSTRAINT [DF_RecordRaw_ChooseCount] DEFAULT ((0)) NULL,
    [TempChoiceValue] INT            NULL,
    CONSTRAINT [PK_RawData] PRIMARY KEY CLUSTERED ([Number] ASC),
    CONSTRAINT [FK_RecordRaw_Record] FOREIGN KEY ([RecordNumber]) REFERENCES [dbo].[Record] ([Number])
);


GO
CREATE NONCLUSTERED INDEX [IX_RecordRaw_Find]
    ON [dbo].[RecordRaw]([RecordNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RecordRaw_Filter]
    ON [dbo].[RecordRaw]([QuestionNumber] ASC, [SubsetNumber] ASC, [GroupingNumber] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'表示"等級"這類無選項的答案', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecordRaw', @level2type = N'COLUMN', @level2name = N'AnswerValue';

