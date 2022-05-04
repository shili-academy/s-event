class Admin::UsersController < Admin::AdminsController
  load_and_authorize_resource

  def index
    @q_user = User.ransack(params[:q])
    @users = @q_user.result.page(params[:page]).per(params[:per_page] || Settings.per_page)
  end

  def show
    @activities = PublicActivity::Activity.where(owner: params[:id]).page(params[:page]).per(params[:per_page] || Settings.per_page)
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Tạo user thành công"
      redirect_to admin_users_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
    end
  end

  def update
    user_params_changed = user_params
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      user_params_changed.delete(:password)
      user_params_changed.delete(:password_confirmation)
    end
    if ActiveModel::Type::Boolean.new.cast(user_params[:verification])
      user_params_changed[:confirmed_at] = Time.now unless @user.confirmed_at
    else
      user_params_changed[:confirmed_at] = nil
    end
    respond_to do |format|
      if @user.update user_params_changed
        format.html{redirect_to admin_users_path, success: "Cập nhật thông tin topic thành công"}
      else
        flash.now[:error] = @user.errors.full_messages.to_sentence
        format.js
      end
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Xóa User thành công"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit :first_name, :last_name, :email, :date_of_birth, :phone,
      :address, :gender, :password, :password_confirmation, :verification
  end
end
