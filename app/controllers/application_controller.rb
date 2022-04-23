class ApplicationController < ActionController::Base
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  before_action :authenticate_user!
  before_action :set_locale, :init_ransack
  add_flash_types :success, :warning, :danger, :info

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, warning: exception.message }
      format.js { head :forbidden, content_type: 'text/html' }
    end
  end

  def init_ransack
    @q ||= (current_user.events.ransack(params[:q]) if current_user)
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    else
      stored_location_for(resource) || root_path
    end
  end

  private

  def is_admin?
    return if current_user.admin?

    flash[:warning] = t "receipt.not_permissions"
    redirect_to root_url
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      new_user_session_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end
end
