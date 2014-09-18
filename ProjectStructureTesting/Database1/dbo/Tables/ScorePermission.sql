CREATE TABLE [dbo].[ScorePermission] (
    [PublishNumber] INT NOT NULL,
    [ConfigNumber]  INT NOT NULL,
    CONSTRAINT [PK_ScorePermission] PRIMARY KEY CLUSTERED ([PublishNumber] ASC, [ConfigNumber] ASC)
);

