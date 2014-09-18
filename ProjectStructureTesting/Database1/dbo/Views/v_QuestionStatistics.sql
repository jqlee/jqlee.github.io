CREATE VIEW dbo.v_QuestionStatistics
AS
SELECT          q.SurveyNumber, q.Number AS QuestionNumber, ISNULL(ss.Number, 0) AS SubsetNumber, ISNULL(sg.Number, 0) 
                            AS GroupingNumber, c.Number AS ChoiceNumber, SUM(CASE WHEN v.Number IS NULL THEN 0 ELSE 1 END) 
                            AS Total
FROM              dbo.Question AS q LEFT OUTER JOIN
                            dbo.Subset AS ss ON ss.QuestionNumber = q.Number AND ss.Dimension = 1 LEFT OUTER JOIN
                            dbo.Subset AS sg ON sg.QuestionNumber = q.Number AND sg.Dimension = 2 INNER JOIN
                            dbo.Choice AS c ON c.QuestionNumber = q.Number LEFT OUTER JOIN
                            dbo.RecordRaw AS w ON w.QuestionNumber = q.Number AND w.SubsetNumber = ss.Number AND 
                            w.GroupingNumber = sg.Number LEFT OUTER JOIN
                            dbo.RecordRawValue AS v ON v.RawNumber = w.Number AND v.ChoiceNumber = c.Number
GROUP BY   q.SurveyNumber, q.Number, ss.Number, sg.Number, c.Number

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[13] 3) )"
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
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[25] 3) )"
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
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "q"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 140
               Right = 341
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ss"
            Begin Extent = 
               Top = 6
               Left = 379
               Bottom = 140
               Right = 582
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sg"
            Begin Extent = 
               Top = 6
               Left = 620
               Bottom = 140
               Right = 823
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 861
               Bottom = 140
               Right = 1064
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "w"
            Begin Extent = 
               Top = 144
               Left = 38
               Bottom = 278
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v"
            Begin Extent = 
               Top = 144
               Left = 282
               Bottom = 260
               Right = 473
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
         Width = 1500', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_QuestionStatistics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_QuestionStatistics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_QuestionStatistics';

