class Admin::EventsController < Admin::AdminsController
  load_and_authorize_resource

  def index
    @q = Event.ransack(params[:q])
    @events = @q.result.page(params[:page]).per(params[:per_page] || Settings.per_page)
  end
end
