module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def current_namespace
    params[:controller].split("/").first.to_sym
  end

  def color_alert message_type
    case message_type
    when "alert"
      :yellow
    when "error"
      :red
    when "notice"
      :indigo
    when "success"
      :green
    when "info"
      :blue
    else
      :gray
    end
  end

  def parse_time time
   time.strftime(Settings.format_time_view) if time
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
