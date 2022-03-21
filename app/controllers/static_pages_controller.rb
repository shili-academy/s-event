class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @events = Event.all.order(happen_at: :desc)
  end
end
