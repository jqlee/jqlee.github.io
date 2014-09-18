CREATE TABLE [dbo].[_NewSchemaMapping] (
    [Number]        INT           IDENTITY (1, 1) NOT NULL,
    [OldTableName]  NVARCHAR (50) NULL,
    [OldColumnName] NVARCHAR (50) NULL,
    [NewTableName]  NVARCHAR (50) NULL,
    [NewColumnName] NVARCHAR (50) NULL,
    CONSTRAINT [PK__NewSchemaMapping] PRIMARY KEY CLUSTERED ([Number] ASC)
);

