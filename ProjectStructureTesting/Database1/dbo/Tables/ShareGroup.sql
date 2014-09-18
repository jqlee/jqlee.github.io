CREATE TABLE [dbo].[ShareGroup] (
    [Number]  INT           IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (50) NULL,
    [Creator] VARCHAR (20)  NULL,
    CONSTRAINT [PK_ShareGroup] PRIMARY KEY CLUSTERED ([Number] ASC)
);

