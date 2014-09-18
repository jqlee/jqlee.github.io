CREATE VIEW dbo.v_SurveyMatchByGroup
AS
SELECT          r.Number AS RecordNumber, r.Done AS RecordDone, ps.Number AS SurveyNumber, ps.Guid AS SurveyId, 
                            pd.DepartmentId, pt.GroupYear, pt.GroupSeme, pt.GroupGrade, g.Id AS GroupId, g.Name AS GroupName, 
                            gmt.MemberId AS TeacherId, gm.MemberId, gm.RoleCode AS GroupRole
FROM              dbo.PublishSetting AS ps INNER JOIN
                            dbo.PublishTarget AS pt ON pt.PublishNumber = ps.Number INNER JOIN
                            dbo.PublishDepartment AS pd ON pd.PublishNumber = ps.Number INNER JOIN
                            dbo.v_Group AS g ON g.DepartmentId = pd.DepartmentId AND g.Year = pt.GroupYear AND 
                            g.Seme = pt.GroupSeme AND g.Grade = pt.GroupGrade INNER JOIN
                            dbo.v_GroupMember AS gmt ON gmt.GroupId = g.Id AND gmt.RoleCode = '2000' INNER JOIN
                            dbo.v_GroupMember AS gm ON gm.GroupId = g.Id AND gm.RoleCode = pt.GroupRole LEFT OUTER JOIN
                            dbo.Record AS r ON r.PublishNumber = ps.Number AND r.MemberId = gm.MemberId AND 
                            r.GroupDepartmentId = pd.DepartmentId AND r.GroupYear = pt.GroupYear AND r.GroupSeme = pt.GroupSeme AND 
                            r.GroupGrade = pt.GroupGrade AND r.GroupRole = pt.GroupRole AND r.GroupTeacherId = gmt.MemberId

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
         Begin Table = "ps"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 140
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pt"
            Begin Extent = 
               Top = 6
               Left = 282
               Bottom = 140
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pd"
            Begin Extent = 
               Top = 6
               Left = 496
               Bottom = 122
               Right = 672
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 6
               Left = 710
               Bottom = 140
               Right = 892
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gmt"
            Begin Extent = 
               Top = 144
               Left = 38
               Bottom = 278
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gm"
            Begin Extent = 
               Top = 144
               Left = 313
               Bottom = 278
               Right = 550
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 144
               Left = 588
               Bottom = 278
               Right = 805
            End
            DisplayFlags = 280
            TopColumn = 0
         En', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyMatchByGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'd
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyMatchByGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyMatchByGroup';

