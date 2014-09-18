CREATE TABLE [dbo].[CourseStudent] (
    [StudentId] VARCHAR (20) NOT NULL,
    [CourseId]  VARCHAR (20) NOT NULL,
    [IsAudit]   BIT          NULL,
    CONSTRAINT [PK_CourseStudent] PRIMARY KEY CLUSTERED ([StudentId] ASC, [CourseId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'是否為旁聽', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CourseStudent', @level2type = N'COLUMN', @level2name = N'IsAudit';

