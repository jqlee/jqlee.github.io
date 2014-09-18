CREATE TABLE [dbo].[PublishTarget] (
    [Number]        INT         IDENTITY (1, 1) NOT NULL,
    [PublishNumber] INT         NULL,
    [GroupYear]     SMALLINT    NULL,
    [GroupSemeX]    TINYINT     NULL,
    [GroupGrade]    TINYINT     NULL,
    [GroupRole]     VARCHAR (6) NULL,
    [MemberGrade]   TINYINT     NULL,
    [MemberRole]    VARCHAR (6) NULL,
    CONSTRAINT [PK_PublishTarget] PRIMARY KEY CLUSTERED ([Number] ASC),
    CONSTRAINT [FK_PublishTarget_PublishSetting] FOREIGN KEY ([PublishNumber]) REFERENCES [dbo].[PublishSetting] ([Number])
);

