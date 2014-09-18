CREATE VIEW dbo.v_SurveyMatch
AS
SELECT          r.Number AS RecordNumber, r.Done AS RecordDone, ps.Number AS SurveyNumber, ps.[GuId] AS SurveyId, 
                            pd.DepartmentId, pt.GroupYear, pd.Seme as GroupSeme, pt.GroupGrade, gm.RoleCode AS GroupRole, g.Grp AS GroupGrp, NULL
                             AS MemberGrade, NULL AS MemberRole, gm.GroupId, g.Name AS GroupName, gmt.MemberId AS TeacherId, 
                            gm.MemberId AS MemberId, NULL AS MemberGrp
FROM              PublishSetting ps 
INNER JOIN PublishTarget pt ON pt.PublishNumber = ps.Number 
INNER JOIN PublishDepartment pd ON pd.PublishNumber = ps.Number 
INNER JOIN v_Group g ON g.DepartmentId = pd.DepartmentId AND g.Year = pt.GroupYear AND g.Seme = pd.Seme AND g.Grade = pt.GroupGrade 
							INNER JOIN v_GroupMember gmt ON gmt.GroupId = g.Id AND gmt.RoleCode = '2000' INNER JOIN
                            v_GroupMember gm ON gm.GroupId = g.Id AND gm.RoleCode = pt.GroupRole LEFT OUTER JOIN
                            Record r ON r.PublishNumber = ps.Number AND r.MemberId = gm.MemberId AND r.GroupId = gm.GroupId AND 
                            r.GroupTeacherId = gmt.MemberId AND r.GroupDepartmentId = pd.DepartmentId AND r.GroupYear = pt.GroupYear AND
                             r.GroupSeme = pd.Seme AND r.GroupGrade = pt.GroupGrade AND r.GroupRole = pt.GroupRole AND 
                            r.GroupTeacherId = gmt.MemberId
UNION
SELECT          r.Number AS RecordNumber, r.Done AS RecordDone, ps.Number AS SurveyNumber, ps.[GuId] AS SurveyId, 
                            pd.DepartmentId, NULL AS GroupYear, NULL AS GroupSeme, NULL AS GroupGrade, NULL AS GroupRole, NULL 
                            AS GroupGrp, pt.MemberGrade, pt.MemberRole, NULL AS GroupId, NULL AS GroupName, NULL AS TeacherId, 
                            m.Id AS MemberId, m.Grp AS MemberGrp
FROM              PublishSetting ps INNER JOIN
                            PublishTarget pt ON pt.PublishNumber = ps.Number INNER JOIN
                            PublishDepartment pd ON pd.PublishNumber = ps.Number INNER JOIN
                            v_Member m ON m.DepartmentId = pd.DepartmentId AND m.Grade = pt.MemberGrade AND 
                            m.RoleCode = pt.MemberRole INNER JOIN
                            v_Department d ON d .Id = pd.DepartmentId LEFT OUTER JOIN
                            Record r ON r.PublishNumber = ps.Number AND r.MemberId = m.Id AND 
                            r.MemberDepartmentId = pd.DepartmentId AND r.MemberGrade = pt.MemberGrade AND 
                            r.MemberRole = pt.MemberRole

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
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyMatch';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_SurveyMatch';

