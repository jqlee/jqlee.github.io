CREATE TABLE [dbo].[Department] (
    [Id]        VARCHAR (8)    NOT NULL,
    [Name]      NVARCHAR (150) NULL,
    [ShortName] NVARCHAR (20)  NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([Id] ASC)
);

