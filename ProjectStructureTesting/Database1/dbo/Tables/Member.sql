CREATE TABLE [dbo].[Member] (
    [Id]           VARCHAR (20)  NOT NULL,
    [Name]         NVARCHAR (50) NULL,
    [DepartmentId] VARCHAR (20)  NULL,
    [Level]        VARCHAR (2)   NULL,
    [RR]           TINYINT       NULL,
    CONSTRAINT [PK_Member] PRIMARY KEY CLUSTERED ([Id] ASC)
);

