CREATE TABLE [dbo].[Course] (
    [Id]        VARCHAR (20)   NOT NULL,
    [Name]      NVARCHAR (100) NULL,
    [CollegeId] VARCHAR (20)   NULL,
    [Year]      INT            NULL,
    CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED ([Id] ASC)
);

