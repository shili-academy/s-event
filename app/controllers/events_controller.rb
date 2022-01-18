class EventsController < ApplicationController
  def index
    @events = Event.all.order(created_at: :desc)
  end

  def create
    @event = Event.new languages_params
    @event.user = current_user
    if @event.save
      flash.now[:success] = "Thanh cong"
    else
      flash.now[:warning] = "That bai"
    end
    @events = Event.all.order(created_at: :desc)

  end

  private

  def languages_params
    params.require(:event).permit :name, :description, :happen_at
  end
end
