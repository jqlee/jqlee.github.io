CREATE TABLE [dbo].[RecordMatch] (
    [Number]       INT          IDENTITY (1, 1) NOT NULL,
    [RecordNumber] INT          NULL,
    [SurveyNumber] INT          NULL,
    [Key]          VARCHAR (20) NULL,
    [Filter]       INT          NULL,
    [RoleCode]     VARCHAR (6)  NULL,
    CONSTRAINT [PK_RecordMatch] PRIMARY KEY CLUSTERED ([Number] ASC)
);

