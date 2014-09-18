CREATE TABLE [dbo].[Condition] (
    [Number]       INT           IDENTITY (1, 1) NOT NULL,
    [SurveyNumber] INT           NULL,
    [TargetMark]   TINYINT       NULL,
    [Keyword]      VARCHAR (20)  NULL,
    [GroupYear]    INT           NULL,
    [RoleCode]     VARCHAR (6)   NULL,
    [MemberGrade]  INT           NULL,
    [Name]         NVARCHAR (50) NULL,
    [Creator]      VARCHAR (20)  NULL,
    [Created]      DATETIME      CONSTRAINT [DF_Condition_Created] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Condition] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Condition_SurveyNumber]
    ON [dbo].[Condition]([SurveyNumber] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'3: 年級 4:課程年份', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Condition', @level2type = N'COLUMN', @level2name = N'TargetMark';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'身分', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Condition', @level2type = N'COLUMN', @level2name = N'RoleCode';

