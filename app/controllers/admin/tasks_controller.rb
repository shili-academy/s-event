class Admin::TasksController < Admin::AdminsController
  load_and_authorize_resource
  before_action :load_topic, only: [:create, :show, :edit, :update, :destroy, :new]
  before_action :add_breadcrumb_task, only: [:show]

  def index

  end

  def show
    @tasks = @topic.tasks
    @data_chart = {
      organizational_chart: Statistic::OrganizationalChartDataService.new({topic: @topic, tasks: @tasks}).perform
    }
    @show_modal_task = true
    respond_to do |format|
      format.html{render "admin/topics/show"}
      format.js
    end
  end

  def new
    @task = Task.new start_time: params[:start_time], end_time: params[:end_time] || params[:start_time]
  end

  def edit; end

  def create
    @task = @topic.tasks.build(task_params)
    if @task.save
      flash[:success] = "Tạo task thành công"
      redirect_to admin_topic_task_path(topic_id: @topic, id: @task)
    else
      flash.now[:error] = @task.errors.full_messages.to_sentence
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html{redirect_to admin_topic_task_path(topic_id: @topic, id: @task), success: "Cập nhật thành công"}
        flash.now[:success] = "Cập nhật thành công"
        format.js
      else
        flash.now[:error] = @task.errors.full_messages.to_sentence
        format.js
      end
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Xóa task thành công"
    redirect_to admin_topic_path @topic
  end

  private

  def task_params
    params.require(:task).permit :name, :description, :estimated_costs, :parent_id, :topic_id
  end

  def load_topic
    @topic = Topic.find_by id: params[:topic_id]
    return if @topic

    flash[:warning] = "Topic khong ton tai"
    redirect_to admin_topics_path
  end

  def add_breadcrumb_task
    add_breadcrumb @topic.name, admin_topic_path(@topic)
    @task.parent_id ? handle_breadcrumb :
      add_breadcrumb(@task.id.to_s + "-" + truncate(@task.name, length: 20), admin_topic_task_path(topic_id: @topic , id: @task), remote: true)
  end

  def handle_breadcrumb
    task_temp = @task
    breadcrumbs = []
    while task_temp
      breadcrumbs << task_temp
      task_temp = task_temp.parent_task
    end if task_temp.parent_task
    breadcrumbs.reverse.each do |task|
      add_breadcrumb task.id.to_s + "-" + truncate(task.name, length: 20), admin_topic_task_path(event_id: @topic , id: task), remote: true
    end
  end
end
