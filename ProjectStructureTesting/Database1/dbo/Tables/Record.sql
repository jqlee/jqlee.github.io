CREATE TABLE [dbo].[Record] (
    [Number]             INT              IDENTITY (1, 1) NOT NULL,
    [PublishNumber]      INT              NULL,
    [SurveyNumber]       INT              NULL,
    [Guid]               UNIQUEIDENTIFIER CONSTRAINT [DF_Record_Guid] DEFAULT (newid()) NULL,
    [TargetNumber1]      INT              NULL,
    [TargetMark]         TINYINT          NULL,
    [MemberId]           VARCHAR (50)     NULL,
    [MemberName]         NVARCHAR (50)    NULL,
    [MemberDepartmentId] VARCHAR (20)     NULL,
    [MemberRole]         VARCHAR (6)      NULL,
    [MemberGrade]        TINYINT          NULL,
    [MemberGrp]          VARCHAR (2)      NULL,
    [MemberSubgrp]       VARCHAR (2)      NULL,
    [Done]               BIT              CONSTRAINT [DF_Record_Completed] DEFAULT ((0)) NULL,
    [Created]            DATETIME         CONSTRAINT [DF_Record_StartAnsweredTime] DEFAULT (getdate()) NULL,
    [LastAccessPage]     TINYINT          CONSTRAINT [DF_Record_LastAccessPage] DEFAULT ((1)) NULL,
    [LastAccessTime]     DATETIME         CONSTRAINT [DF_Record_LastAccessTime] DEFAULT (getdate()) NULL,
    [GroupDepartmentId]  VARCHAR (20)     NULL,
    [GroupId]            VARCHAR (20)     NULL,
    [GroupTeacherId]     VARCHAR (20)     NULL,
    [GroupTeacherName]   NVARCHAR (50)    NULL,
    [GroupYear]          SMALLINT         NULL,
    [GroupSeme]          TINYINT          NULL,
    [GroupSubjectKey]    VARCHAR (6)      NULL,
    [GroupGrade]         TINYINT          NULL,
    [GroupGrp]           VARCHAR (2)      NULL,
    [GroupSubgrp]        VARCHAR (2)      NULL,
    [GroupRole]          VARCHAR (6)      NULL,
    CONSTRAINT [PK_Record] PRIMARY KEY CLUSTERED ([Number] ASC),
    CONSTRAINT [FK_Record_PublishSetting] FOREIGN KEY ([PublishNumber]) REFERENCES [dbo].[PublishSetting] ([Number])
);


GO
CREATE NONCLUSTERED INDEX [IX_Record_Filter]
    ON [dbo].[Record]([PublishNumber] ASC, [SurveyNumber] ASC, [MemberId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Record_Done]
    ON [dbo].[Record]([SurveyNumber] ASC, [Done] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Record_FilterGrouping]
    ON [dbo].[Record]([GroupId] ASC, [GroupTeacherId] ASC, [GroupRole] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Record_FilterMember]
    ON [dbo].[Record]([MemberDepartmentId] ASC, [MemberGrade] ASC, [MemberRole] ASC);

