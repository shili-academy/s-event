class TasksController < ApplicationController
  before_action :load_event, only: [:create, :show, :edit, :update, :destroy]
  before_action :load_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = @event.tasks.build(task_params)

    if @task.save
      render json: "OK", status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private

  def load_event
    @event = current_user.events.find_by id: params[:event_id]
  end

  def load_task
    @task = @event.tasks.find_by id: params[:id]
  end


  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit :name, :event_id, :description, :start_time, :end_time, :estimated_costs, :actual_costs, :location, :progress
  end
end
