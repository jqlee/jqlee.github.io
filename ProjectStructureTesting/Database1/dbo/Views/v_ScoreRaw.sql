CREATE VIEW dbo.v_ScoreRaw
AS
SELECT          qs.Score AS QuestionScore, cs.Score AS ChoiceScore, w.Number, w.MatchKey, w.MatchFilter, w.LogNumber, 
                            w.SurveyNumber, w.TargetNumber, w.RecordNumber, w.Section, w.QuestionNumber, w.SubsetNumber, 
                            w.GroupingNumber, w.ChoiceNumber, w.PickCount, w.MemberId
FROM              dbo.ScoreRaw AS w INNER JOIN
                            dbo.ScoreLog AS l ON l.Number = w.LogNumber INNER JOIN
                            dbo.ScoreConfig AS sc ON sc.Number = l.ConfigNumber INNER JOIN
                            dbo.QuestionScore AS qs ON qs.ConfigNumber = sc.Number AND 
                            qs.QuestionNumber = w.QuestionNumber INNER JOIN
                            dbo.ChoiceScore AS cs ON cs.ConfigNumber = sc.Number AND cs.ChoiceNumber = w.ChoiceNumber

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'= 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_ScoreRaw';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_ScoreRaw';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "w"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 140
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 140
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sc"
            Begin Extent = 
               Top = 6
               Left = 478
               Bottom = 140
               Right = 651
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "qs"
            Begin Extent = 
               Top = 6
               Left = 689
               Bottom = 140
               Right = 876
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cs"
            Begin Extent = 
               Top = 6
               Left = 914
               Bottom = 140
               Right = 1089
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_ScoreRaw';

