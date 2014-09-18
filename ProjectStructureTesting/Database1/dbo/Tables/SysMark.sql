CREATE TABLE [dbo].[SysMark] (
    [Number]        INT           IDENTITY (1, 1) NOT NULL,
    [Name]          VARCHAR (20)  NOT NULL,
    [Text]          VARCHAR (20)  NOT NULL,
    [Value]         INT           NOT NULL,
    [Note]          NVARCHAR (50) NULL,
    [Enabled]       BIT           CONSTRAINT [DF_SysMark_Enabled] DEFAULT ((1)) NULL,
    [OutputPattern] NVARCHAR (50) NULL,
    CONSTRAINT [PK_SysMark] PRIMARY KEY CLUSTERED ([Name] ASC, [Value] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SysMark]
    ON [dbo].[SysMark]([Name] ASC, [Value] ASC);

