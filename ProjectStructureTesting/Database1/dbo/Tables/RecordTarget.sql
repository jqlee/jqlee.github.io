CREATE TABLE [dbo].[RecordTarget] (
    [Number]              INT              IDENTITY (1, 1) NOT NULL,
    [PublishNumber]       INT              NULL,
    [IndexNumber]         INT              NULL,
    [Guid]                UNIQUEIDENTIFIER CONSTRAINT [DF_RecordScore_Guid] DEFAULT (newid()) NULL,
    [GroupId]             VARCHAR (20)     NULL,
    [GroupTeacherId]      VARCHAR (20)     NULL,
    [GroupRole]           VARCHAR (6)      NULL,
    [GroupRoleName]       NVARCHAR (20)    NULL,
    [GroupName]           NVARCHAR (50)    NULL,
    [GroupTeacherName]    NVARCHAR (50)    NULL,
    [GroupDepartmentName] NVARCHAR (50)    NULL,
    [GroupDepartmentId]   VARCHAR (20)     NULL,
    [GroupSubjectKey]     VARCHAR (20)     NULL,
    [GroupGrade]          TINYINT          NULL,
    [GroupGrp]            VARCHAR (2)      NULL,
    [GroupSubgrp]         VARCHAR (2)      NULL,
    [CompleteCount]       INT              NULL,
    [PublishCount]        INT              NULL,
    [CompleteRate]        FLOAT (53)       NULL,
    [FinalScore]          FLOAT (53)       NULL,
    [StdevpScore]         FLOAT (53)       NULL,
    [Done]                BIT              CONSTRAINT [DF_RecordTarget_Done] DEFAULT ((0)) NULL,
    [LastModified]        DATETIME         CONSTRAINT [DF_RecordTarget_LastModified] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_RecordScore] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Guid]
    ON [dbo].[RecordTarget]([Guid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RecordTarget_Find]
    ON [dbo].[RecordTarget]([IndexNumber] ASC)
    INCLUDE([Number]);

