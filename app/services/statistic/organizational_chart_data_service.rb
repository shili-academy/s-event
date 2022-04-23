class Statistic::OrganizationalChartDataService
  include ActionView::Helpers::UrlHelper

  def initialize args
    @event = args[:event]
    @topic = args[:topic]
    @tasks = args[:tasks]
  end

  def perform
    organizational_chart_tasks = []
    @tasks.each do |task|
      organizational_chart_tasks.append([
        {
          v: "#{task.id}_" + task.name,
          f: link_to(task.name, main_path(task), remote: true, class: "text-decoration-none")
        },
        task.parent_id ? "#{task.parent_id}_" + task.parent_task.name : main_name(task), ""
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

  private

  def main_path task
    if @event
      Rails.application.routes.url_helpers.event_task_path(event_id: @event, id: task)
    else
      Rails.application.routes.url_helpers.admin_topic_task_path(topic_id: @topic, id: task)
    end
  end

  def main_name task
    if @event
      task.event.name
    else
      task.topic.name
    end
  end
end
