CREATE TABLE [dbo].[Survey] (
    [Number]            INT              IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (50)    NULL,
    [Title]             NVARCHAR (100)   NULL,
    [Description]       NVARCHAR (MAX)   NULL,
    [SubmittingMessage] NVARCHAR (100)   NULL,
    [IsEnableHtml]      BIT              NULL,
    [StartDate]         DATETIME         NULL,
    [EndDate]           DATETIME         NULL,
    [TotalReturn]       INT              NULL,
    [ResultOpen]        BIT              NULL,
    [PageCount]         INT              NULL,
    [StateMark]         TINYINT          NOT NULL,
    [EnabledMark]       TINYINT          NULL,
    [Enabled]           BIT              CONSTRAINT [DF_Survey_Enabled] DEFAULT ((1)) NULL,
    [Visible]           BIT              CONSTRAINT [DF_Survey_Visible] DEFAULT ((1)) NULL,
    [Creator]           VARCHAR (20)     NULL,
    [Owner]             VARCHAR (20)     NULL,
    [OwnerName]         NVARCHAR (50)    NULL,
    [Created]           DATETIME         NULL,
    [CreatorName]       NVARCHAR (20)    NULL,
    [LastModified]      DATETIME         NULL,
    [LastModifier]      VARCHAR (20)     NULL,
    [LastModifierName]  NVARCHAR (20)    NULL,
    [CanAnswerTimes]    INT              NULL,
    [Language]          VARCHAR (10)     NULL,
    [Guid]              UNIQUEIDENTIFIER CONSTRAINT [DF_Survey_Guid] DEFAULT (newid()) NULL,
    [CopySource]        INT              NULL,
    [CreateItemType]    CHAR (1)         NULL,
    [CreateItemNumber]  VARCHAR (500)    NULL,
    [GroupOnly]         BIT              NULL,
    [TargetMark]        TINYINT          CONSTRAINT [DF_Survey_TargetMark] DEFAULT ((0)) NULL,
    [GroupId]           VARCHAR (20)     NULL,
    [IsTemplate]        BIT              CONSTRAINT [DF_Survey_IsTemplate] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Survey] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'對象
1:課程內所有學生 
2:課程內指定學生 
3.院系的學生 
4:院系內所有課程的學生 
5:N年度修過院系課程的學生 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Survey', @level2type = N'COLUMN', @level2name = N'TargetMark';

