CREATE TABLE [dbo].[Language] (
    [Number]  INT           IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (50) NULL,
    [Code]    VARCHAR (6)   NULL,
    [Enabled] BIT           CONSTRAINT [DF_Language_Enabled] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED ([Number] ASC)
);

