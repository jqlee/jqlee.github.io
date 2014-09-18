CREATE TABLE [dbo].[PublishSetting] (
    [Number]             INT              IDENTITY (1, 1) NOT NULL,
    [Period]             VARCHAR (6)      NULL,
    [PeriodYear]         SMALLINT         NULL,
    [PeriodSeme]         TINYINT          NULL,
    [Name]               NVARCHAR (50)    NULL,
    [Description]        NVARCHAR (200)   NULL,
    [TargetMark]         TINYINT          NULL,
    [SurveyNumber]       INT              NULL,
    [DoneMessage]        NVARCHAR (200)   NULL,
    [OpenDate]           DATETIME         NULL,
    [CloseDate]          DATETIME         NULL,
    [QueryDate]          DATETIME         NULL,
    [LastModified]       DATETIME         CONSTRAINT [DF_PublishSetting_LastModified] DEFAULT (getdate()) NULL,
    [LastModifierId]     VARCHAR (20)     NULL,
    [LastModifierName]   NVARCHAR (50)    NULL,
    [RecycleDate]        DATETIME         NULL,
    [RecycleUserId]      VARCHAR (20)     NULL,
    [RecycleUserName]    NVARCHAR (50)    NULL,
    [Creator]            VARCHAR (20)     NULL,
    [CreatorName]        NVARCHAR (50)    NULL,
    [IsVerified]         BIT              NULL,
    [VerifierId]         VARCHAR (20)     NULL,
    [VerifierName]       NVARCHAR (50)    NULL,
    [Guid]               UNIQUEIDENTIFIER CONSTRAINT [DF_PublishSetting_Guid] DEFAULT (newid()) NULL,
    [Enabled]            BIT              CONSTRAINT [DF_PublishSetting_Enable] DEFAULT ((0)) NULL,
    [IsTemporary]        BIT              CONSTRAINT [DF_PublishSetting_IsTemporary] DEFAULT ((0)) NULL,
    [LastPublishVersion] SMALLINT         NULL,
    [IsPublished]        BIT              CONSTRAINT [DF_PublishSetting_Enable1] DEFAULT ((0)) NULL,
    [IsPaused]           BIT              NULL,
    [TargetSummary]      NVARCHAR (200)   NULL,
    [TemplateId]         UNIQUEIDENTIFIER NULL,
    [ScoreConfigNumber]  INT              NULL,
    [IsDoneProperty]     BIT              CONSTRAINT [DF_PublishSetting_IsCompletedProperty] DEFAULT ((0)) NOT NULL,
    [IsDoneConfig]       BIT              CONSTRAINT [DF_PublishSetting_IsCompletedConfig] DEFAULT ((0)) NOT NULL,
    [CompleteCount]      INT              CONSTRAINT [DF_PublishSetting_CompleteCount] DEFAULT ((0)) NULL,
    [PublishCount]       INT              CONSTRAINT [DF_PublishSetting_PublishCount] DEFAULT ((0)) NULL,
    [CompleteRate]       FLOAT (53)       CONSTRAINT [DF_PublishSetting_CompleteRate] DEFAULT ((0)) NULL,
    [GroupCount]         INT              CONSTRAINT [DF_PublishSetting_GroupCount] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_PublishSetting] PRIMARY KEY CLUSTERED ([Number] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PublishSetting_Guid]
    ON [dbo].[PublishSetting]([Guid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PublishSetting_Search]
    ON [dbo].[PublishSetting]([PeriodYear] ASC, [PeriodSeme] ASC, [Enabled] ASC, [LastModified] ASC, [OpenDate] ASC, [CloseDate] ASC, [LastPublishVersion] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'這一欄不直接讀寫，只有更新PeriodYear跟PeriodSeme的時候同步更新，儲存的資料唯一用途是給GridView呼叫分頁sql排序。', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublishSetting', @level2type = N'COLUMN', @level2name = N'Period';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'限制在統計頁才能使用此欄位，僅做為顯示用途', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublishSetting', @level2type = N'COLUMN', @level2name = N'PublishCount';

