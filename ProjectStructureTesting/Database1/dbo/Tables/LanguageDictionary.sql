CREATE TABLE [dbo].[LanguageDictionary] (
    [Number]      INT            IDENTITY (1, 1) NOT NULL,
    [FileName]    NVARCHAR (100) NULL,
    [Key]         NVARCHAR (100) NULL,
    [DefaultText] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_LanguageDictionary] PRIMARY KEY CLUSTERED ([Number] ASC)
);

