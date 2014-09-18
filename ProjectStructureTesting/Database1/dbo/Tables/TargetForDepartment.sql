CREATE TABLE [dbo].[TargetForDepartment] (
    [Number]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (100) NULL,
    [SurveyNumber]    INT            NULL,
    [DepartmentId]    VARCHAR (50)   NULL,
    [DepartmentDepth] TINYINT        CONSTRAINT [DF_TargetForDepartment_DepartmentDepth] DEFAULT ((0)) NULL,
    [MemberGrade]     INT            NULL,
    [RoleCode]        VARCHAR (6)    CONSTRAINT [DF_TargetForDepartment_RoleCode] DEFAULT ((0)) NULL,
    [GroupYear]       INT            NULL,
    [TargetMark]      TINYINT        CONSTRAINT [DF_SurveyTargetForDepartment_TargetMark] DEFAULT ((0)) NULL,
    [Creator]         VARCHAR (20)   NULL,
    [Created]         DATETIME       CONSTRAINT [DF_TargetForDepartment_Created] DEFAULT (getdate()) NULL,
    [ConditionNumber] INT            NULL,
    CONSTRAINT [PK_SurveyDepartmentTarget] PRIMARY KEY CLUSTERED ([Number] ASC)
);

