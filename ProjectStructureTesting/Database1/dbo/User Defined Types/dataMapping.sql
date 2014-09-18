CREATE TYPE [dbo].[dataMapping] AS TABLE (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [numberFrom] INT           NULL,
    [toNumber]   INT           NULL,
    [stringFrom] VARCHAR (MAX) NULL,
    [toString]   VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC));

