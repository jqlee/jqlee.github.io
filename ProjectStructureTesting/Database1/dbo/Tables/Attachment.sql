CREATE TABLE [dbo].[Attachment] (
    [Number]         INT             IDENTITY (1, 1) NOT NULL,
    [QuestionNumber] INT             NULL,
    [Enabled]        BIT             CONSTRAINT [DF_Attachment_Enabled] DEFAULT ((1)) NULL,
    [Binary]         VARBINARY (MAX) NULL,
    [Uploaded]       DATETIME        CONSTRAINT [DF_Attachment_Uploaded] DEFAULT (getdate()) NULL,
    [Uploader]       VARCHAR (20)    NULL,
    [SortOrder]      INT             NULL,
    CONSTRAINT [PK_Attachment] PRIMARY KEY CLUSTERED ([Number] ASC)
);

