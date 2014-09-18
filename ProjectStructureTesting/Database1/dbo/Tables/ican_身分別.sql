CREATE TABLE [dbo].[ican_身分別] (
    [編號]   INT           IDENTITY (1, 1) NOT NULL,
    [身分代碼] VARCHAR (6)   NOT NULL,
    [身分名稱] NVARCHAR (50) NULL,
    CONSTRAINT [PK_ican_身分別] PRIMARY KEY CLUSTERED ([身分代碼] ASC)
);

