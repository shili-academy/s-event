class Statistic::TotalTaskStatusService
  def initialize tasks
    @tasks = tasks
    @task_status = {open: 0, in_progress: 0, pending: 0, completed: 0, total: @tasks.size}
  end

  def perform
    @tasks.each do |task|
      @task_status[task.status.to_sym] += 1
    end
    @task_status
  end
end
