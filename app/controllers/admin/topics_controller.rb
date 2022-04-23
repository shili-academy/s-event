class Admin::TopicsController < Admin::AdminsController
  load_and_authorize_resource
  before_action :load_event, only: %i(show edit update destroy)

  def index
    @topics = Topic.order(created_at: :desc)
  end
end
