class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  layout "layouts/admin/application"

  def index
      
  end
end
