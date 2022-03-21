module ApplicationHelper
  include Turbo::IncludesHelper

  def full_title page_title = ""
    base_title = t "title_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
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
end
