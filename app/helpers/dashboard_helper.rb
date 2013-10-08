module DashboardHelper
  def remainingDaysClass(days)
    if days < Rails.application.config.advertise_warning_limit
      return "warning"
    elsif days < 1
      return "error"
    end
  end
end
