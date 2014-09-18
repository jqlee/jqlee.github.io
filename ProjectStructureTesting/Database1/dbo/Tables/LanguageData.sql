CREATE TABLE [dbo].[LanguageData] (
    [Number]         INT            IDENTITY (1, 1) NOT NULL,
    [LanguageNumber] INT            NOT NULL,
    [KeyNumber]      INT            NOT NULL,
    [Value]          NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_LanguageData] PRIMARY KEY CLUSTERED ([LanguageNumber] ASC, [KeyNumber] ASC)
);

