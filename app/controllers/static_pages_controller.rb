class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @events = Event.all.order(created_at: :desc)
  end
end
