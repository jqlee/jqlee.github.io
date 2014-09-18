CREATE VIEW dbo.v_SignOn
AS
SELECT          so.Id, so.sessionid, so.GroupId, m.Name AS MemberName, m.DepartmentId, m.DepartmentName, m.BasicRoleValue, 
                            m.BasicRoleExtensionValue, m.Grade, g.Name AS GroupName, so.StatusMark, so.MemberId, gm.GroupRoleValue, 
                            gm.GroupRoleExtensionValue, m.SchoolId, m.RoleCode, m.RoleName
FROM              (SELECT          Id, MemberId, sessionid, Enabled, GroupId, StatusMark
                            FROM               dbo.v_SignOn_ican5
                            UNION
                            SELECT          Id, MemberId, sessionid, Enabled, GroupId, StatusMark
                            FROM              dbo.v_SignOn_Local) AS so INNER JOIN
                            dbo.v_Member AS m ON m.Id = so.MemberId LEFT OUTER JOIN
                            dbo.v_Group AS g ON g.Id = so.GroupId LEFT OUTER JOIN
                            dbo.v_GroupMember AS gm ON gm.GroupId = g.Id AND gm.MemberId = m.Id AND gm.Enabled = 1

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[3] 2[57] 3) )"
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
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 241
               Bottom = 256
               Right = 608
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 6
               Left = 646
               Bottom = 140
               Right = 828
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gm"
            Begin Extent = 
               Top = 144
               Left = 646
               Bottom = 278
               Right = 883
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "so"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 140
               Right = 203
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
      Begin ColumnWidths = 19
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1995
         Width = 1500
         Width = 2130
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
         Column = 2430
         Alias = 2820
         Table = 1170
         Output = 720
         Append =', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SignOn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' 1400
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SignOn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SignOn';

