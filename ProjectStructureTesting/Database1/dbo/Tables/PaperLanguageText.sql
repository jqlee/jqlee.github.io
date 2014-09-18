CREATE TABLE [dbo].[PaperLanguageText] (
    [Number]         INT            IDENTITY (1, 1) NOT NULL,
    [LangNumber]     INT            NULL,
    [CategoryNumber] INT            NULL,
    [DataNumber]     INT            NULL,
    [DataValue]      NVARCHAR (MAX) NULL,
    [TempNumber1]    INT            NULL,
    [TempNumber2]    INT            NULL,
    CONSTRAINT [PK_PaperLanguageText] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'對應 PaperLanguage 的 Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PaperLanguageText', @level2type = N'COLUMN', @level2name = N'LangNumber';

