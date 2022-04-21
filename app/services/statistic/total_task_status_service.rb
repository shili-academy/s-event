class Statistic::TotalTaskStatusService
  def initialize tasks
    @tasks = tasks
    @task_status = {open: 0, in_progress: 0, pending: 0, completed: 0}
  end

  def perform
    @tasks.each do |task|
      @task_status[task.status.to_sym] += 1
    end
    {
      data: @task_status.to_a,
      colors: ["#6c757d", "#0d6efd", "#ffc107", "#198754"]
    }
  end
end
