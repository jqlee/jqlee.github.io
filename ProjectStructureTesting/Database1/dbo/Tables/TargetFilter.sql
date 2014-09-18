CREATE TABLE [dbo].[TargetFilter] (
    [Number]     INT          IDENTITY (1, 1) NOT NULL,
    [TargetMark] TINYINT      NULL,
    [Name]       VARCHAR (20) NULL,
    CONSTRAINT [PK_TargetFilter] PRIMARY KEY CLUSTERED ([Number] ASC)
);

