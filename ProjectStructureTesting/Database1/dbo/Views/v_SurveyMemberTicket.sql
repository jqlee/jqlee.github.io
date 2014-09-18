CREATE VIEW dbo.v_SurveyMemberTicket
AS
SELECT          CONVERT(bit, (CASE WHEN (ps.[Enabled] = 1 AND ps.[IsPublished] = 1 AND getdate() BETWEEN ps.OpenDate AND 
                            ps.CloseDate) THEN 1 ELSE 0 END)) AS IsAvailable, p.Guid AS PaperGuid, ps.Enabled, ps.IsPublished, CONVERT(bit, 
                            ISNULL(x.RecordDone, 0)) AS IsRecordDone, CONVERT(bit, CASE WHEN x.RecordDone IS NULL THEN 0 ELSE 1 END) 
                            AS HasRecord, x.LastAccessTime, x.PublishNumber, x.PaperNumber, x.GroupDepartmentId, x.DepartmentId, 
                            x.GroupYear, x.GroupSeme, x.GroupGrade, x.GroupRole, x.MemberGrade, x.MemberRole, x.GroupId, x.GroupName, 
                            x.TeacherId, x.TeacherName, x.DepartmentName, x.MemberId, x.MemberName, x.RecordDone, 
                            x.LastAccessTime AS Expr1, ps.TargetMark, ps.Name AS PublishName, ps.OpenDate, ps.CloseDate, ps.QueryDate, 
                            ps.Guid AS PublishGuid
FROM              (SELECT          pm.PublishNumber, pm.PaperNumber, pm.GroupDepartmentId, pm.DepartmentId, pm.GroupYear, 
                                                        pm.GroupSeme, pm.GroupGrade, pm.GroupRole, pm.MemberGrade, pm.MemberRole, g.Id AS GroupId, 
                                                        g.Name AS GroupName, msTeacher.MemberId AS TeacherId, mTeacher.Name AS TeacherName, NULL 
                                                        AS DepartmentName, m.Id AS MemberId, m.Name AS MemberName, r.Done AS RecordDone, 
                                                        r.LastAccessTime
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
                                                        dbo.v_Member AS mTeacher ON mTeacher.Id = msTeacher.MemberId INNER JOIN
                                                        dbo.v_GroupMember AS ms ON ms.GroupId = g.Id AND ms.RoleCode = pm.GroupRole LEFT OUTER JOIN
                                                        dbo.v_Member AS m ON m.Id = ms.MemberId LEFT OUTER JOIN
                                                        dbo.Record AS r ON r.PublishNumber = pm.PublishNumber AND r.SurveyNumber = pm.PaperNumber AND
                                                         r.MemberId = ms.MemberId AND r.GroupId = g.Id AND r.GroupTeacherId = msTeacher.MemberId AND 
                                                        r.GroupRole = pm.GroupRole
                            UNION
                            SELECT          pm_1.PublishNumber, pm_1.PaperNumber, pm_1.GroupDepartmentId, pm_1.DepartmentId, 
                                                        pm_1.GroupYear, pm_1.GroupSeme, pm_1.GroupGrade, pm_1.GroupRole, pm_1.MemberGrade, 
                                                        pm_1.MemberRole, NULL AS GroupId, NULL AS GroupName, NULL AS TeacherId, NULL 
                                                        AS TeacherName, d.Name AS DepartmentName, m.Id AS MemberId, m.Name AS MemberName, 
                                                        r.Done AS RecordDone, r.LastAccessTime
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
                                                        dbo.v_Department AS d ON d.Id = pm_1.DepartmentId INNER JOIN
                                                        dbo.v_Member AS m ON m.DepartmentId = pm_1.DepartmentId AND (m.Grade = pm_1.MemberGrade OR
                                                        m.Grade = 0) AND m.RoleCode = pm_1.MemberRole LEFT OUTER JOIN
                                                        dbo.Record AS r ON r.PublishNumber = pm_1.PublishNumber AND 
                                                        r.SurveyNumber = pm_1.PaperNumber AND r.MemberId = m.Id AND 
                                                        r.MemberDepartmentId = pm_1.DepartmentId AND r.MemberGrade = pm_1.MemberGrade AND 
                                                        r.MemberRole = pm_1.MemberRole) AS x INNER JOIN
                            dbo.PublishSetting AS ps ON ps.Number = x.PublishNumber INNER JOIN
                            dbo.SurveyPaper AS p ON p.Number = x.PaperNumber

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
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
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
         Configuration = "(H (2[30] 3) )"
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
         Begin Table = "ps"
            Begin Extent = 
               Top = 264
               Left = 488
               Bottom = 398
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 140
               Right = 456
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
      Begin ColumnWidths = 33
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2910
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
      PaneHidden = 
      Begin ColumnWidths = 11
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyMemberTicket';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Column = 1440
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyMemberTicket';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyMemberTicket';

