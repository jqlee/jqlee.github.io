CREATE VIEW dbo.v_TargetMember
AS
SELECT t .Number AS TargetNumber, g.DepartmentId, g.Id AS MatchItem, g.Id + ' ' + g.Name as MatchName
, gm.MemberId, m.RoleCode, r.Number as RecordNumber
FROM TargetForDepartment t 
INNER JOIN v_DepartmentGroup g ON g.DepartmentId = t .DepartmentId AND g.GroupYear = t .GroupYear 
INNER JOIN v_GroupMember gm ON gm.GroupId = g.Id 
INNER JOIN v_Member m ON m.Id = gm.MemberId AND m.[Enabled] = 1 AND m.RoleCode = t .RoleCode
left outer join Record r on r.MemberId = m.Id and r.SurveyNumber = t.SurveyNumber and r.DepartmentId =t.DepartmentId 
	and r.GroupId = g.Id
WHERE (t.TargetMark = 1 OR t.TargetMark = 4) AND gm.[Enabled] = 1
UNION
SELECT         
t .Number AS TargetNumber, m.DepartmentId, CONVERT(varchar(4), m.Grade) AS MatchItem
,gl.Name as MatchName
, m.Id AS MemberId
, m.RoleCode, r.Number as RecordNumber
FROM TargetForDepartment t 
INNER JOIN v_Member m ON m.DepartmentId = t .DepartmentId AND m.Grade = t.MemberGrade AND m.[Enabled] = 1 AND m.RoleCode = t.RoleCode
inner join fnGetGradeList() gl on gl.Value = m.Grade
left outer join Record r on r.MemberId = m.Id and r.SurveyNumber = t.SurveyNumber and r.DepartmentId =t.DepartmentId 
	and r.MemberGrade = t.MemberGrade
WHERE  
(t .TargetMark = 2 OR t .TargetMark = 3)


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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_TargetMember';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_TargetMember';

