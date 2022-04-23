class EventsController < ApplicationController
  load_and_authorize_resource
  before_action :load_event, only: %i(show edit update destroy)

  def index
    @events = current_user.events.order(happen_at: :desc)
  end

  def show
    @q = @event.tasks.ransack(params[:q])
    @tasks = @q.result.page(params[:page]).per(params[:per_page] || Settings.per_page)
    @data_chart = Statistic::BuildDataStatisticService.new(@event, @event.tasks).perform
    gon.id_json = @event.id
    gon.event_id = @event.id
    gon.url_new_task = new_event_task_path event_id: @event.id
  end

  def new; end

  def edit; end

  def update
    respond_to do |format|
      if @event.update event_params
        format.html{redirect_to (current_user.admin? ? admin_events_path : event_url(@event)), success: "Cập nhật thông tin sự kiện thành công"}
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
      redirect_to (current_user.admin? ? admin_events_path : event_url(@event))
    else
      flash.now[:error] = @event.errors.full_messages.to_sentence
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Xóa sự kiện thành công"
    redirect_to (current_user.admin? ? admin_events_path : root_path)
  end

  private

  def event_params
    params.require(:event).permit :name, :description, :happen_at, :location, :topic_id
  end

  def load_event
    @event = current_user.events.find_by id: params[:id]
    @event = Event.find_by id: params[:id] if current_user.admin?

    return if @event

    flash[:warning] = "Event khong ton tai"
    redirect_to root_path
  end
end
