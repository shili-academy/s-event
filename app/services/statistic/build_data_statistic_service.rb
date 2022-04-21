class Statistic::BuildDataStatisticService
  def initialize event, tasks
    @event = event
    @tasks = tasks
  end

  def perform
    {
      costs_chart: Statistic::CostsChartDataService.new(@tasks).perform,
      organizational_chart: Statistic::OrganizationalChartDataService.new(@event, @tasks).perform,
      total_task_status_chart: Statistic::TotalTaskStatusService.new(@tasks).perform,
      status_chart: Statistic::StatusChartDataService.new(@tasks).perform,
      actual_costs_chart: Statistic::CostsChartDataService.new(@tasks.less_than_or_equal_to(Date.today)).perform,
      progress_chart: @tasks.group(:progress).count
    }
  end
end
