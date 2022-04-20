class EventsController < ApplicationController
  before_action :load_event, only: %i(show edit update destroy)

  def index
    @events = current_user.events.order(happen_at: :desc)
  end

  def show
    @tasks = @event.tasks
    @data_chart = Statistic::BuildDataStatisticService.new(@event, @tasks).perform
    gon.id_json = @event.id
    gon.event_id = @event.id
    gon.url_new_task = new_event_task_path event_id: @event.id
  end

  def edit; end

  def update
    respond_to do |format|
      if @event.update event_params
        format.html{redirect_to event_url(@event), success: "Cập nhật thông tin sự kiện thành công"}
        format.json{render :show, status: :ok, location: @event}
      else
        format.html{render :edit, status: :unprocessable_entity}
        format.json{render json: @event.errors, status: :unprocessable_entity}
      end
    end
  end

  def create
    @event = current_user.events.new event_params
    @event.user = current_user
    if @event.save
      flash[:success] = "Tạo sự kiện thành công"
      redirect_to event_path(@event)
    else
      flash.now[:error] = @task.errors.full_messages.to_sentence
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Xóa sự kiện thành công"
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit :name, :description, :happen_at, :location, :topic_id
  end

  def load_event
    @event = current_user.events.find_by id: params[:id]
  end
end
