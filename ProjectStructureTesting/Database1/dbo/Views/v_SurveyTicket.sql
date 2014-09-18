CREATE VIEW dbo.v_SurveyTicket
AS
SELECT          x.PublishNumber, x.PaperNumber, x.GroupDepartmentId, x.DepartmentId, x.GroupYear, x.GroupSeme, x.GroupGrade, 
                            x.GroupRole, x.MemberGrade, x.MemberRole, x.GroupId, x.GroupName, x.TeacherId, x.TeacherName, 
                            x.DepartmentName, p.Guid AS PaperGuid, ps.TargetMark, ps.Name AS PublishName, ps.OpenDate, ps.CloseDate, 
                            ps.QueryDate, ps.Guid AS PublishGuid, rg.RoleName AS GroupRoleName, rm.RoleName AS MemberRoleName
FROM              (SELECT          pm.PublishNumber, pm.PaperNumber, pm.GroupDepartmentId, pm.DepartmentId, pm.GroupYear, 
                                                        pm.GroupSeme, pm.GroupGrade, pm.GroupRole, pm.MemberGrade, pm.MemberRole, g.Id AS GroupId, 
                                                        g.Name AS GroupName, msTeacher.MemberId AS TeacherId, mTeacher.Name AS TeacherName, NULL 
                                                        AS DepartmentName
                            FROM               (SELECT          ps.Number AS PublishNumber, p.Number AS PaperNumber, 
                                                                                     pd.DepartmentId AS GroupDepartmentId, NULL AS DepartmentId, pt.GroupYear, 
                                                                                     pt.GroupSeme, pt.GroupGrade, pt.GroupRole, NULL AS MemberGrade, NULL 
                                                                                     AS MemberRole
                                                         FROM               dbo.PublishSetting AS ps INNER JOIN
                                                                                     dbo.PublishTarget AS pt ON pt.PublishNumber = ps.Number INNER JOIN
                                                                                     dbo.PublishDepartment AS pd ON pd.PublishNumber = ps.Number INNER JOIN
                                                                                     dbo.SurveyPaper AS p ON p.PublishNumber = ps.Number AND 
                                                                                     p.PublishVersion = ps.LastPublishVersion
                                                         WHERE           (ps.IsPublished = 1) AND (ps.Enabled = 1) AND (ps.TargetMark = 1)
                                                         GROUP BY    ps.Number, p.Number, pd.DepartmentId, pt.GroupYear, pt.GroupSeme, pt.GroupGrade, 
                                                                                     pt.GroupRole) AS pm INNER JOIN
                                                        dbo.v_Group AS g ON g.PeriodYear = pm.GroupYear AND g.PeriodSeme = pm.GroupSeme AND 
                                                        g.Grade = pm.GroupGrade AND g.DepartmentId = pm.GroupDepartmentId INNER JOIN
                                                        dbo.v_GroupMember AS msTeacher ON msTeacher.GroupId = g.Id AND 
                                                        msTeacher.RoleCode = '2000' LEFT OUTER JOIN
                                                        dbo.v_Member AS mTeacher ON mTeacher.Id = msTeacher.MemberId
                            UNION
                            SELECT          pm_1.PublishNumber, pm_1.PaperNumber, pm_1.GroupDepartmentId, pm_1.DepartmentId, 
                                                        pm_1.GroupYear, pm_1.GroupSeme, pm_1.GroupGrade, pm_1.GroupRole, pm_1.MemberGrade, 
                                                        pm_1.MemberRole, NULL AS GroupId, NULL AS GroupName, NULL AS TeacherId, NULL 
                                                        AS TeacherName, d.Name AS DepartmentName
                            FROM              (SELECT          ps.Number AS PublishNumber, p.Number AS PaperNumber, NULL AS GroupDepartmentId, 
                                                                                    pd.DepartmentId, NULL AS GroupYear, NULL AS GroupSeme, NULL AS GroupGrade, NULL 
                                                                                    AS GroupRole, pt.MemberGrade, pt.MemberRole
                                                        FROM               dbo.PublishSetting AS ps INNER JOIN
                                                                                    dbo.PublishTarget AS pt ON pt.PublishNumber = ps.Number INNER JOIN
                                                                                    dbo.PublishDepartment AS pd ON pd.PublishNumber = ps.Number INNER JOIN
                                                                                    dbo.SurveyPaper AS p ON p.PublishNumber = ps.Number AND 
                                                                                    p.PublishVersion = ps.LastPublishVersion
                                                        WHERE           (ps.IsPublished = 1) AND (ps.Enabled = 1) AND (ps.TargetMark = 2)
                                                        GROUP BY    ps.Number, p.Number, pd.DepartmentId, pt.MemberGrade, pt.MemberRole) 
                                                        AS pm_1 INNER JOIN
                                                        dbo.v_Department AS d ON d.Id = pm_1.DepartmentId) AS x INNER JOIN
                            dbo.PublishSetting AS ps ON ps.Number = x.PublishNumber INNER JOIN
                            dbo.SurveyPaper AS p ON p.Number = x.PaperNumber LEFT OUTER JOIN
                            dbo.v_Role AS rg ON rg.Category = 'Group' AND rg.RoleCode = x.GroupRole LEFT OUTER JOIN
                            dbo.v_Role AS rm ON rm.Category = 'Member' AND rm.RoleCode = x.MemberRole

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[12] 2[31] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
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
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
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
         Begin Table = "ps"
            Begin Extent = 
               Top = 144
               Left = 38
               Bottom = 278
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 317
               Bottom = 140
               Right = 493
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rg"
            Begin Extent = 
               Top = 6
               Left = 531
               Bottom = 122
               Right = 696
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rm"
            Begin Extent = 
               Top = 6
               Left = 734
               Bottom = 122
               Right = 899
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "x"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 140
               Right = 242
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
      Begin ColumnWidths = 23
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2190
         Width = 3165
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyTicket';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Width = 1500
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
      PaneHidden = 
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyTicket';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyTicket';

