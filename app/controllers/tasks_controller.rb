class TasksController < ApplicationController
  before_action :load_event, only: [:create, :show, :edit, :update, :destroy, :new]
  before_action :load_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  def show
    @show_modal_task = true
    @tasks = @event.tasks
    @data_chart = Statistic::BuildDataStatisticService.new(@event, @tasks).perform
    gon.id_json = @task.id
    gon.event_id = @task.event_id
    gon.url_new_task = new_event_task_path event_id: @event.id
    respond_to do |format|
      format.html{render "events/show"}
      format.json{render "events/show"}
      format.js
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new start_time: params[:start_time], end_time: params[:end_time] || params[:start_time]
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = @event.tasks.build(task_params)
    if @task.save
      flash[:success] = "Tạo task thành công"
      redirect_to event_task_path(event_id: @event, id: @task.id)
    else
      flash.now[:error] = @task.errors.full_messages.to_sentence
    end
  end

  # PATCH/PUT /tasks/1
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

  # DELETE /tasks/1
  def destroy
    @task.destroy
    flash[:success] = "Xóa task thành công"
    redirect_to event_path(id: @event)
  end

  private

  def load_event
    @event = current_user.events.find_by id: params[:event_id]
    add_breadcrumb @event.name, event_path(@event)
  end

  def load_task
    @task = @event.tasks.find_by id: params[:id]
    @task.parent_task ? handle_breadcrumb :
      add_breadcrumb(@task.id.to_s + "-" + truncate(@task.name, length: 20), event_task_path(event_id: @event , id: @task), remote: true)
  end

  def task_params
    params.require(:task).permit :name, :event_id, :description, :start_time, :end_time,
      :estimated_costs, :actual_costs, :progress, :parent_id, :status, {images: []}
  end

  def handle_breadcrumb
    x = @task
    sc = []
    while x
      sc << x
      x = x.parent_task

    end if x.parent_task
    sc.reverse.each do |task|
      add_breadcrumb task.id.to_s + "-" + truncate(task.name, length: 20), event_task_path(event_id: @event , id: task), remote: true
    end
  end
end
