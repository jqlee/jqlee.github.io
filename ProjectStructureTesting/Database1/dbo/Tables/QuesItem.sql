CREATE TABLE [dbo].[QuesItem] (
    [Number]         INT            IDENTITY (1, 1) NOT NULL,
    [QuestionNumber] INT            NULL,
    [Text]           NVARCHAR (MAX) NULL,
    [Creator]        VARCHAR (20)   NULL,
    [CreatorName]    NVARCHAR (50)  NULL,
    [IsVisible]      BIT            NULL,
    [Score]          INT            NULL,
    CONSTRAINT [PK_QuesItem] PRIMARY KEY CLUSTERED ([Number] ASC)
);

