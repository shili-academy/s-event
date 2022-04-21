class Statistic::StatusChartDataService
  def initialize tasks
    @tasks = tasks
  end

  def perform
    [
      {name: "Open" , data: @tasks.open.group_by_day(:start_time).count, color: "#6c757d"},
      {name: "In progress" , data: @tasks.in_progress.group_by_day(:start_time).count, color: "#0d6efd"},
      {name: "Pending" , data: @tasks.pending.group_by_day(:start_time).count, color: "#ffc107"},
      {name: "Completed" , data: @tasks.completed.group_by_day(:start_time).count, color: "#198754"}
    ]
  end
end
