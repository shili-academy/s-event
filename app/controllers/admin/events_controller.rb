class Admin::EventsController < Admin::AdminsController
  load_and_authorize_resource
  before_action :load_event, only: %i(show edit update destroy)

  def index
    @events = current_user.events.order(happen_at: :desc)
  end
end
