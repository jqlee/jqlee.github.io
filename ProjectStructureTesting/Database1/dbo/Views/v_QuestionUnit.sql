CREATE VIEW dbo.v_QuestionUnit
AS
SELECT          TOP (100) PERCENT q.SurveyNumber, dbo.fnGetSortString(q.Section, q.SortOrder, s1.SortOrder, s2.SortOrder) 
                            AS AutoId, q.Section, q.Number AS QuestionNumber, q.Title, q.Description, q.OptionDisplayType, 
                            q.OptionMultipleSelection, CONVERT(bit, CASE WHEN q.OptionDisplayType = 1 AND 
                            q.OptionMultipleSelection = 0 THEN 1 ELSE 0 END) AS CanScore, q.Title + ' ' + ISNULL(s1.Text, '') 
                            + '  ' + ISNULL(s2.Text, '') AS FullTitle, ISNULL(s1.Text, '') + '  ' + ISNULL(s2.Text, '') AS AreaTitle, ISNULL(s1.Number, 
                            0) AS SubsetNumber, q.SortOrder AS QuestionSort, s1.Text AS SubsetText, ISNULL(s2.Number, 0) 
                            AS GroupingNumber, s2.Text AS GroupingText, s1.SortOrder AS SubsetSort, s2.SortOrder AS GroupingSort, 
                            ISNULL(q.SortOrder, 0) * 255 * 255 + ISNULL(s1.SortOrder, 0) * 255 + ISNULL(s2.SortOrder, 0) AS SortOrder, 
                            HASHBYTES('SHA1', CONVERT(NCHAR(36), NEWID()) + CONVERT(varchar, q.Number + ISNULL(s1.Number, 0) 
                            + ISNULL(s2.Number, 0))) AS Hash
FROM              dbo.Question AS q LEFT OUTER JOIN
                            dbo.Subset AS s1 ON s1.QuestionNumber = q.Number AND s1.Dimension = 1 LEFT OUTER JOIN
                            dbo.Subset AS s2 ON s2.QuestionNumber = q.Number AND s2.Dimension = 2

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[6] 4[21] 2[37] 3) )"
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
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "q"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 140
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "s1"
            Begin Extent = 
               Top = 6
               Left = 266
               Bottom = 140
               Right = 453
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "s2"
            Begin Extent = 
               Top = 6
               Left = 491
               Bottom = 140
               Right = 678
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1860
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_QuestionUnit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_QuestionUnit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_QuestionUnit';

