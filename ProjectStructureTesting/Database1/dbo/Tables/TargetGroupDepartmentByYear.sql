CREATE TABLE [dbo].[TargetGroupDepartmentByYear] (
    [Number]       INT           IDENTITY (1, 1) NOT NULL,
    [SurveyNumber] INT           NOT NULL,
    [GroupYear]    INT           NOT NULL,
    [DepartmentId] VARCHAR (8)   NOT NULL,
    [Name]         NVARCHAR (50) NULL,
    CONSTRAINT [PK_TargetCourseCollegeByYear] PRIMARY KEY CLUSTERED ([SurveyNumber] ASC, [GroupYear] ASC, [DepartmentId] ASC)
);

