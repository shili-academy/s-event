module TasksHelper
  def color_completion_rate value
    case value
    when 0..20
      "bg-0_20"
    when 21..40
      "bg-21_40"
    when 41..60
      "bg-41_60"
    when 61..80
      "bg-61_80"
    when 80..99
      "bg-81_99"
    else
      "bg-100"
    end
  end

  def status_color status
    case status
    when "open"
      "bg-secondary"
    when "in_progress"
      "bg-primary"
    when "pending"
      "bg-warning text-dark"
    when "completed"
      "bg-success"
    else
      "bg-dark"
    end
  end
end
