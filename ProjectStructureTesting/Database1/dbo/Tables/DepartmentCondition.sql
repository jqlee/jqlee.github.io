CREATE TABLE [dbo].[DepartmentCondition] (
    [Number]          INT           IDENTITY (1, 1) NOT NULL,
    [PublishNumber]   INT           NULL,
    [ConditionNumber] INT           NULL,
    [DepartmentId]    VARCHAR (20)  NULL,
    [DepartmentName]  NVARCHAR (50) NULL,
    CONSTRAINT [PK_DepartmentCondition] PRIMARY KEY CLUSTERED ([Number] ASC)
);

