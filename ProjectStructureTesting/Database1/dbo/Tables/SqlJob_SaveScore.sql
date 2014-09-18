CREATE TABLE [dbo].[SqlJob_SaveScore] (
    [Number]        INT              IDENTITY (1, 1) NOT NULL,
    [Done]          BIT              CONSTRAINT [DF_SqlJob_SaveScore_Done] DEFAULT ((0)) NULL,
    [Enabled]       BIT              CONSTRAINT [DF_SqlJob_SaveScore_Enabled] DEFAULT ((1)) NULL,
    [IndexGuid]     UNIQUEIDENTIFIER NULL,
    [StartDate]     DATETIME         NULL,
    [CompleteDate]  DATETIME         NULL,
    [TargetCount]   INT              NULL,
    [CompleteCount] INT              NULL,
    CONSTRAINT [PK_SqlJob_SaveScore] PRIMARY KEY CLUSTERED ([Number] ASC)
);

