CREATE TABLE [dbo].[Student] (
    [Id]        VARCHAR (20)  NOT NULL,
    [Name]      NVARCHAR (50) NULL,
    [CollegeId] VARCHAR (20)  NULL,
    [CollGrade] VARCHAR (2)   NULL,
    [CollGroup] VARCHAR (2)   NULL,
    CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([Id] ASC)
);

