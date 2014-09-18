CREATE TABLE [dbo].[LanguageKey] (
    [Number]       INT            IDENTITY (1, 1) NOT NULL,
    [FileName]     NVARCHAR (100) NULL,
    [Key]          NVARCHAR (100) NULL,
    [DefaultValue] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_LanguageKey] PRIMARY KEY CLUSTERED ([Number] ASC)
);

