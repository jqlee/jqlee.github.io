/*AND r.DepartmentId = x.DepartmentId AND r.GroupId = isNull(x.GroupId,r.GroupId)*/
CREATE VIEW dbo.v_TargetMatch
AS
SELECT          x.SurveyNumber, x.TargetMark, x.DepartmentId, x.MatchKey, x.GroupId, x.MemberGrade, x.MemberId, x.RoleCode, 
                            r.Number AS RecordNumber, r.Done AS RecordIsCompleted
FROM              (SELECT          s.Number AS SurveyNumber, s.TargetMark, t.DepartmentId, t.MatchKey, gm.GroupId, NULL 
                                                        AS MemberGrade, gm.MemberId, m.RoleCode
                            FROM               dbo.Survey AS s INNER JOIN
                                                        dbo.Target AS t ON t.SurveyNumber = s.Number LEFT OUTER JOIN
                                                        dbo.v_GroupMember AS gm ON gm.GroupId = t.GroupId AND gm.Enabled = 1 AND 
                                                        gm.RoleCode = t.RoleCode INNER JOIN
                                                        dbo.v_Member AS m ON m.Id = gm.MemberId AND m.Enabled = 1
                            WHERE           (s.TargetMark = 1) OR
                                                        (s.TargetMark = 4)
                            UNION
                            SELECT          s.Number AS SurveyNumber, s.TargetMark, m.DepartmentId, t.MatchKey, NULL AS GroupId, 
                                                        m.Grade AS MemberGrade, m.Id AS MemberId, m.RoleCode
                            FROM              dbo.Survey AS s INNER JOIN
                                                        dbo.Target AS t ON t.SurveyNumber = s.Number LEFT OUTER JOIN
                                                        dbo.v_Member AS m ON m.DepartmentId = t.DepartmentId AND m.Grade = t.MemberGrade AND 
                                                        m.Enabled = 1 AND m.RoleCode = t.RoleCode INNER JOIN
                                                        dbo.fnGetGradeList() AS gl ON gl.Value = m.Grade AND m.Enabled = 1
                            WHERE          (s.TargetMark = 2) OR
                                                        (s.TargetMark = 3)) AS x LEFT OUTER JOIN
                            dbo.Record AS r ON r.MemberId = x.MemberId AND r.MatchKey = x.MatchKey

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[21] 2[39] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
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
         Configuration = "(H (2[44] 3) )"
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
         Begin Table = "r"
            Begin Extent = 
               Top = 6
               Left = 268
               Bottom = 140
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "x"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 140
               Right = 211
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_TargetMatch';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_TargetMatch';

