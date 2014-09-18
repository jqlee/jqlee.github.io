CREATE TABLE [dbo].[TargetGroup] (
    [Number]           INT           IDENTITY (1, 1) NOT NULL,
    [SurveyNumber]     INT           NOT NULL,
    [GroupId]          VARCHAR (20)  NOT NULL,
    [IncludingAuditor] BIT           NULL,
    [Name]             NVARCHAR (50) NULL,
    CONSTRAINT [PK_TargetGroup] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'包含旁聽生', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TargetGroup', @level2type = N'COLUMN', @level2name = N'IncludingAuditor';

