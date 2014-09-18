CREATE TABLE [dbo].[TargetDepartment] (
    [Number]       INT           IDENTITY (1, 1) NOT NULL,
    [SurveyNumber] INT           NOT NULL,
    [DepartmentId] VARCHAR (20)  NULL,
    [Level]        VARCHAR (2)   NULL,
    [Name]         NVARCHAR (50) NULL,
    [UseGroup]     BIT           NULL,
    CONSTRAINT [PK_TargetCollege] PRIMARY KEY CLUSTERED ([Number] ASC)
);

