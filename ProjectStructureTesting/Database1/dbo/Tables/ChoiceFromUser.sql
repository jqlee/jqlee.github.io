CREATE TABLE [dbo].[ChoiceFromUser] (
    [Number]       INT          IDENTITY (1, 1) NOT NULL,
    [ChoiceNumber] INT          NULL,
    [Creator]      VARCHAR (20) NULL,
    CONSTRAINT [PK_ChoiceFromUser] PRIMARY KEY CLUSTERED ([Number] ASC)
);

