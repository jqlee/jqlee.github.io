CREATE TABLE [dbo].[Progress] (
    [Number]   INT           IDENTITY (1, 1) NOT NULL,
    [Category] VARCHAR (20)  NULL,
    [Text]     NVARCHAR (50) NULL,
    [Sort]     INT           NULL,
    CONSTRAINT [PK_Progress] PRIMARY KEY CLUSTERED ([Number] ASC)
);

