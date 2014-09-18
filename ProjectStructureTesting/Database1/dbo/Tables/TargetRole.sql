CREATE TABLE [dbo].[TargetRole] (
    [TargetNumber] INT         NOT NULL,
    [RoleCode]     VARCHAR (6) NOT NULL,
    CONSTRAINT [PK_TargetRole] PRIMARY KEY CLUSTERED ([TargetNumber] ASC, [RoleCode] ASC)
);

