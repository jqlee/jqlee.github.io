CREATE TABLE [dbo].[ShareGroupMember] (
    [Number]      INT          IDENTITY (1, 1) NOT NULL,
    [GroupNumber] INT          NULL,
    [MemberId]    VARCHAR (20) NULL,
    [Creator]     VARCHAR (20) NULL,
    CONSTRAINT [PK_ShareGroupMember] PRIMARY KEY CLUSTERED ([Number] ASC)
);

