CREATE TABLE [dbo].[DepartmentGroup] (
    [Id]           VARCHAR (20)   NOT NULL,
    [Name]         NVARCHAR (100) NULL,
    [DepartmentId] VARCHAR (8)    NULL,
    [Year]         INT            NULL,
    CONSTRAINT [PK_DepartmentGroup] PRIMARY KEY CLUSTERED ([Id] ASC)
);

