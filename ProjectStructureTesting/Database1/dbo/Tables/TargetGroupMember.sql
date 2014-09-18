CREATE TABLE [dbo].[TargetGroupMember] (
    [Number]       INT           IDENTITY (1, 1) NOT NULL,
    [SurveyNumber] INT           NOT NULL,
    [GroupId]      VARCHAR (20)  NOT NULL,
    [MemberId]     VARCHAR (20)  NOT NULL,
    [Name]         NVARCHAR (50) NULL,
    CONSTRAINT [PK_TargetCourseUser] PRIMARY KEY CLUSTERED ([SurveyNumber] ASC, [GroupId] ASC, [MemberId] ASC)
);

