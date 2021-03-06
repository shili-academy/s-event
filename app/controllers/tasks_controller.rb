class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :load_event, only: [:create, :show, :edit, :update, :destroy, :new]
  before_action :load_task, :add_breadcrumb_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
    @q = @event.tasks.ransack(params[:q])
    @tasks = @q.result.page(params[:page]).per(params[:per_page] || Settings.per_page)
    @data_chart = Statistic::BuildDataStatisticService.new(@event, @event.tasks).perform
    @show_modal_task = true
    gon.id_json = @task.id
    gon.event_id = @task.event_id
    gon.url_new_task = new_event_task_path event_id: @event.id
    respond_to do |format|
      format.html{render "events/show"}
      format.json{render "events/show"}
      format.js
    end
  end

  def new
    @task = Task.new start_time: params[:start_time], end_time: params[:end_time] || params[:start_time]
  end

  def edit; end

  def create
    @task = @event.tasks.build(task_params)
    if @task.save
      flash[:success] = "Tạo task thành công"
      redirect_to event_task_path(event_id: @event, id: @task.id)
    else
      flash.now[:error] = @task.errors.full_messages.to_sentence
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html{redirect_to event_task_path(event_id: @event, id: @task.id), success: "Cập nhật thành công"}
        flash.now[:success] = "Cập nhật thành công"
        format.js if params[:from_calendar]
      else
        flash.now[:error] = @task.errors.full_messages.to_sentence
        format.js
      end
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Xóa task thành công"
    redirect_to event_path(id: @event)
  end

  private

  def load_event
    @event = current_user.events.find_by id: params[:event_id]
    @event = Event.find_by id: params[:event_id] if current_user.admin?
    return if @event

    flash[:warning] = "Event khong ton tai"
    redirect_to root_path
  end

  def load_task
    @task = @event.tasks.find_by id: params[:id]
    return if @task

    flash[:warning] = "Task khong ton tai"
    redirect_to @event
  end

  def add_breadcrumb_task
    add_breadcrumb @event.name, event_path(@event)
    @task.parent_id ? handle_breadcrumb :
      add_breadcrumb(@task.id.to_s + "-" + truncate(@task.name, length: 20), event_task_path(event_id: @event , id: @task), remote: true)
  end

  def task_params
    params.require(:task).permit :name, :event_id, :description, :start_time, :end_time,
      :estimated_costs, :actual_costs, :progress, :parent_id, :status, {images: []}
  end

  def handle_breadcrumb
    task_temp = @task
    breadcrumbs = []
    while task_temp
      breadcrumbs << task_temp
      task_temp = task_temp.parent_task
    end if task_temp.parent_task
    breadcrumbs.reverse.each do |task|
      add_breadcrumb task.id.to_s + "-" + truncate(task.name, length: 20), event_task_path(event_id: @event , id: task), remote: true
    end
  end
end
