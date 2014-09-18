CREATE TABLE [dbo].[PublishDepartment] (
    [Number]        INT          IDENTITY (1, 1) NOT NULL,
    [PublishNumber] INT          NULL,
    [DepartmentId]  VARCHAR (50) NULL,
    [Seme]          TINYINT      NULL,
    CONSTRAINT [PK_PublishDepartment] PRIMARY KEY CLUSTERED ([Number] ASC),
    CONSTRAINT [FK_PublishDepartment_PublishSetting] FOREIGN KEY ([PublishNumber]) REFERENCES [dbo].[PublishSetting] ([Number])
);

