CREATE TABLE [dbo].[PublishPaper] (
    [Number]        INT              IDENTITY (1, 1) NOT NULL,
    [Title]         NVARCHAR (100)   NULL,
    [Description]   NVARCHAR (MAX)   NULL,
    [Created]       DATETIME         NULL,
    [PublishNumber] INT              CONSTRAINT [DF_PublishPaper_PublishNumber] DEFAULT ((0)) NOT NULL,
    [CopySource]    INT              NULL,
    [Guid]          UNIQUEIDENTIFIER CONSTRAINT [DF_PublishPaper_Guid] DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_PublishPaper] PRIMARY KEY CLUSTERED ([Number] ASC)
);

