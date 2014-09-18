CREATE VIEW dbo.v_Ticket
AS
SELECT          pm.PublishNumber, pm.DepartmentId AS GroupDepartmentId, d.Name AS GroupDepartmentName, pm.GroupYear, 
                            pm.GroupSeme, pm.GroupGrade, pm.GroupRole, g.Id AS GroupId, g.Name AS GroupName, 
                            msTeacher.MemberId AS GroupTeacherId, mTeacher.Name AS GroupTeacherName, 
                            g.SubjectKey AS GroupSubjectKey, g.Grp AS GroupGrp, g.Subgrp AS GroupSubgrp, 
                            gr.RoleName AS GroupRoleName
FROM              (SELECT          ps.Number AS PublishNumber, pd.DepartmentId, pt.GroupYear, pd.Seme AS GroupSeme, pt.GroupGrade, 
                                                        pt.GroupRole
                            FROM               dbo.PublishSetting AS ps INNER JOIN
                                                        dbo.PublishTarget AS pt ON pt.PublishNumber = ps.Number INNER JOIN
                                                        dbo.PublishDepartment AS pd ON pd.PublishNumber = ps.Number
                            WHERE           (ps.Enabled = 1) AND (ps.TargetMark = 1)
                            GROUP BY    ps.Number, pd.DepartmentId, pt.GroupYear, pd.Seme, pt.GroupGrade, pt.GroupRole) 
                            AS pm LEFT OUTER JOIN
                            dbo.v_Role AS gr ON gr.Category = 'Group' AND gr.RoleCode = pm.GroupRole INNER JOIN
                            dbo.v_Group AS g ON g.PeriodYear = pm.GroupYear AND g.PeriodSeme = pm.GroupSeme AND 
                            g.Grade = pm.GroupGrade AND g.DepartmentId = pm.DepartmentId INNER JOIN
                            dbo.v_Department AS d ON d.Id = g.DepartmentId INNER JOIN
                            dbo.v_GroupMember AS msTeacher ON msTeacher.GroupId = g.Id AND 
                            msTeacher.RoleCode = '2000' LEFT OUTER JOIN
                            dbo.v_Member AS mTeacher ON mTeacher.Id = msTeacher.MemberId

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[30] 2[25] 3) )"
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
         Begin Table = "pm"
            Begin Extent = 
               Top = 473
               Left = 387
               Bottom = 607
               Right = 563
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 9
               Left = 259
               Bottom = 220
               Right = 441
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 472
               Bottom = 206
               Right = 642
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "msTeacher"
            Begin Extent = 
               Top = 6
               Left = 680
               Bottom = 140
               Right = 917
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mTeacher"
            Begin Extent = 
               Top = 26
               Left = 17
               Bottom = 160
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gr"
            Begin Extent = 
               Top = 144
               Left = 680
               Bottom = 278
               Right = 845
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
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 2565
         Width = 1500
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_Ticket';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Width = 1500
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
         Column = 3180
         Alias = 2910
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_Ticket';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_Ticket';

