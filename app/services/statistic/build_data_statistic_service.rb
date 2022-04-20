class Statistic::BuildDataStatisticService
  def initialize event, tasks
    @event = event
    @tasks = tasks
  end

  def perform
    {
      costs_chart: Statistic::CostsChartDataService.new(@tasks).perform,
      organizational_chart: Statistic::OrganizationalChartDataService.new(@event, @tasks).perform,
      total_task_status: Statistic::TotalTaskStatusService.new(@tasks).perform
    }
  end
end
