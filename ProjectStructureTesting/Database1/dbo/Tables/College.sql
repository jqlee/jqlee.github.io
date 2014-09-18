CREATE TABLE [dbo].[College] (
    [Id]        VARCHAR (8)    NOT NULL,
    [Name]      NVARCHAR (150) NULL,
    [ShortName] NVARCHAR (20)  NULL,
    CONSTRAINT [PK_College] PRIMARY KEY CLUSTERED ([Id] ASC)
);

