CREATE TABLE [dbo].[TargetForGroup] (
    [Number]       INT          IDENTITY (1, 1) NOT NULL,
    [SurveyNumber] INT          NULL,
    [GroupId]      VARCHAR (20) NULL,
    [MemberId]     VARCHAR (20) NULL,
    [TargetMark]   TINYINT      CONSTRAINT [DF_SurveyTargetForGroup_TargetMark] DEFAULT ((0)) NULL,
    [Creator]      VARCHAR (20) NULL,
    [Created]      DATETIME     CONSTRAINT [DF_TargetForGroup_Created] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_SurveyGroupTarget] PRIMARY KEY CLUSTERED ([Number] ASC)
);

