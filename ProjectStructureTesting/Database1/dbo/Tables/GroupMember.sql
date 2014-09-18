CREATE TABLE [dbo].[GroupMember] (
    [GroupId]   VARCHAR (20) NOT NULL,
    [MemberId]  VARCHAR (20) NOT NULL,
    [IsAuditor] BIT          NULL,
    CONSTRAINT [PK_GroupMember] PRIMARY KEY CLUSTERED ([GroupId] ASC, [MemberId] ASC)
);

