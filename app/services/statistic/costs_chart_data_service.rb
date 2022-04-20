class Statistic::CostsChartDataService
  def initialize tasks
    @tasks = tasks
    @estimated_costs = @tasks.pluck(:estimated_costs).sum
    @actual_costs = @tasks.pluck(:actual_costs).sum
  end

  def perform
    {
      data: data_pie_chart,
      colors: color_pie_chart
    }
  end

  private

  def data_pie_chart
    if @estimated_costs > @actual_costs
      [
        ["Chênh lệch", (@estimated_costs - @actual_costs)],
        ["Thực tế", @actual_costs],
        ["Ước tính", @estimated_costs]
      ]
    else
      [
        ["Chênh lệch", (@actual_costs - @estimated_costs)],
        ["Ước tính", @estimated_costs],
        ["Thực tế", @actual_costs]
      ]
    end
  end

  def color_pie_chart
    if @estimated_costs > @actual_costs
      ["#00C897", "#417D7A", "#61A4BC"]
    else
      ["#C74B50", "#61A4BC", "#417D7A"]
    end
  end
end
