CREATE TABLE [dbo].[Question] (
    [Number]                         INT              IDENTITY (1, 1) NOT NULL,
    [SurveyNumber]                   INT              NULL,
    [Section]                        INT              CONSTRAINT [DF_Question_Section] DEFAULT ((1)) NULL,
    [Title]                          NVARCHAR (200)   NULL,
    [Text]                           NVARCHAR (MAX)   NULL,
    [Description]                    NVARCHAR (MAX)   NULL,
    [Sequence]                       INT              NULL,
    [Page]                           INT              NULL,
    [IsRequired]                     BIT              NULL,
    [Guid]                           UNIQUEIDENTIFIER NULL,
    [SortOrder]                      TINYINT          CONSTRAINT [DF_Question_SortOrder] DEFAULT ((1)) NULL,
    [Skipable]                       BIT              CONSTRAINT [DF_Question_Skipable] DEFAULT ((0)) NULL,
    [SkipText]                       NVARCHAR (50)    NULL,
    [GenerateChoiceFromAcceptedText] BIT              NULL,
    [OptionDisplayType]              TINYINT          CONSTRAINT [DF_Question_OptionDisplayType] DEFAULT ((1)) NULL,
    [OptionIsVerticalList]           BIT              CONSTRAINT [DF_Question_OptionIsVerticalList] DEFAULT ((0)) NULL,
    [OptionDisplayPerRow]            TINYINT          CONSTRAINT [DF_Question_OptionDisplayPerRow] DEFAULT ((0)) NULL,
    [OptionMultipleSelection]        BIT              CONSTRAINT [DF_Question_OptionMultipleSelection] DEFAULT ((0)) NULL,
    [OptionLimitMin]                 TINYINT          CONSTRAINT [DF_Question_OptionLimitMin] DEFAULT ((0)) NULL,
    [OptionLimitMax]                 TINYINT          CONSTRAINT [DF_Question_OptionLimitMax] DEFAULT ((0)) NULL,
    [OptionDisplayLines]             TINYINT          CONSTRAINT [DF_Question_OptionDisplayLines] DEFAULT ((1)) NULL,
    [OptionIsRequired]               BIT              CONSTRAINT [DF_Question_OptionIsRequired] DEFAULT ((0)) NULL,
    [OptionLabelLeft]                NVARCHAR (50)    NULL,
    [OptionLabelRight]               NVARCHAR (50)    NULL,
    [OptionLevelStart]               TINYINT          CONSTRAINT [DF_Question_OptionLevelStart] DEFAULT ((1)) NULL,
    [OptionLevelEnd]                 TINYINT          CONSTRAINT [DF_Question_OptionLevelEnd] DEFAULT ((5)) NULL,
    [OptionShowOther]                BIT              CONSTRAINT [DF_Question_OptionShowOther] DEFAULT ((0)) NULL,
    [OptionAppendToChoice]           BIT              CONSTRAINT [DF_Question_OptionAppendToChoice] DEFAULT ((0)) NULL,
    [OptionOtherLabel]               VARCHAR (50)     NULL,
    CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Question_SurveyNumber]
    ON [dbo].[Question]([SurveyNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Question_Sorting]
    ON [dbo].[Question]([SurveyNumber] ASC, [Section] ASC, [SortOrder] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Question_Guid]
    ON [dbo].[Question]([Guid] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1清單
2下拉
3等級
4文字', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Question', @level2type = N'COLUMN', @level2name = N'OptionDisplayType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'每行顯示項目數量，只對單複選有效。0表示不限制。', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Question', @level2type = N'COLUMN', @level2name = N'OptionDisplayPerRow';

