CREATE TABLE [dbo].[CustomSetting] (
    [Setting]  VARCHAR (20)  NOT NULL,
    [MemberId] VARCHAR (20)  NOT NULL,
    [Action]   VARCHAR (20)  NOT NULL,
    [Value]    INT           NULL,
    [Data]     VARCHAR (20)  NULL,
    [Text]     NVARCHAR (50) NULL,
    CONSTRAINT [PK_CustomSetting] PRIMARY KEY CLUSTERED ([Setting] ASC, [MemberId] ASC, [Action] ASC)
);

