CREATE TABLE [dbo].[PaperLanguage] (
    [Number]      INT         IDENTITY (1, 1) NOT NULL,
    [PaperNumber] INT         NULL,
    [LangNumber]  INT         NULL,
    [LangCode]    VARCHAR (2) NULL,
    [Enabled]     BIT         CONSTRAINT [DF_PaperLanguage_Enabled] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_PaperLanguage] PRIMARY KEY CLUSTERED ([Number] ASC)
);

