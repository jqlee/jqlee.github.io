CREATE TABLE [dbo].[Target] (
    [Number]          INT            IDENTITY (1, 1) NOT NULL,
    [SurveyNumber]    INT            NULL,
    [ConditionNumber] INT            NULL,
    [DepartmentId]    VARCHAR (20)   NOT NULL,
    [MatchKey]        VARCHAR (50)   NULL,
    [MatchName]       NVARCHAR (200) NULL,
    [RoleCode]        VARCHAR (6)    NOT NULL,
    [MemberGrade]     INT            NULL,
    [GroupId]         VARCHAR (20)   NULL,
    CONSTRAINT [PK_Target] PRIMARY KEY CLUSTERED ([Number] ASC)
);

