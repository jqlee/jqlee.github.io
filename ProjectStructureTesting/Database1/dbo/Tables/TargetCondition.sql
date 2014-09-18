CREATE TABLE [dbo].[TargetCondition] (
    [Number]        INT           IDENTITY (1, 1) NOT NULL,
    [PublishNumber] INT           NULL,
    [SurveyNumber]  INT           NULL,
    [TargetMark]    TINYINT       NULL,
    [Name]          NVARCHAR (50) NULL,
    [DepartmentId]  VARCHAR (20)  NULL,
    [RoleCode]      VARCHAR (6)   NULL,
    [GroupYear]     INT           NULL,
    [MemberGrade]   INT           NULL,
    [Creator]       VARCHAR (20)  NULL,
    [Created]       DATETIME      CONSTRAINT [DF_TargetCondition_Created] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TargetCondition] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'3: 年級 4:課程年份', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TargetCondition', @level2type = N'COLUMN', @level2name = N'TargetMark';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'身分', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TargetCondition', @level2type = N'COLUMN', @level2name = N'RoleCode';

