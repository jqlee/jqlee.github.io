
CREATE PROCEDURE [dbo].[sp_Record_UpdateStatus]
	--@number int
	@guid uniqueidentifier
	,@done bit = null
	,@lastAccessPage tinyint = null
AS
BEGIN
	SET NOCOUNT ON;

	if (exists(select 0 from [dbo].[Record] where [Guid] = @guid ))
	begin

		Update [dbo].[Record] set 

			[Done] = isNull(@done, [Done]), 
			[LastAccessPage] = isNull(@lastAccessPage, [LastAccessPage]), 
			[LastAccessTime] = getdate()

		where [Guid] = @guid 
		
		if (@done = 1)
		begin
			-- 交卷時把對應的存檔科目標記成未完成，以便排入統計的作業(順便更新回收人數跟回收率)
			-- 回收率還是移到跑RecorddTarget時才做以免跟結果報表對不起來
			/*
			declare @completeCount int = 0
			select @completeCount = sum(case when rt.Done = 1 then 1 else 0 end)
			from Record r
			inner join Record rt on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
			where r.[Guid] = @guid 
			group by r.Number;
			*/

			Update RecordTarget set [Done] = 0
				--,CompleteCount = @completeCount
				--,CompleteRate = Convert(float,case when PublishCount > 0 then Convert(float,@completeCount)/PublishCount else 0 end)
			from Record r
			inner join RecordTarget rt on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
			where r.[Guid] = @guid 

			-- 更新交卷人數

			Update PublishSetting set CompleteCount = ss.CompleteCount
				, CompleteRate = Convert(float, case when PublishCount > 0 then Convert(float,ss.CompleteCount) / PublishCount else 0 end)
			from Record r
			inner join PublishSetting ps on ps.Number = r.PublishNumber
			inner join v_SurveyStatus ss on ss.PublishNumber = ps.Number
			where r.[Guid] = @guid 


			-- 強制執行一次5秒job (以下是十分job的步驟，為避免叫用會干擾排程中的資料，直接在此執行步驟內容)
			declare @job_name nvarchar(max) = N'Survey_SaveScore_RunTargetFromQueue'
			if (exists(select 0 from SurveyDB.dbo.RecordTarget where Done = 0) and exists(select 0 from MSDB.dbo.sysjobs where Name = @job_name and [Enabled] = 0))
			begin
				exec msdb.dbo.sp_update_job @job_name=@job_name,@enabled=1
			end

		end


	end
END

/*

declare @guid uniqueidentifier = '73A729F8-3D07-4AD2-961C-B33E7C28B2E6'

declare @recordNumber int = 0
select @recordNumber = max([Number]) from Record
select @guid = [Guid] from Record where Number = @recordNumber

declare @completeCount int = 0

select PublishNumber,GroupId,GroupTeacherId,GroupRole from Record where Number = @recordNumber

select sum(case when rt.Done = 1 then 1 else 0 end)
from Record r
left outer join Record rt on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
where r.[Guid] = @guid 
group by r.Number;

select r.MemberId, r.MemberName, rt.*
from Record r
inner join RecordTarget rt on rt.PublishNumber = r.PublishNumber and rt.GroupId = r.GroupId and rt.GroupTeacherId = r.GroupTeacherId and rt.GroupRole = r.GroupRole
where r.[Guid] = @guid 

*/