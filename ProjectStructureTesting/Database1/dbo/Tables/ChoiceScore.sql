CREATE TABLE [dbo].[ChoiceScore] (
    [Number]       INT              IDENTITY (1, 1) NOT NULL,
    [ConfigNumber] INT              NULL,
    [ChoiceNumber] INT              NULL,
    [Score]        DECIMAL (6, 2)   NULL,
    [ConfigGuid]   UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_ChoiceScore] PRIMARY KEY CLUSTERED ([Number] ASC)
);

