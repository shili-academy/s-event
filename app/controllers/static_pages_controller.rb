class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, except: %()

  def index
    if user_signed_in?
      @q = current_user.events.ransack(params[:q])
      @events = @q.result.page(params[:page]).per(params[:per_page] || Settings.per_page).order(happen_at: :desc)
    else
      render "landing_page"
    end
  end
end
