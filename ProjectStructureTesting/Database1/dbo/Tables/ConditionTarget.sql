CREATE TABLE [dbo].[ConditionTarget] (
    [Number]          INT          IDENTITY (1, 1) NOT NULL,
    [ConditionNumber] INT          NULL,
    [MatchKey]        VARCHAR (50) NULL,
    [TargetNumber]    INT          NULL,
    CONSTRAINT [PK_ConditionMatch] PRIMARY KEY CLUSTERED ([Number] ASC)
);

