class EventsController < ApplicationController
  before_action :load_event, only: %i(show edit update destroy)

  def index
    @events = current_user.events.order(happen_at: :desc)
  end

  def show
    @tasks = @event.tasks
    gon.event_id = @event.id
    gon.url = change_time_event_tasks_path event_id: @event.id
  end

  def edit; end

  def update
    respond_to do |format|
      if @event.update event_params
        format.html{redirect_to event_url(@event), notice: "Successfully"}
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
      flash.now[:success] = "Thanh cong"
    else
      flash.now[:warning] = "That bai"
    end
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit :name, :description, :happen_at, :location, :topic_id
  end

  def load_event
    @event = current_user.events.find_by id: params[:id]
  end
end
