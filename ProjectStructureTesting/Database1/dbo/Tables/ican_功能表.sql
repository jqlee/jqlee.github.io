CREATE TABLE [dbo].[ican_功能表] (
    [編號]   INT           IDENTITY (1, 1) NOT NULL,
    [功能代碼] VARCHAR (8)   NOT NULL,
    [功能定義] NVARCHAR (50) NULL,
    CONSTRAINT [PK_ican_功能表] PRIMARY KEY CLUSTERED ([功能代碼] ASC)
);

