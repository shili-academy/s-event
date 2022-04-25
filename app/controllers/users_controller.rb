class UsersController < ApplicationController
  before_action :load_user, only: [:show]

  skip_before_action :authenticate_user!, except: %(show)


  def show; end

  def signin
  end

  def signup
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.nil"
    redirect_to root_path
  end
end
