class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    flash[:alert] = "authenticate_user authenticate_user authenticate_user"
  end
end
