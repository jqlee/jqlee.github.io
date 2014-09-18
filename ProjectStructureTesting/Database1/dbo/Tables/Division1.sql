CREATE TABLE [dbo].[Division1] (
    [Number]         INT            IDENTITY (1, 1) NOT NULL,
    [QuestionNumber] INT            NULL,
    [Text]           NVARCHAR (200) NULL,
    CONSTRAINT [PK_Division] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Division]
    ON [dbo].[Division1]([QuestionNumber] ASC);

