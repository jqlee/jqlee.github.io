CREATE TABLE [dbo].[Choice] (
    [Number]         INT            IDENTITY (1, 1) NOT NULL,
    [QuestionNumber] INT            NULL,
    [Text]           NVARCHAR (200) NULL,
    [SortOrder]      TINYINT        CONSTRAINT [DF_Choice_SortOrder] DEFAULT ((1)) NULL,
    [AcceptText]     BIT            NULL,
    [IsJoined]       BIT            CONSTRAINT [DF_Choice_IsJoined] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Choice] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Choice_Find]
    ON [dbo].[Choice]([QuestionNumber] ASC, [SortOrder] ASC);

