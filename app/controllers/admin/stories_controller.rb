class Admin::StoriesController < Admin::AdminsController


  def index
    @activities = PublicActivity::Activity.all.page(params[:page]).per(params[:per_page] || Settings.per_page)
  end
end
