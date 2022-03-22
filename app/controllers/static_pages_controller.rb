class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @events = current_user.events.order(happen_at: :desc)
    @event = Event.new
  end
end
