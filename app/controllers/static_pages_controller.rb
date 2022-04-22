class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, except: %(home)

  def home
    @q = current_user.events.ransack(params[:q])
    @events = @q.result.page(params[:page]).per(params[:per_page] || Settings.per_page).order(happen_at: :desc)
  end
end
