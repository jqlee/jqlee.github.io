CREATE VIEW dbo.v_Department_ican5
AS
SELECT          schl_id AS SchoolId, coll_no AS Id, coll_name AS Name, coll_shortname AS ShortName, 
                            CASE WHEN up_coll IS NOT NULL THEN up_coll WHEN len(coll_no) >= 5 THEN LEFT(coll_no, 2) WHEN len(coll_no) 
                            = 3 THEN LEFT(coll_no, 2) WHEN len(coll_no) = 2 THEN isnull(schl_id, '1000') ELSE NULL END AS ParentId, 
                            CASE WHEN len(coll_no) = 2 OR
                            len(coll_no) = 5 OR
                            schl_id = '2000' THEN '10' ELSE '20' END AS Mark, CONVERT(bit, CASE coll_mark WHEN '10' THEN 1 ELSE 0 END) 
                            AS Enabled
FROM              (SELECT          schl_id, coll_no, coll_name, coll_shortname, up_coll, coll_mark
                            FROM               iCAN5.dbo.College
                            WHERE           (coll_mark = '10')
                            UNION
                            SELECT          '1000' AS Expr1, '1000' AS Expr2, '[測]文化大學推廣教育部' AS Expr3, '文大推廣' AS Expr4, NULL 
                                                        AS up_coll, '10' AS coll_mark
                            UNION
                            SELECT          '2000' AS Expr1, '2000' AS Expr2, '[測]全家便利商店' AS Expr3, '全家' AS Expr4, NULL AS up_coll, 
                                                        '10' AS coll_mark) AS college_1

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[9] 4[17] 2[69] 3) )"
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
         Top = -288
         Left = 0
      End
      Begin Tables = 
         Begin Table = "college_1"
            Begin Extent = 
               Top = 294
               Left = 38
               Bottom = 428
               Right = 212
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
         Width = 1260
         Width = 3900
         Width = 2130
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
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_Department_ican5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_Department_ican5';

