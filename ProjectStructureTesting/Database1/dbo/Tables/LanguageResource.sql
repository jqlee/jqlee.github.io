CREATE TABLE [dbo].[LanguageResource] (
    [Number]     INT             IDENTITY (1, 1) NOT NULL,
    [FileName]   NVARCHAR (MAX)  NULL,
    [XmlContent] VARBINARY (MAX) NOT NULL,
    [Done]       BIT             CONSTRAINT [DF_LanguageResource_Done] DEFAULT ((0)) NULL,
    [Version]    INT             CONSTRAINT [DF_LanguageResource_Version] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_LanguageResource] PRIMARY KEY CLUSTERED ([Number] ASC)
);

