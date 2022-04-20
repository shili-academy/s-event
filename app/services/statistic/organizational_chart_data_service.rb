class Statistic::OrganizationalChartDataService
  include ActionView::Helpers::UrlHelper

  def initialize event, tasks
    @event = event
    @tasks = tasks
  end

  def perform
    organizational_chart_tasks = []
    @tasks.each do |task|
      path = Rails.application.routes.url_helpers.event_task_path(event_id: @event, id: task)
      organizational_chart_tasks.append([
        {v: task.name, f: link_to(task.name, path, remote: true)},
        task.parent_id ? task.parent_task.name : task.event.name ,
        ""
      ])
    end
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column("string", "Name")
    data_table.new_column("string", "Manager")
    data_table.new_column("string", "ToolTip")
    data_table.add_rows(organizational_chart_tasks)
    opts = {allowHtml: true}
    GoogleVisualr::Interactive::OrgChart.new(data_table, opts)
  end
end
